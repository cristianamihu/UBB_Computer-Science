import React, {useCallback, useContext, useEffect, useReducer, useRef, useState} from 'react';
import PropTypes from 'prop-types';
import { getLogger } from '../core';
import { ItemProps } from './ItemProps';
import { addItemApi, getItems, newWebSocket, updateItemApi, deleteItemApi } from './itemApi';
import { AuthContext } from "../auth/AuthProvider";
import {usePreferences} from "./usePreferences";
import {useNetwork} from "./useNetwork";

const log = getLogger('ItemProvider');

type SaveItemFn = (item: ItemProps, networkStatusConnected: boolean) => Promise<any>;
type DeleteItemFn = (item: ItemProps, networkStatusConnected: boolean) => Promise<any>;
type UpdateItemFn = (item: ItemProps, networkStatusConnected: boolean) => Promise<any>;
type CompleteItemFn = (item: ItemProps) => Promise<any>;

const ITEMS_PER_PAGE = 5;

export interface ItemsState {
    items?: ItemProps[],
    fetching: boolean,
    fetchingError?: Error | null,
    saving: boolean,
    savingError?: Error | null,
    saveItem?: SaveItemFn,
    deleteItem?: DeleteItemFn,
    updateItem?: UpdateItemFn,
    completeItem?: CompleteItemFn,
    fetchItems?: () => Promise<void>,
}

interface ActionProps {
    type: string,
    payload?: any,
}

const initialState: ItemsState = {
    items: [],
    fetching: false,
    saving: false,
};

const FETCH_ITEMS_STARTED = 'FETCH_ITEMS_STARTED';
const FETCH_ITEMS_SUCCEEDED = 'FETCH_ITEMS_SUCCEEDED';
const FETCH_ITEMS_FAILED = 'FETCH_ITEMS_FAILED';
const ADD_ITEM_STARTED = 'ADD_ITEM_STARTED';
const ADD_ITEM_SUCCEEDED = 'ADD_ITEM_SUCCEEDED';
const ADD_ITEM_FAILED = 'ADD_ITEM_FAILED';
const COMPLETE_ITEM_STARTED = 'COMPLETE_ITEM_STARTED';
const COMPLETE_ITEM_SUCCEEDED = 'COMPLETE_ITEM_SUCCEEDED';
const COMPLETE_ITEM_FAILED = 'COMPLETE_ITEM_FAILED';
const REMOVE_ITEM_STARTED = 'REMOVE_ITEM_STARTED';
const REMOVE_ITEM_SUCCEEDED = 'REMOVE_ITEM_SUCCEEDED';
const REMOVE_ITEM_FAILED = 'REMOVE_ITEM_FAILED';
const UPDATE_ITEM_STARTED = 'UPDATE_ITEM_STARTED';
const UPDATE_ITEM_SUCCEEDED = 'UPDATE_ITEM_SUCCEEDED';
const UPDATE_ITEM_FAILED = 'UPDATE_ITEM_FAILED';

const {
    saveItemLocal,
    updateItemLocal,
    setItemsLocal,
    getDeletedItemsLocal,
    setDeletedItemsLocal,
    clearDeletedItemsLocal,
    clearUpdatedItemsLocal,
    getAddedItemsLocal,
    clearAddedItemsLocal,
    getItemsLocal,
    getUpdatedItemsLocal,
    setUpdatedItemsLocal,
    deleteItemLocal,
    setAddedItemsLocal
} = usePreferences();

const reducer: (state: ItemsState, action: ActionProps) => ItemsState =
    (state, { type, payload }) => {
        switch (type) {
            case FETCH_ITEMS_STARTED:
                return { ...state, fetching: true };
            case FETCH_ITEMS_SUCCEEDED:
                setItemsLocal(payload.items);
                return { ...state, items: payload.items, fetching: false };
            case FETCH_ITEMS_FAILED:
                return { ...state, fetching: false, fetchingError: payload.error };
            case ADD_ITEM_STARTED:
                return { ...state, saving: true };
            case ADD_ITEM_SUCCEEDED:
                let items = [...(state.items || [])];
                let item = payload.item;
                const index = items.findIndex(it => it._id === item._id);
                if (index === -1) {
                    items.splice(0, 0, item);
                } else {
                    items[index] = item;
                }
                setItemsLocal(items);
                return { ...state, items, saving: false };
            case ADD_ITEM_FAILED:
                return { ...state, saving: false, savingError: payload.error };
            case COMPLETE_ITEM_STARTED:
                return { ...state, saving: true };
            case COMPLETE_ITEM_SUCCEEDED:
                return { ...state, saving: false };
            case COMPLETE_ITEM_FAILED:
                return { ...state, saving: false, fetchingError: payload.error };
            case REMOVE_ITEM_STARTED:
                return { ...state, saving: true };
            case REMOVE_ITEM_SUCCEEDED: {
                let items = [...(state.items || [])];
                items = items.filter(it => it._id !== payload._id);
                setItemsLocal(items);
                return { ...state, items, saving: false };
            }
            case REMOVE_ITEM_FAILED:
                return { ...state, saving: false, fetchingError: payload.error };
            case UPDATE_ITEM_STARTED:
                return { ...state, saving: true };
            case UPDATE_ITEM_SUCCEEDED: {
                let items = [...(state.items || [])];
                let item = payload.item;
                const index = items.findIndex(it => it._id === item._id);
                if (index !== -1) {
                    items[index] = { ...items[index], ...item };
                }
                setItemsLocal(items);
                return { ...state, items, saving: false };
            }
            case UPDATE_ITEM_FAILED:
                return { ...state, saving: false, fetchingError: payload.error };
            default:
                return state;
        }
    };


export const ItemContext = React.createContext<ItemsState>(initialState);

interface ItemProviderProps {
    children: PropTypes.ReactNodeLike,
}

export const ItemProvider: React.FC<ItemProviderProps> = ({ children }) => {
    const { token } = useContext(AuthContext);
    const [ state, dispatch ] = useReducer(reducer, initialState);
    const { items, fetching, fetchingError, saving, savingError } = state;
    const { networkStatus } = useNetwork();

    useEffect(() => {
        if (networkStatus.connected) {
            syncLocalData();
        }
    }, [networkStatus.connected]);

    async function syncLocalData() {
        log('Syncing local data to server');
        const addedItems = await getAddedItemsLocal();
        const deletedItems = await getDeletedItemsLocal();
        const  updatedItems = await getUpdatedItemsLocal();

        if (addedItems && addedItems.length > 0) {
            const unsyncedItems = [];

            for (const item of addedItems) {
                log("Syncing addedItems");
                try {
                    await addItemApi(token, item);
                    log(`Item ${item._id || item.title} synced`);
                } catch (error) {
                    log(`Failed to sync item ${item._id || item.title}`, error);
                    unsyncedItems.push(item);
                }
                clearAddedItemsLocal();
            }
        }

        if (deletedItems && deletedItems.length > 0) {
            log("Syncing deletedItems");
            for(const item of deletedItems) {
                try {
                    await deleteItemApi(token, item);
                    log(`Deletion of item ${item._id || item.title} synced`);
                } catch (error) {
                    log(`Failed to sync deletion of item ${item._id || item.title}`, error);
                }
            }
            clearDeletedItemsLocal();
        }

        if (updatedItems && updatedItems.length > 0) {
            log("Syncing updated");
            for (const item of updatedItems) {
                try {
                    await updateItemApi(token, item);
                    log(`Update of item ${item._id || item.title} synced`);
                } catch (error) {
                    log(`Failed to sync update of item ${item._id || item.title}`, error);
                }
            }
            clearUpdatedItemsLocal();
        }
    }

    useEffect(getItemsEffect, [token]);
    useEffect(wsEffect, [token]);

    const [offset, setOffset] = useState(0);
    const [hasMoreItems, setHasMoreItems] = useState(true);

    const fetchItems = useCallback(async () => {
        if (token && hasMoreItems) {
            try {
                log('fetchItems started');
                dispatch({ type: FETCH_ITEMS_STARTED });

                const i = offset;
                const j = offset + ITEMS_PER_PAGE;
                const items = await getItems(token, i, j);

                dispatch({
                    type: FETCH_ITEMS_SUCCEEDED,
                    payload: { items: offset === 0 ? items : [...(await getItemsLocal()), ...items] }
                });
                setOffset(j);

                if (items.length < ITEMS_PER_PAGE) {
                    setHasMoreItems(false);
                }
            } catch (error) {
                log('fetchItems failed', error);
                dispatch({ type: FETCH_ITEMS_FAILED, payload: { error } });
            }
        }
    }, [token, offset, hasMoreItems]);


    useEffect(() => {
        if (token) {
            fetchItems();
        }
    }, [token]);

    useEffect(() => {
        setOffset(0);
    }, []);


    const saveItem = useCallback<SaveItemFn>(saveItemCallback, [token, fetchItems]);
    const deleteItem = useCallback<DeleteItemFn>(deleteItemCallback, [token]);
    const updateItem = useCallback<UpdateItemFn>(updateItemCallback, [token, fetchItems]);

    const value = { items, fetching, fetchingError, saving, savingError, saveItem, deleteItem, updateItem, fetchItems };
    log('returns');
    return (
        <ItemContext.Provider value={value}>
            {children}
        </ItemContext.Provider>
    );

    function getItemsEffect() {
        let canceled = false;
        if (token) {
            fetchItems();
        }
        return () => {
            canceled = true;
        }
    }

    async function saveItemCallback(item: ItemProps, networkStatusConnected: boolean) {
        if (networkStatusConnected) {
            try {
                log('saveItem started');
                dispatch({ type: ADD_ITEM_STARTED });
                const savedItem = await (item._id ? updateItemApi(token, item) : addItemApi(token, item));
                log('saveItem succeeded');
                dispatch({ type: ADD_ITEM_SUCCEEDED, payload: { item: savedItem } });
            } catch (error) {
                log('saveItem failed');
                dispatch({ type: ADD_ITEM_FAILED, payload: { error } });

            }
        } else {
            log("trying to add item locally");
            saveItemLocal(item);
            addAddedItem(item);
            dispatch({ type: ADD_ITEM_SUCCEEDED, payload: { item } });
            alert('Offline: task added locally');
        }
    }
    async function addAddedItem(item: ItemProps) {
        const addedItems = await getAddedItemsLocal();
        addedItems.push(item);
        await setAddedItemsLocal(addedItems);
    }

    async function updateItemCallback(item: ItemProps, networkStatusConnected: boolean) {
        log('updateItemCallBack');
        log(`${item._id}`);
        log(networkStatus.connected);
        log(`received net status: ${networkStatusConnected}`);
        if (item._id) {
            if (networkStatusConnected) {
                try {
                    log('updateItem started');
                    dispatch({type: UPDATE_ITEM_STARTED});
                    const updatedItem = await updateItemApi(token, item);
                    log('updateItem succeeded');
                    dispatch({ type: UPDATE_ITEM_SUCCEEDED, payload: { item: updatedItem } });

                } catch (error) {
                    log('updateItem failed');
                    dispatch({type: UPDATE_ITEM_FAILED, payload: {_id: item._id}});
                }
            } else {
                log("trying to update item locally");
                updateItemLocal(item);
                addUpdatedItem(item);
                dispatch({ type: UPDATE_ITEM_SUCCEEDED, payload: { item } });
                alert('Offline: book updated locally');
            }
        }
    }

    async function addUpdatedItem(item: ItemProps) {
        const updatedItems = await getUpdatedItemsLocal();
        updatedItems.push(item);
        await setUpdatedItemsLocal(updatedItems);
    }

    async function deleteItemCallback(item: ItemProps, networkStatusConnected: boolean) {
        if (item._id) {
            if (networkStatusConnected) {
                try {
                    log('deleteItem started');
                    dispatch({type: REMOVE_ITEM_STARTED});
                    await deleteItemApi(token, item);
                    log('deleteItem succeeded');
                    dispatch({type: REMOVE_ITEM_SUCCEEDED, payload: {_id: item._id}});
                } catch (error) {
                    log('deleteItem failed');
                    dispatch({ type: REMOVE_ITEM_FAILED, payload: { _id: item._id } });
                }
            } else {
                log("trying to delete item locally");
                deleteItemLocal(item._id);
                addDeletedItem(item);
                dispatch({ type: REMOVE_ITEM_SUCCEEDED, payload: {_id: item._id} });
                alert('Offline: book deleted locally');
            }
        }
    }

    async function addDeletedItem(item: ItemProps) {
        const deletedItems = await getDeletedItemsLocal();
        deletedItems.push(item);
        await setDeletedItemsLocal(deletedItems);
    }

    function wsEffect() {
        let canceled = false;
        log('wsEffect - connecting');
        let closeWebSocket: () => void;
        if (token?.trim()) {
            closeWebSocket = newWebSocket(token, message => {
                if (canceled) {
                    return;
                }
                const { type, payload: item } = message;
                log(`ws message, item ${type}`);
                if (type === 'created') {
                    dispatch({ type: ADD_ITEM_SUCCEEDED, payload: { item } });
                } else if (type === 'updated') {
                    log(`updated message received with`, item);  // Check if item contains `_id`
                    dispatch({ type: UPDATE_ITEM_SUCCEEDED, payload: { item } });
                } else if (type === 'completed') {
                    dispatch({ type: COMPLETE_ITEM_SUCCEEDED, payload: { _id: item._id } });
                } else if (type === 'deleted') {
                    dispatch({ type: REMOVE_ITEM_SUCCEEDED, payload: { _id: item._id } });
                }
            });
        }
        return () => {
            log('wsEffect - disconnecting');
            canceled = true;
            closeWebSocket?.();
        }
    }
};
