import { Preferences } from '@capacitor/preferences';
import {ItemProps} from "./ItemProps";

export const usePreferences = () => {
    const setAuthToken = async (token: string) => {
        await Preferences.set({ key: 'authToken', value: token });
    };

    const getAuthToken = async () => {
        const { value } = await Preferences.get({ key: 'authToken' });
        return value;
    };

    const removeAuthToken = async () => {
        await Preferences.remove({ key: 'authToken' });
    };

    const saveItemLocal = async (item: ItemProps) => {
        const { value } = await Preferences.get({ key: 'items' });
        const items = value ? JSON.parse(value) : [];
        items.push(item);
        await Preferences.set({ key: 'items', value: JSON.stringify(items) });
    };


    const updateItemLocal = async (item: ItemProps) => {
        const { value } = await Preferences.get({ key: 'items' });
        const items = value ? JSON.parse(value) : [];
        const updatedItems = items.map((existingItem: ItemProps) =>
            existingItem._id === item._id ? item : existingItem
        );
        await Preferences.set({ key: 'items', value: JSON.stringify(updatedItems) });
    };

    const deleteItemLocal = async (itemId: string) => {
        const { value } = await Preferences.get({ key: 'items' });
        const items = value ? JSON.parse(value) : [];

        const updatedItems = items.filter((item: ItemProps) => item._id !== itemId);

        await Preferences.set({ key: 'items', value: JSON.stringify(updatedItems) });
    };

    const setItemsLocal = async (books: ItemProps[]) => {
        await Preferences.set({ key: 'items', value: JSON.stringify(books) });
    };

    const getItemsLocal = async () => {
        const { value } = await Preferences.get({ key: 'items' });
        return value ? JSON.parse(value) : [];
    };

    const removeItemsLocal = async () => {
        await Preferences.remove({ key: 'items' });
    }

    const setDeletedItemsLocal = async (books: ItemProps[]) => {
        await Preferences.set({ key: 'deletedItems', value: JSON.stringify(books) });
    };

    const getDeletedItemsLocal = async () => {
        const { value } = await Preferences.get({ key: 'deletedItems' });
        return value ? JSON.parse(value) : [];
    };

    const clearDeletedItemsLocal = async () => {
        await Preferences.remove({ key: 'deletedItems' });
    };

    const setUpdatedItemsLocal = async (items: ItemProps[]) => {
        await Preferences.set({ key: 'updatedItems', value: JSON.stringify(items) });
    };

    const getUpdatedItemsLocal = async () => {
        const { value } = await Preferences.get({ key: 'updatedItems' });
        return value ? JSON.parse(value) : [];
    };

    const clearUpdatedItemsLocal = async () => {
        await Preferences.remove({ key: 'updatedItems' });
    };

    const setAddedItemsLocal = async (items: ItemProps[]) => {
        await Preferences.set({ key: 'addedItems', value: JSON.stringify(items) });
    };

    const getAddedItemsLocal = async () => {
        const { value } = await Preferences.get({ key: 'addedItems' });
        return value ? JSON.parse(value) : [];
    };

    const clearAddedItemsLocal = async () => {
        await Preferences.remove({ key: 'addedItems' });
    };

    const getItemsLocalPaginated = async (offset: number, limit: number) => {
        const { value } = await Preferences.get({ key: 'items' });
        const items = value ? JSON.parse(value) : [];
        return items.slice(offset, offset + limit);
    };


    return {
        setAuthToken,
        getAuthToken,
        removeAuthToken,
        saveItemLocal,
        updateItemLocal,
        deleteItemLocal,
        setItemsLocal,
        getItemsLocal,
        removeItemsLocal,
        getDeletedItemsLocal,
        setDeletedItemsLocal,
        clearDeletedItemsLocal,
        setUpdatedItemsLocal,
        getUpdatedItemsLocal,
        clearUpdatedItemsLocal,
        setAddedItemsLocal,
        getAddedItemsLocal,
        clearAddedItemsLocal,
        getItemsLocalPaginated
    };
};
