Relatii intre entitati:
- Un utilizator al retelei are o lista de prieteni
- O prietenie se stabileste intre doi utilizatori ai retelei
- Reteau este definita de multimea utilizatorilor si a relatiilor de prietenie dintre acestia

Cerinte non-funționale:
- Arhitectura stratificata 
- DDD (Domain Driven Design) 
- Persistenta datelor: in memorie 
- Validarea datelor (Strategy Pattern) 
- Definirea propriilor clase de exceptii pentru tratarea situatiilor speciale; 
- Interfata cu utilizatorul, de tip consola

Funcționalitati de baza:
- Gestiunea utilizatorilor: operatii CRUD
- Gestiunea relatiilor de prietenie intre utlizatori: adagare/stergere prieten
- Determnarea comunitatii din care face parte un anumit utilizator (componenta conexa a retelei care contine utlizatorul respectiv)
- Folosirea tipului Optional la tipul returnat de metodele update, delete, save si findOne
- Gestiunea mesajelor: trimitere/stergere mesaj
- Gestiunea evenimentelor: se va implementa sablonul Observer pentru notificari, abonare/dezabonare la un eveniment;
- Autentificare: logare/delogare

asigurați persistența datelor
în baza de date – Utilizator si Prietenie – (recomandam sa folositi PostgresSQL –
exemplificare la curs si seminar)

Să se afiseze toate relatiile de prietenie ale unui utilizator, create intr-o anumita luna a anului,
utilizatorul si luna din an se citesc de la tastatura (folositi operatii pe srtream-uri (filter, map,
reduce ....)

Pentru versiunea proiectului Social Network din laboratorul 5, implementati
operatia de stergere, atât pt Utilizator, cât și pt Prietenie, in conformitate cu ce
ati invatat la cursul de baze de date (stabilirea unei relatii intre cele doua tabele,
utilizatori si prietenii, si stergerea in cascada)

Adaugati clasa Message avand urmatoarele attribute: id, from:Utilizator,
to:List<Utilizator>, message: String, data:LocalDateTime; Derivati ReplyMessage
(Collaboration) din clasa Message si adaugati un attribut message:Message (care
specifica la ce mesaj raspunde obiectul de tipul ReplyMessage). (Sau puteti avea in
clasa Message un atribut reply: Messaje, care sa fie null pentru un mesaj nou creat).
Afisati (cronologic) conversatiile a doi utilizatori, cititi de la tastatura.
2. Simulati trimiterea unei invitatii de prietenie si adaugati relatia doar daca utilizatorul
invitat o accepta. Salvati cererile de prietenie si actualizati statusul lor (pending,
approved, rejected).
B. Cerințe non-funcționale:
1. GUI
2. Repository de tip DB
   

  Cerinte functionale:
- Add/Remove Utilizator
- Add/Remove Prieten
- Afisare numar de comunitati (numarul de componente conexe din graful retelei)
- Afisare cea mai sociabila comunitate (componenta conexa din retea cu cel mai lung drum)


![image](https://github.com/cristianamihu/UBB_Computer-Science/assets/128689630/39579d2a-b6d8-4dfb-977b-c455e437558c)
