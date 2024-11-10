import React, { useCallback, useContext, useEffect, useState } from 'react';
import { RouteComponentProps } from 'react-router';
import {
    IonButton,
    IonContent,
    IonHeader,
    IonInput,
    IonLoading,
    IonPage,
    IonText,
    IonTitle,
    IonToolbar
} from '@ionic/react';
import { AuthContext } from './AuthProvider';
import { getLogger } from '../core';
import { useNetwork } from "../todo/useNetwork";
import { usePreferences } from "../todo/usePreferences";

const log = getLogger('Login');

interface LoginState {
    username: string;
    password: string;
}

const initialState: LoginState = {
    username: '',
    password: '',
}

export const Login: React.FC<RouteComponentProps> = ({ history }) => {
    const { networkStatus } = useNetwork();
    const { isAuthenticated, isAuthenticating, login, authenticationError } = useContext(AuthContext);
    const { getAuthToken } = usePreferences();
    const [state, setState] = useState<LoginState>(initialState);
    const { username, password } = state;

    const handlePasswordChange = useCallback((e: any) => setState({
        ...state,
        password: e.detail.value || ''
    }), [state]);

    const handleUsernameChange = useCallback((e: any) => setState({
        ...state,
        username: e.detail.value || ''
    }), [state]);

    const [attemptingLogin, setAttemptingLogin] = useState(false);

    const handleLogin = useCallback(async () => {
        log('handleLogin...');

        if (isAuthenticated) {
            log('User already authenticated, redirecting to /books');
            history.push('/books');
            return;
        }

        setAttemptingLogin(true);

        await login?.(username, password);

        setAttemptingLogin(false);
    }, [username, password, isAuthenticated, login, history]);

    useEffect(() => {
        const checkAuthStatus = async () => {
            const token = await getAuthToken();
            if (token) {
                log('Token found, redirecting to /books');
                history.push('/books');
            } else if (isAuthenticated) {
                log('User authenticated, redirecting to /books');
                history.push('/books');
            }
        };
        checkAuthStatus();
    }, [isAuthenticated, history, getAuthToken]);


    return (
        <IonPage>
            <IonHeader>
                <IonToolbar>
                    <IonTitle>Login</IonTitle>
                    <IonText slot="end" color={networkStatus.connected ? 'success' : 'danger'} style={{ paddingRight: '16px' }}>
                        {networkStatus.connected ? 'Online' : 'Offline'}
                    </IonText>
                </IonToolbar>
            </IonHeader>
            <IonContent>
                <IonInput placeholder="Username" value={username} onIonChange={handleUsernameChange} />
                <IonInput placeholder="Password" value={password} onIonChange={handlePasswordChange} />
                <IonLoading isOpen={isAuthenticating || attemptingLogin} />
                {authenticationError && (
                    <div>{authenticationError || 'Failed to authenticate'}</div>
                )}
                <IonButton onClick={handleLogin}>Login</IonButton>
            </IonContent>
        </IonPage>
    );
};
