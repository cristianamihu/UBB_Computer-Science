import React, { useContext, useEffect, useState } from 'react';
import {
    IonButton,
    IonButtons,
    IonContent,
    IonHeader,
    IonInput,
    IonLoading,
    IonPage,
    IonTextarea,
    IonTitle,
    IonCheckbox,
    IonItem,
    IonLabel,
    IonToolbar
} from '@ionic/react';
import { getLogger } from '../core';
import { ItemContext } from './ItemProvider';
import { RouteComponentProps } from 'react-router';
import { ItemProps } from './ItemProps';
import {useNetwork} from "./useNetwork";
import {usePreferences} from "./usePreferences";

const log = getLogger('ItemEdit');


interface ItemEditProps extends RouteComponentProps<{
    id?: string; // Changed to 'id' to match the route parameter
}> {}

const ItemEdit: React.FC<ItemEditProps> = ({ history, match }) => {
    const { items, saving, savingError, saveItem } = useContext(ItemContext);
    const [title, setTitle] = useState('');
    const [author, setAuthor] = useState('');
    const [liked, setLiked] = useState(false);
    const [releaseDate, setReleaseDate] = useState('');
    const [item, setItem] = useState<ItemProps>();
    const {networkStatus} = useNetwork();

    useEffect(() => {
        log('useEffect');
        const routeId = match.params.id || '';
        const item = items?.find(it => it._id === routeId);

        if (item) {
            setItem(item);
            setTitle(item.title);
            setAuthor(item.author);
            setReleaseDate(item.releaseDate);
            setLiked(item.liked);
        }
    }, [match.params.id, items]);

    const handleSave = async () => {
        const editedItem = item
            ? { ...item, title, author, liked,  releaseDate }
            : { title, author, liked,  releaseDate };
        if (editedItem) {
            saveItem && saveItem(editedItem, networkStatus.connected).then(() => history.goBack());
            log("successfully updated item");
        }
    };

    log('render');
    return (
        <IonPage>
            <IonHeader>
                <IonToolbar>
                    <IonTitle>Add</IonTitle>
                    <IonButtons slot="end">
                        <IonButton onClick={handleSave}>
                            Save
                        </IonButton>
                    </IonButtons>
                </IonToolbar>
            </IonHeader>
            <IonContent>
                <IonInput value={title} onIonChange={e => setTitle(e.detail.value || '')} placeholder="Item Title" />
                <IonTextarea value={author} onIonChange={e => setAuthor(e.detail.value || '')} placeholder="Author" />
                <IonInput type="datetime-local" value={releaseDate} onIonChange={e => setReleaseDate(e.detail.value || '')} />
                <IonItem>
                    <IonLabel>Liked</IonLabel>
                    <IonCheckbox checked={liked} onIonChange={e => setLiked(e.detail.checked)}/>
                </IonItem>
                <IonLoading isOpen={saving} />
                {savingError && (
                    <div>{savingError.message || 'Failed to save item'}</div>
                )}
            </IonContent>
        </IonPage>
    );
};

export default ItemEdit;
