import React, { memo } from 'react';
import { getLogger } from '../core';
import { ItemProps } from './ItemProps';
import { IonItem, IonLabel, IonText, IonButton } from "@ionic/react";

const log = getLogger('Item');

interface ItemPropsExt extends ItemProps {
    onEdit: (_id?: string) => void;
}

const Item: React.FC<ItemPropsExt> = ({ _id, title, author, liked, releaseDate, onEdit }) => {
    log(`render ${title} ${author} ${liked} ${releaseDate}`);
    return (
        <IonItem>
            <IonLabel>
                <h2>{title}</h2>
                <p>{author}</p>
                <IonText>
                    <p>
                        Liked: {liked ? 'Yes' : 'No'} <br />
                        ReleaseDate: {new Date(releaseDate).toLocaleDateString()} <br />
                    </p>
                </IonText>
            </IonLabel>
            <IonButton onClick={() => onEdit(_id)}>Edit</IonButton>
        </IonItem>
    );
};

export default memo(Item);
