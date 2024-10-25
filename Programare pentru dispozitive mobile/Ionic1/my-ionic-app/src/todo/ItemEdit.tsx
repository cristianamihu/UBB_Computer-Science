import React, { useCallback, useContext, useEffect, useState } from 'react';
import {
  IonButton,
  IonButtons,
  IonContent,
  IonHeader,
  IonInput,
  IonItem,
  IonLabel,
  IonLoading,
  IonPage,
  IonTitle,
  IonToggle,
  IonToolbar,
  IonDatetime
} from '@ionic/react';
import { getLogger } from '../core';
import { ItemContext } from './ItemProvider';
import { RouteComponentProps } from 'react-router';
import { ItemProps } from './ItemProps';

const log = getLogger('ItemEdit');

interface ItemEditProps extends RouteComponentProps<{
  id?: string;
}> {}

const ItemEdit: React.FC<ItemEditProps> = ({ history, match }) => {
  const { items, saving, savingError, saveItem } = useContext(ItemContext);
  const [item, setItem] = useState<ItemProps>({
    id: 0,
    title: '',
    author: '',
    code: 0,
    releaseDate: new Date(),
    liked: false,
  });

  useEffect(() => {
    log('useEffect');
    const routeId = parseInt(match.params.id || '', 10); // Convertim routeId la number
    if (!isNaN(routeId)) {
      const currentItem = items?.find(it => it.id === routeId);
      if (currentItem) {
        setItem(currentItem);
      }
    }
  }, [match.params.id, items]);


  const handleSave = useCallback(() => {
    const editedItem = { ...item, releaseDate: item.releaseDate || new Date().toISOString() };
    saveItem && saveItem(editedItem).then(() => history.goBack());
  }, [item, saveItem, history]);

  const handleChange = (field: keyof ItemProps, value: any) => {
    setItem({ ...item, [field]: value });
  };

  log('render');
  return (
      <IonPage>
        <IonHeader>
          <IonToolbar>
            <IonTitle>Edit Book</IonTitle>
            <IonButtons slot="end">
              <IonButton onClick={handleSave}>
                Save
              </IonButton>
            </IonButtons>
          </IonToolbar>
        </IonHeader>

        <IonContent>
          <IonItem>
            <br/>
            <IonLabel position="stacked"><b>Title</b></IonLabel>
            <IonInput value={item.title} onIonChange={e => handleChange('title', e.detail.value || '')}/>
          </IonItem>
          <IonItem>
            <br/>
            <IonLabel position="stacked"><b>Author</b></IonLabel>
            <IonInput value={item.author} onIonChange={e => handleChange('author', e.detail.value || '')}/>
          </IonItem>
          <IonItem>
            <br/>
            <IonLabel position="stacked"><b>Code</b></IonLabel>
            <IonInput type="number" value={item.code} onIonChange={e => handleChange('code', parseInt(e.detail.value!, 10))}/>
          </IonItem>
          <IonItem>
            <br/>
            <IonLabel position="stacked"><b>Release Date</b></IonLabel>
            <IonDatetime value={item.releaseDate ? new Date(item.releaseDate).toISOString().split('T')[0] : ''} onIonChange={e => handleChange('releaseDate', e.detail.value!)}/>
          </IonItem>
          <IonItem>
            <br/>
            <IonLabel>Liked</IonLabel>
            <IonToggle checked={item.liked} onIonChange={e => handleChange('liked', e.detail.checked)}/>
          </IonItem>
          <IonLoading isOpen={saving} />
          {savingError && (
              <div>{savingError.message || 'Failed to save book'}</div>
          )}
        </IonContent>
      </IonPage>
  );
};

export default ItemEdit;
