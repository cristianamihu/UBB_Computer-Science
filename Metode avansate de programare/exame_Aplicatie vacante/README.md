O agentie de turism pune la dispozitie o aplicatie care permite rezervarea de cazari in statiunile de vacanta.

Cerinte de proiectare:

 Se definesc clasele: 

- Hotel (hotelId: double, locationName: string, hotelName: string, noRooms: int, pricePerNight: double)
- SpecialOffer (specialOfferId: double, hotelId: double, startDate: date, endDate: date, percents: int [1 ... 100])
- Client (clientId: long, name: string, fidelityGrade: int [1 ... 100], age: int, hobbies: enum(reading, music, hiking, walking, extreme sports))
- Reservation are atributele: reservationId: double, clientId, hotelId, startDate: LocalDateTime, noNights

Procesarea are loc numai la nivel de service sau de controller, interactiunea cu sursa de date se face numai prin intermediul repository-ului (persistenta in baza de date); interactiunea cu utilizatorul are loc numai in UI (GUI)

Cerinte functionale:

- La deschiderea aplicatiei se deschide cate o fereastra pentru fiecare client a carui id se citeste din linia de comanda (fereastra va avea ca titlu id-ul clientului), un buton Search si un buton Book.
- Pentru fiecare client citit din linia de comanda se afiseaza in fereastra corespunzatoare id-ului lui toate ofertele de care el poate beneficia si care nu sunt expirate (data curenta este mai mica decat intervalul ofertei). Un client poate beneficia de o oferta, specialOffer, daca are fidelityGrade > SpecialOffer.percents.etc. Informatiile se afiseaza sub forma tabelara 

![image](https://github.com/cristianamihu/UBB_Computer-Science/assets/128689630/98baaece-df99-476c-b572-6bec801f1d1c)
