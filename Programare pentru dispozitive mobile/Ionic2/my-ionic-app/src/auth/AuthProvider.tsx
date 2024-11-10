import React, { useCallback, useEffect, useState } from 'react';
import PropTypes from 'prop-types';
import { login as loginApi } from './authApi';
import { getLogger } from '../core';
import { usePreferences } from "../todo/usePreferences";

const log = getLogger('AuthProvider');

type LoginFn = (username: string, password: string) => Promise<void>;
type LogoutFn = () => Promise<void>;

export interface AuthState {
    authenticationError: string;
    isAuthenticated: boolean;
    isAuthenticating: boolean;
    token: string;
    login?: LoginFn;
    logout?: LogoutFn;
}

const initialState: AuthState = {
    isAuthenticated: false,
    isAuthenticating: false,
    authenticationError: '',
    token: '',
};

export const AuthContext = React.createContext<AuthState>(initialState);

interface AuthProviderProps {
    children: PropTypes.ReactNodeLike,
}

export const AuthProvider: React.FC<AuthProviderProps> = ({ children }) => {
    const [state, setState] = useState<AuthState>(initialState);
    const { setAuthToken, getAuthToken, removeAuthToken, removeItemsLocal} = usePreferences();

    const loginCallback = useCallback<LoginFn>(async (username: string, password: string) => {
        setState(prevState => ({ ...prevState, isAuthenticating: true, authenticationError: '' }));
        try {
            const { token } = await loginApi(username, password);
            await setAuthToken(token);
            setState({ ...initialState, isAuthenticated: true, token });
        } catch (error) {
            log('Login failed:', error);
            setState(prevState => ({ ...prevState, authenticationError: 'AUTH_ERROR', isAuthenticating: false }));
        }
    }, [setAuthToken]);

    const logoutCallback = useCallback<LogoutFn>(async () => {
        await removeAuthToken();
        await removeItemsLocal();
        setState(initialState);
    }, [removeAuthToken]);

    const login = useCallback<LoginFn>(loginCallback, [loginCallback]);
    const logout = useCallback<LogoutFn>(logoutCallback, [logoutCallback]);

    const value = {
        isAuthenticated: state.isAuthenticated,
        isAuthenticating: state.isAuthenticating,
        authenticationError: state.authenticationError,
        token: state.token,
        login,
        logout,
    };

    useEffect(() => {
        const checkToken = async () => {
            const token = await getAuthToken();
            if (token && !state.isAuthenticated) {
                setState(prevState => ({ ...prevState, isAuthenticated: true, token }));
            }
        };
        checkToken();
    }, [getAuthToken, state.isAuthenticated]);

    return (
        <AuthContext.Provider value={value}>
            {children}
        </AuthContext.Provider>
    );
};
