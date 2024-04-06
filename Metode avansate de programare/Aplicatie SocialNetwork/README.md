O aplicatie scrisa in limbaj Java bazata pe ideea unei retele de socializare unde exista utilizatori care pot avea relatii de prietenie cu alti utilizatori

Relatii intre entitati:
- Un utilizator al retelei are o lista de prieteni
- O prietenie se stabileste intre doi utilizatori ai retelei
- Reteaua este definita de multimea utilizatorilor si a relatiilor de prietenie dintre acestia

Cerinte non-funtionale:
- Arhitectura stratificata 
- DDD (Domain Driven Design) 
- Validarea datelor (Strategy Pattern) 
- Definirea propriilor clase de exceptii pentru tratarea situatiilor speciale; 
- Interfata cu utilizatorul, de tip consola
- Persistenta datelor: in memorie 


Functionalitati de baza:
- Gestiunea utilizatorilor: operatii CRUD
- Gestiunea relatiilor de prietenie intre utlizatori: adagare/stergere prieten
- Folosirea tipului Optional la tipul returnat de metodele update, delete, save si findOne
- Determinarea comunitatii din care face parte un anumit utilizator (componenta conexa a retelei care contine utlizatorul respectiv)


  Cerinte functionale:
- Add/Remove Utilizator, stergerea in cascada
- Add/Remove Prieten
- Afisare toate relatiile de prietenie ale unui utilizator, create intr-o anumita luna a anului, utilizatorul si luna din an se citesc de la tastatura.
- Afisare numar de comunitati (numarul de componente conexe din graful retelei)
- Afisare cea mai sociabila comunitate (componenta conexa din retea cu cel mai lung drum)


![image](https://github.com/cristianamihu/UBB_Computer-Science/assets/128689630/39579d2a-b6d8-4dfb-977b-c455e437558c)
