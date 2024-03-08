USE Orfelinat;

--(DISTINCT + GROUP BY + HAVING + 3 tabele)
--Afiseaza numele donatorilor care au donat cel putin suma de 1000.00 si numele departamentului la care au donat

SELECT D.nume AS nume_donator,DA.suma, DEP.nume AS nume_departament
FROM Donatori D
INNER JOIN Donatii DA ON D.id_donator = DA.id_donator
INNER JOIN Departamente DEP ON DA.id_departament = DEP.id_departament
GROUP BY D.nume, DA.suma, DEP.nume
HAVING SUM(DA.suma) >= 1000.00;


--(WHERE + DISTINCT)
--Afiseaza data nasterii a copiilor din fiecare incapere de tip dormitor

SELECT DISTINCT I.tip_incapere
FROM Incaperi I
WHERE I.tip_incapere != 'dormitor';


--(HAVING + GROUP BY + 3 tabele + relatie m-n)
--Afiseaza numarul total de vizite pentru copiii care au mai mult de o vizita, si vizitatorii lor

SELECT C.nume AS nume_copil, COUNT(V.id_vizitator) AS numar_vizite, STRING_AGG(VI.nume, ', ') AS vizitatori
FROM Copii C
INNER JOIN Vizite V ON C.id_dosar_copil = V.id_dosar_copil
INNER JOIN Vizitatori VI ON VI.id_vizitator = V.id_vizitator
GROUP BY C.nume
HAVING COUNT(V.id_vizitator) > 1;


--(WHERE + 3 tabele)
--Afiseaza numele angajatiilor, slujba si salariul, pentru angajatii ce au o slujba ce face parte dintr-un departament care are salariul mai mare decat 2500.00

SELECT A.nume AS nume_angajat, S.descriere AS slujba, S.salariu
FROM Angajati A
INNER JOIN Slujba S ON A.id_slujba = S.id_slujba
INNER JOIN Departamente D ON S.id_departament = D.id_departament
WHERE S.salariu > 2500.00;


--(DISTINCT + WHERE + mai mult de 3 tabele + relatie m-n)
--Afiseaza vizitatorii copiiilor care participa la activitatea "Lectie de dans"

SELECT DISTINCT VI.nume AS nume_vizitator, C.nume AS nume_copil
FROM Vizite V
JOIN Copii C ON V.id_dosar_copil = C.id_dosar_copil
JOIN Activitati A ON C.id_dosar_copil = A.id_dosar_copil
JOIN Vizitatori VI ON V.id_vizitator = VI.id_vizitator
WHERE A.descriere = 'Lectie de dans';


--(WHERE + GROUP BY)
--Selecteaza toate numele de copii care au fost nascuti inainte de anul 2011, data lor de nastere si numarul de vizite pe care il are fiecare copil

SELECT C.nume AS nume_copil, C.data_nastere, COUNT(V.id_dosar_copil) AS numar_vizite
FROM Copii C
LEFT OUTER JOIN Vizite V ON C.id_dosar_copil = V.id_dosar_copil
WHERE YEAR(C.data_nastere) < 2011
GROUP BY C.nume, C.data_nastere;


--(WHERE + 3 tabele)
--Extragem toate inregistrarile din tabelul Vizitatori pentru care vizitatorii nu au numarul de telefon si afisam copiii pe care acestia i-au vizitat

SELECT V.id_vizitator, V.nume, C.nume AS nume_copil
FROM Vizitatori V
LEFT OUTER JOIN Vizite Vz ON V.id_vizitator = Vz.id_vizitator
LEFT OUTER JOIN Copii C ON Vz.id_dosar_copil = C.id_dosar_copil
WHERE V.numar_telefon IS NULL;


--(WHERE + relatie m-n)
--Afisati toate donatiile pentru fiecare donator care nu are email

SELECT D.id_donator, DD.nume AS nume_donator, DD.numar_telefon, D.continut, D.suma
FROM Donatii D
JOIN Donatori DD ON DD.id_donator = D.id_donator
WHERE DD.email IS NULL;


--(WHERE + HAVING + GROUP BY + 3 tabele)
--Afiseaza numele copiilor care AU informatii medicale si stau intr-o camera cu o capacitate maxima de 3 persoane si numarul vizitatorilor lor

SELECT C.nume AS nume_copil, C.informatii_medicale, I.numar_incapere, I.capacitate_maxima, COUNT(V.id_vizitator) AS numar_vizitatori
FROM Copii C
LEFT OUTER JOIN Incaperi I ON C.numar_incapere = I.numar_incapere
LEFT OUTER JOIN Vizite V ON C.id_dosar_copil = V.id_dosar_copil
WHERE C.informatii_medicale IS NOT NULL AND I.capacitate_maxima = 3
GROUP BY C.nume, C.informatii_medicale, I.capacitate_maxima, I.numar_incapere
HAVING COUNT(V.id_vizitator) > 1;


--(WHERE + GROUP BY + 3 tabele)
--Afiseaza toate incaperile pentru fiecare departament, iar pentru incaperiile care au etajul egal cu 3 sa se afiseze copiii care stau in acel numar de incapere

SELECT D.nume, I.numar_incapere, I.etaj, C.nume AS nume_copil
FROM Departamente D
INNER JOIN IncaperI I ON D.id_departament = I.id_departament
LEFT OUTER JOIN Copii C ON I.numar_incapere = C.numar_incapere
WHERE I.etaj = 3;