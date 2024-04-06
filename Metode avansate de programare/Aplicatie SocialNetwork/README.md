O aplicatie scrisa in limbaj Java bazata pe ideea unei retele de socializare in care iti poti crea un cont, sa te imprietenesti cu alti utilizatori si sa trimiti mesaje unui alt utilizator sau sa primesti mesaje de la un alt utilizator.

Relatii intre entitati:
- Un utilizator al retelei are o lista de prieteni
- O prietenie se stabileste intre doi utilizatori ai retelei
- Reteaua este definita de multimea utilizatorilor si a relatiilor de prietenie dintre acestia

Cerinte non-funționale:
- Arhitectura stratificata 
- DDD (Domain Driven Design) 
- Validarea datelor (Strategy Pattern) 
- Definirea propriilor clase de exceptii pentru tratarea situatiilor speciale; 
- Interfata cu utilizatorul, de tip consola
- Persistenta datelor: in memorie 

Funcționalitati de baza:
- Gestiunea utilizatorilor: operatii CRUD
- Gestiunea relatiilor de prietenie intre utlizatori: adagare/stergere prieten
- Folosirea tipului Optional la tipul returnat de metodele update, delete, save si findOne
- Determinarea comunitatii din care face parte un anumit utilizator (componenta conexa a retelei care contine utlizatorul respectiv)
- Gestiunea mesajelor: trimitere/stergere mesaj
- Gestiunea evenimentelor: se va implementa sablonul Observer pentru notificari, abonare/dezabonare la un eveniment;
- Autentificare: logare/delogare

Asigurare persistenta datelor in baza de date (folosind PostgresSQL)

Sa se afiseze toate relatiile de prietenie ale unui utilizator, create intr-o anumita luna a anului, utilizatorul si luna din an se citesc de la tastatura.
Stabilirea relatiei intre utilizator si prieteni, stergerea in cascada

Simulare trimitere invitatii de prietenie si adaugare relatie doar daca utilizatorul
invitat o accepta. Salvare cereri de prietenie si actualizarea statusul lor (pending,
approved, rejected).

Cerințe non-functionale:
1. GUI
2. Repository de tip DB
   

  Cerinte functionale:
- Add/Remove Utilizator
- Add/Remove Prieten
- Afisare numar de comunitati (numarul de componente conexe din graful retelei)
- Afisare cea mai sociabila comunitate (componenta conexa din retea cu cel mai lung drum)


![image](https://github.com/cristianamihu/UBB_Computer-Science/assets/128689630/39579d2a-b6d8-4dfb-977b-c455e437558c)
