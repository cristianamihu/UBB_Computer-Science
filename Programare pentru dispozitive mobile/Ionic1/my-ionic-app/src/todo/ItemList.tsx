import React, { useContext } from 'react';
import { RouteComponentProps } from 'react-router';
import {
  IonContent,
  IonFab,
  IonFabButton,
  IonHeader,
  IonIcon,
  IonList, IonLoading,
  IonPage,
  IonTitle,
  IonToolbar
} from '@ionic/react';
import { add } from 'ionicons/icons';
import Item from './Item';
import { getLogger } from '../core';
import { ItemContext } from './ItemProvider';

const log = getLogger('ItemList');

const ItemList: React.FC<RouteComponentProps> = ({ history }) => {
  // Extragem elementele si erorile de la ItemContext, acum adaptate pentru entitatea books
  const { items, fetching, fetchingError } = useContext(ItemContext);
  log('render');

  return (
      <IonPage>
        <IonHeader>
          <IonToolbar>
            <IonTitle>Books Corner</IonTitle>
          </IonToolbar>
        </IonHeader>

        <IonContent>
          <IonLoading isOpen={fetching} message="Fetching books..." />
          {items && (
              <IonList>
                {items.map(({ id, title, author, code, releaseDate, liked }) => 
                    <Item
                      key={id}
                      id={id}
                      title={title}
                      author={author}
                      code={code}
                      releaseDate={releaseDate}
                      liked={liked}
                      onEdit={(id) => history.push(`/books/${id}`)}
                    />)}
              </IonList>
          )}
          {fetchingError && (
              <div>{fetchingError.message || 'Failed to fetch books'}</div>
          )}
          <IonFab vertical="bottom" horizontal="end" slot="fixed">
            <IonFabButton onClick={() => history.push('/books')}>
              <IonIcon icon={add} />
            </IonFabButton>
          </IonFab>
        </IonContent>
      </IonPage>
  );
};

export default ItemList;
