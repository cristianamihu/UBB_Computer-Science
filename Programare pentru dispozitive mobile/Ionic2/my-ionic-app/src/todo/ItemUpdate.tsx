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
    IonLabel,
    IonItem,
    IonToolbar
} from '@ionic/react';
import { getLogger } from '../core';
import { ItemContext } from './ItemProvider';
import { RouteComponentProps } from 'react-router';
import { ItemProps } from './ItemProps';
import {useNetwork} from "./useNetwork";
import {usePreferences} from "./usePreferences";

const log = getLogger('ItemUpdate');

interface ItemUpdateProps extends RouteComponentProps<{
    id?: string;
}> {}

const ItemUpdate: React.FC<ItemUpdateProps> = ({ history, match }) => {
    const { items, saving, savingError, updateItem, deleteItem } = useContext(ItemContext);
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
            ? { ...item, title, author, liked, releaseDate }
            : { title, author, liked, releaseDate };
        if (editedItem && editedItem._id) {
            updateItem && updateItem(editedItem, networkStatus.connected).then(() => history.goBack());
            log("successfully updated item");
        }
    };

    const handleDelete = () => {
        if (item && item._id) {
            deleteItem && deleteItem(item, networkStatus.connected).then(() => history.goBack());
            log("successfully deleted item");
        }
    };



    const handleLike = () => {
        const updatedLikedStatus = !liked;
        setLiked(updatedLikedStatus);
        if (item && item._id) {
            const editedItem = { ...item, liked: updatedLikedStatus };
            updateItem && updateItem(editedItem, networkStatus.connected).then(() => history.goBack());
            log("successfully updated item");
        }
    };



    log('render');
    return (
        <IonPage>
            <IonHeader>
                <IonToolbar>
                    <IonTitle>Update</IonTitle>
                    <IonButtons slot="end">
                        <IonButton onClick={handleSave}>
                            Save
                        </IonButton>
                        <IonButton color="danger" onClick={handleDelete}>
                            Delete
                        </IonButton>
                    </IonButtons>
                </IonToolbar>
            </IonHeader>
            <IonContent className="ion-padding" style={{ backgroundColor: '#f9f9f9' }}>
                <div style={{ marginBottom: '1rem' }}>
                    <IonInput
                        style={{
                            border: '1px solid #ccc',
                            padding: '10px',
                            borderRadius: '8px',
                            backgroundColor: '#161617',
                        }}
                        value={title}
                        onIonChange={e => setTitle(e.detail.value || '')}
                        placeholder="Book Title"
                    />
                </div>
                <div style={{ marginBottom: '1rem' }}>
                    <IonTextarea
                        style={{
                            border: '1px solid #ccc',
                            padding: '10px',
                            borderRadius: '8px',
                            backgroundColor: '#161617',
                        }}
                        value={author}
                        onIonChange={e => setAuthor(e.detail.value || '')}
                        placeholder="Author"
                    />
                </div>
                <div style={{ marginBottom: '1rem' }}>
                    <IonInput
                        style={{
                            border: '1px solid #ccc',
                            padding: '10px',
                            borderRadius: '8px',
                            backgroundColor: '#161617',
                        }}
                        type="datetime-local"
                        value={releaseDate}
                        onIonChange={e => setReleaseDate(e.detail.value || '')}
                    />
                </div>
                <IonItem style={{ backgroundColor: '#f9f9f9', marginBottom: '1rem' }}>
                    <IonLabel>Liked</IonLabel>
                    <IonCheckbox
                        checked={liked}
                        onIonChange={e => setLiked(e.detail.checked)}
                    />
                </IonItem>
                <IonLoading isOpen={saving} />
                {savingError && (
                    <div style={{ color: 'red', marginTop: '10px' }}>
                        {savingError.message || 'Failed to update item'}
                    </div>
                )}
            </IonContent>
        </IonPage>
    );
};

export default ItemUpdate;
