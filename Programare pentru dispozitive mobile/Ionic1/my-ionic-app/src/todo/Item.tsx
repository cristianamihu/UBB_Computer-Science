import React, { memo } from 'react';
import { IonItem, IonLabel } from '@ionic/react';
import { getLogger } from '../core';
import { ItemProps } from './ItemProps';

const log = getLogger('Item');

interface ItemPropsExt extends ItemProps {
    onEdit: (id?: number | undefined) => void;
}

const Item: React.FC<ItemPropsExt> = ({ id, title, author, code, releaseDate, liked, onEdit }) => {
    log('render');
    return (
        <IonItem onClick={() => onEdit(id)}>
            <IonLabel>
                <h2>{title}</h2>
                <p>Author: {author}</p>
                <p>Code: {code}</p>
                <p>Release Date: {releaseDate ? new Date(releaseDate).toLocaleDateString() : 'N/A'}</p>
                <p>Liked: {liked ? 'Yes' : 'No'}</p>
            </IonLabel>
        </IonItem>
    );
};

export default memo(Item);
