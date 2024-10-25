Aplicatie pentru gestiunea de carti

Aceasta aplicatie gestioneaza item-uri = carti, iar un item are urmatoarele proprietati: id: String, title: String, author: String, releaseDate: Date, code: Number, liked: Boolean (daca mi-a placut o carte = 1 sau nu = 0 )

Aplicatia are urmatoarele caracterisrici: vizualizare lista de items pe prima pagina, selectarea unui element din lista de pe pagina de home si deschiderea unei ferestre cu detaliile elementului, websocket activ si rest service

Pentru a executa apliactia trebuie introduse urmatoarele comenzi in linia de comanda:
    npm install
    npm install -g @ionic/cli
    ionic serve

Iar pentru a porni serverul:
    npm install
    npm start