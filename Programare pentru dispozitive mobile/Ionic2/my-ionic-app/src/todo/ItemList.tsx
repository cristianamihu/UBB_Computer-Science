import React, { useContext, useState } from 'react';
import { IonButton,
         IonContent,
         IonFab,
         IonFabButton,
         IonHeader, 
         IonIcon, 
         IonInfiniteScroll, 
         IonInfiniteScrollContent, 
         IonList, 
         IonPage, 
         IonText, 
         IonTitle, 
         IonToolbar, 
         IonSearchbar, 
         IonSelect, 
         IonSelectOption } from '@ionic/react';
import { add } from 'ionicons/icons';
import Item from './Item';
import { getLogger } from '../core';
import { ItemContext } from './ItemProvider';
import { useNetwork } from './useNetwork';
import { AuthContext } from '../auth/AuthProvider';
import { RouteComponentProps } from "react-router";

const log = getLogger('ItemList');
const ITEMS_PER_PAGE = 7; 

const ItemList: React.FC<RouteComponentProps> = ({ history }) => {
    const { networkStatus } = useNetwork();
    const { items, fetchingError, fetchItems } = useContext(ItemContext);
    const { logout } = useContext(AuthContext);

    const [page, setPage] = useState(1);
    const [searchText, setSearchText] = useState('');
    const [filter, setFilter] = useState<'all' | 'liked' | 'disliked'>('all');

    const loadMoreItems = async (event: CustomEvent<void>) => {
        await fetchItems?.();
        (event.target as HTMLIonInfiniteScrollElement).complete();
    };

    const filteredItems = items?.filter(item => {
        const matchesSearch = item.title.toLowerCase().includes(searchText.toLowerCase()) ||
            item.author.toLowerCase().includes(searchText.toLowerCase());
        const matchesFilter =
            (filter === 'all') ||
            (filter === 'liked' && item.liked) ||
            (filter === 'disliked' && !item.liked);
        return matchesSearch && matchesFilter;
    });

    return (
        <IonPage>
            <IonHeader>
                <IonToolbar>
                    <IonTitle>Item List</IonTitle>
                    <IonButton onClick={logout} slot="end">
                        Logout
                    </IonButton>
                    <IonText slot="end" color={networkStatus.connected ? 'success' : 'danger'} style={{ paddingRight: '16px' }}>
                        {networkStatus.connected ? 'Online' : 'Offline'}
                    </IonText>
                </IonToolbar>
                <IonToolbar>
                    <IonSearchbar value={searchText} onIonInput={(e) => setSearchText(e.detail.value!)} placeholder="Search items"/>
                    <IonSelect value={filter} placeholder="Filter" onIonChange={(e) => setFilter(e.detail.value)}>
                        <IonSelectOption value="all">All</IonSelectOption>
                        <IonSelectOption value="liked">Liked</IonSelectOption>
                        <IonSelectOption value="disliked">Disliked</IonSelectOption>
                    </IonSelect>
                </IonToolbar>
            </IonHeader>
            <IonContent>
                {filteredItems && (
                    <IonList>
                        {filteredItems.map(({ _id, title, author, releaseDate, liked }) => (
                            <Item
                                key={_id}
                                _id={_id}
                                title={title}
                                author={author}
                                releaseDate={releaseDate}
                                liked={liked}
                                onEdit={id => history.push(`/book/${id}`)}
                            />
                        ))}
                    </IonList>
                )}
                {fetchingError && <div>{fetchingError.message || 'Failed to fetch items'}</div>}

                <IonInfiniteScroll threshold="60px" onIonInfinite={loadMoreItems}>
                    <IonInfiniteScrollContent loadingText="Loading more items..."></IonInfiniteScrollContent>
                </IonInfiniteScroll>

                <IonFab vertical="bottom" horizontal="end" slot="fixed">
                    <IonFabButton onClick={() => history.push('/book')}>
                        <IonIcon icon={add} />
                    </IonFabButton>
                </IonFab>
            </IonContent>
        </IonPage>
    );
};

export default ItemList;
