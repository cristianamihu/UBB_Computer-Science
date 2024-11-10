import axios from 'axios';
import {authConfig, baseUrl, getLogger, withLogs} from '../core';
import {ItemProps} from "./ItemProps";

const itemUrl = `http://${baseUrl}/api/books`;

export const getItems: (token: string, i: number, j: number) => Promise<ItemProps[]> = (token, i = 0, j = 10) => {
    const url = `${itemUrl}/from/${i}/${j}`; // Construct URL with i and j as path parameters
    return withLogs(axios.get(url, authConfig(token)), 'getItems');
};

export const getItemCount: (token: string) => Promise<number> = (token) => {
    const url = `${itemUrl}/count`;
    return withLogs(
        axios.get(url, authConfig(token)).then(response => response.data.count),
        'getItemCount'
    );
};

export const addItemApi: (token: string, item: ItemProps) => Promise<ItemProps[]> = (token, item) => {
    return withLogs(axios.post(itemUrl, item, authConfig(token)), 'createItem');
}

export const updateItemApi: (token: string, item: ItemProps) => Promise<ItemProps[]> = (token, item) => {
    console.log(item._id);
    return withLogs(axios.put(`${itemUrl}/${item._id}`, item, authConfig(token)), 'updateItem');
}

export const deleteItemApi: (token: string, item: ItemProps) => Promise<ItemProps[]> = (token, item) => {
    return withLogs(axios.delete(`${itemUrl}/${item._id}`, authConfig(token)), 'removeItem');
}

interface MessageData {
    type: string;
    payload: ItemProps;
}

const log = getLogger('ws');

export const newWebSocket = (token: string, onMessage: (data: MessageData) => void) => {
    const ws = new WebSocket(`ws://${baseUrl}`);
    ws.onopen = () => {
        log('web socket onopen');
        ws.send(JSON.stringify({ type: 'authorization', payload: { token } }));
    };
    ws.onclose = () => {
        log('web socket onclose');
    };
    ws.onerror = error => {
        log('web socket onerror', error);
    };
    ws.onmessage = messageEvent => {
        log('web socket onmessage');
        onMessage(JSON.parse(messageEvent.data));
    };
    return () => {
        ws.close();
    }
}
