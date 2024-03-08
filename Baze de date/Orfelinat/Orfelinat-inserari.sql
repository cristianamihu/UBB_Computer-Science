USE Orfelinat;

--valori pentru tabela Departamente
INSERT INTO Departamente(id_departament, nume, numar_angajati) VALUES (11, 'scoala', 2);
INSERT INTO Departamente(id_departament, nume, numar_angajati) VALUES (22, 'cabinet medical', 2); 
INSERT INTO Departamente(id_departament, nume, numar_angajati) VALUES (33, 'bucatarie', 4); 
INSERT INTO Departamente(id_departament, nume, numar_angajati) VALUES (44, 'paza', 2); 
INSERT INTO Departamente(id_departament, nume, numar_angajati) VALUES (55, 'curatatorie', 2);
INSERT INTO Departamente(id_departament, nume, numar_angajati) VALUES (66, 'administratie', 1);
INSERT INTO Departamente(id_departament, nume, numar_angajati) VALUES (77, 'consiliere', 1);  
INSERT INTO Departamente(id_departament, nume, numar_angajati) VALUES (88, 'biblioteca', 1);
INSERT INTO Departamente(id_departament, nume) VALUES (99, 'dormitoare');

--valori pentru tabela Slujba
INSERT INTO Slujba(id_slujba, id_departament, descriere, salariu, ora_inceput, ora_sfarsit, cerinte_calificare, responsabilitati, stoc_necesar) VALUES (1, 11, 'Profesor', 2500.00, '08:00:00', '16:00:00', 'Licenta in Educatie', 'predarea si indrumarea copiilor', 'materiale educative');
INSERT INTO Slujba(id_slujba, id_departament, descriere, salariu, ora_inceput, ora_sfarsit, cerinte_calificare, responsabilitati, stoc_necesar) VALUES (2, 22, 'Asistent medical', 2800.50, '07:00:00', '19:00:00', 'Licenta medicala', 'oferirea de ingrijiri medicale', 'medicamente si consumabile medicale');
INSERT INTO Slujba(id_slujba, id_departament, descriere, salariu, ora_inceput, ora_sfarsit, responsabilitati, stoc_necesar) VALUES (3, 33, 'Bucatar', 2000.00, '06:00:00', '14:00:00', 'pregatirea meselor pentru copii', 'ingrediente alimentare si ustensile de gatit');
INSERT INTO Slujba(id_slujba, id_departament, descriere, salariu, ora_inceput, ora_sfarsit, responsabilitati) VALUES (4, 44, 'Paznic', 1800.00, '00:00:00', '00:00:00', 'asigurarea securitatii orfelinatului');
INSERT INTO Slujba(id_slujba, id_departament, descriere, salariu, ora_inceput, ora_sfarsit, responsabilitati, stoc_necesar) VALUES (5, 55, 'Curatator/Femeie de servici', 1800.00, '08:00:00', '17:00:00', 'curatarea si intretinerea orfelinatului', 'produse de curatat');
INSERT INTO Slujba(id_slujba, id_departament, descriere, salariu, ora_inceput, ora_sfarsit, cerinte_calificare, responsabilitati, stoc_necesar) VALUES (6, 66, 'Director Orfelinat', 5000.00, '08:00:00', '18:00:00', 'Master in asistenta sociala', 'supravegherea operatiunilor si personalului orfelinatului', 'resurse administrative');
INSERT INTO Slujba(id_slujba, id_departament, descriere, salariu, ora_inceput, ora_sfarsit, cerinte_calificare, responsabilitati, stoc_necesar) VALUES (7, 77, 'Psiholog', 3200.00, '09:00:00', '17:00:00', 'Licenta in Psihologie', 'oferirea de consiliere si asistenta psihologica', 'materiale de birou si resurse terapeutice');
INSERT INTO Slujba(id_slujba, id_departament, descriere, salariu, ora_inceput, ora_sfarsit, responsabilitati, stoc_necesar) VALUES (8, 88, 'Bibliotecar', 1700.00, '08:00:00', '14:00:00', 'tinere evidenta imprumut carti', 'carti si manuale scolare');

--valori pentru tabela Incaperi
INSERT INTO Incaperi(numar_incapere, etaj, tip_incapere, id_departament) VALUES (98, 0, 'Paza', 44);
INSERT INTO Incaperi(numar_incapere, etaj, tip_incapere, id_departament) VALUES (99, 0, 'Curatatorie', 55);
INSERT INTO Incaperi(numar_incapere, etaj, tip_incapere, id_departament) VALUES (100, 1, 'Bucatarie', 33);
INSERT INTO Incaperi(numar_incapere, etaj, tip_incapere, id_departament, capacitate_maxima) VALUES (101, 1, 'Sala de clasa', 11, 25);
INSERT INTO Incaperi(numar_incapere, etaj, tip_incapere, id_departament, capacitate_maxima) VALUES (102, 1, 'Sala de clasa', 11, 25);
INSERT INTO Incaperi(numar_incapere, etaj, tip_incapere, id_departament) VALUES (103, 1, 'Cabinet medical', 22);
INSERT INTO Incaperi(numar_incapere, etaj, tip_incapere, id_departament, capacitate_maxima) VALUES (104, 1, 'Cantina', 33, 50);
INSERT INTO Incaperi(numar_incapere, etaj, tip_incapere, id_departament, capacitate_maxima) VALUES (200, 2, 'Dormitor', 99, 5);  
INSERT INTO Incaperi(numar_incapere, etaj, tip_incapere, id_departament, capacitate_maxima) VALUES (201, 2, 'Dormitor', 99, 5);
INSERT INTO Incaperi(numar_incapere, etaj, tip_incapere, id_departament, capacitate_maxima) VALUES (202, 2, 'Dormitor', 99, 5);
INSERT INTO Incaperi(numar_incapere, etaj, tip_incapere, id_departament, capacitate_maxima) VALUES (203, 2, 'Dormitor', 99, 5);
INSERT INTO Incaperi(numar_incapere, etaj, tip_incapere, id_departament, capacitate_maxima) VALUES (204, 2, 'Dormitor', 99, 5);
INSERT INTO Incaperi(numar_incapere, etaj, tip_incapere, id_departament, capacitate_maxima) VALUES (300, 3, 'Dormitor', 99, 3);
INSERT INTO Incaperi(numar_incapere, etaj, tip_incapere, id_departament, capacitate_maxima) VALUES (301, 3, 'Dormitor', 99, 3);
INSERT INTO Incaperi(numar_incapere, etaj, tip_incapere, id_departament, capacitate_maxima) VALUES (302, 3, 'Dormitor', 99, 3);
INSERT INTO Incaperi(numar_incapere, etaj, tip_incapere, id_departament, capacitate_maxima) VALUES (303, 3, 'Dormitor', 99, 3);
INSERT INTO Incaperi(numar_incapere, etaj, tip_incapere, id_departament, capacitate_maxima) VALUES (304, 3, 'Dormitor', 99, 3);
INSERT INTO Incaperi(numar_incapere, etaj, tip_incapere, id_departament, capacitate_maxima) VALUES (400, 4, 'Biblioteca', 88, 10);
INSERT INTO Incaperi(numar_incapere, etaj, tip_incapere, id_departament, capacitate_maxima) VALUES (401, 4, 'Dormitor', 99, 5);
INSERT INTO Incaperi(numar_incapere, etaj, tip_incapere, id_departament, capacitate_maxima) VALUES (402, 4, 'Dormitor', 99, 5);
INSERT INTO Incaperi(numar_incapere, etaj, tip_incapere, id_departament) VALUES (403, 4, 'Consiliere', 77);
INSERT INTO Incaperi(numar_incapere, etaj, tip_incapere, id_departament, capacitate_maxima) VALUES (404, 4, 'Biblioteca', 88, 40);

--valori pentru tabela Copii
INSERT INTO Copii(id_dosar_copil, CNP, nume, data_nastere, gen, numar_incapere) VALUES (1, '15678', 'Ana', '2010-05-15', 'Feminin', 200);
INSERT INTO Copii(id_dosar_copil, CNP, nume, data_nastere, gen, numar_incapere, informatii_medicale) VALUES (2, 1087612487672, 'Ion', '2012-08-20', 'Masculin', 201, 'Alergie la arahide');
INSERT INTO Copii(id_dosar_copil, CNP, nume, data_nastere, gen, numar_incapere, informatii_medicale) VALUES (3, 5678975421780, 'Maria', '2009-03-10', 'Feminin', 200, 'Diabet de tip 1');
INSERT INTO Copii(id_dosar_copil, CNP, nume, data_nastere, gen, numar_incapere, informatii_medicale) VALUES (4, 1098056893207, 'Alex', '2014-11-25', 'Masculin', 201, 'Apt');
INSERT INTO Copii(id_dosar_copil, CNP, nume, data_nastere, gen, numar_incapere, informatii_medicale) VALUES (5, 5646023604673, 'Andrei', '2011-07-03', 'Masculin', 202, 'Apt');
INSERT INTO Copii(id_dosar_copil, CNP, nume, data_nastere, gen, numar_incapere, informatii_medicale) VALUES (6, 1716099675467, 'Elena', '2010-02-12', 'Feminin', 203, 'Alergie la lactoză');
INSERT INTO Copii(id_dosar_copil, CNP, nume, data_nastere, gen, numar_incapere, informatii_medicale) VALUES (7, 2345612357805, 'Diana', '2012-05-18', 'Feminin', 301, 'Apt');
INSERT INTO Copii(id_dosar_copil, CNP, nume, data_nastere, gen, numar_incapere, informatii_medicale) VALUES (8, 4567815807547, 'Mihai', '2015-12-28', 'Masculin', 300, 'Apt');
INSERT INTO Copii(id_dosar_copil, CNP, nume, data_nastere, gen, numar_incapere, informatii_medicale) VALUES (9, 3458807438789, 'Vladimir', '2013-10-07', 'Masculin', 300, 'Asm');
INSERT INTO Copii(id_dosar_copil, CNP, nume, data_nastere, gen, numar_incapere) VALUES (10, 8789898745087, 'Stefan', '2013-12-25', 'Masculin', 300);

--valori pentru tabela Vizitatori
INSERT INTO Vizitatori(id_vizitator, nume, numar_telefon, relatie_cu_copilul) VALUES (1, 'John Doe', '0756978635', 'prieten');
INSERT INTO Vizitatori(id_vizitator, nume, numar_telefon, relatie_cu_copilul) VALUES (2, 'Maria Popescu', '0732156487', 'voluntar');
INSERT INTO Vizitatori(id_vizitator, nume, numar_telefon, relatie_cu_copilul) VALUES (3, 'Jane Smith', '0723456789', 'voluntar');
INSERT INTO Vizitatori(id_vizitator, nume, numar_telefon, relatie_cu_copilul) VALUES (4, 'Ion Ionescu', '0765432198', 'aplicant pentru plasament');
INSERT INTO Vizitatori(id_vizitator, nume, relatie_cu_copilul) VALUES (5, 'Elena Marin', 'aplicant pentru plasament');
INSERT INTO Vizitatori(id_vizitator, nume, numar_telefon, relatie_cu_copilul) VALUES (6, 'Alexandra Radu', '0758745698', 'aplicant pentru adoptie');
INSERT INTO Vizitatori(id_vizitator, nume, numar_telefon, relatie_cu_copilul) VALUES (7, 'Alexandra Radu', '0758745698', 'aplicant pentru plasament');
INSERT INTO Vizitatori(id_vizitator, nume, numar_telefon, relatie_cu_copilul) VALUES (8, 'Cristina Vasile', '0745123698', 'voluntar');
INSERT INTO Vizitatori(id_vizitator, nume, numar_telefon, relatie_cu_copilul) VALUES (9, 'George Popa', '0759687451', 'prieten');
INSERT INTO Vizitatori(id_vizitator, nume, relatie_cu_copilul) VALUES (10, 'Ana Ionescu', 'prieten');
INSERT INTO Vizitatori(id_vizitator, nume, numar_telefon, relatie_cu_copilul) VALUES (11, 'Dan Stan', '0723658749', 'aplicant pentru adoptie');
INSERT INTO Vizitatori(id_vizitator, nume, numar_telefon, relatie_cu_copilul) VALUES (12, 'Larisa Catanescu', '0759841263', 'aplicant pentru adoptie');

--valori pentru tabela Vizite
INSERT INTO Vizite (id_vizitator, id_dosar_copil, durata, scopul) VALUES (1, 1, '02:30:00', 'vizita regulata');
INSERT INTO Vizite (id_vizitator, id_dosar_copil, durata, scopul, comentarii) VALUES (12, 1, '01:00:00', 'vizita pentru adoptie', 'Vreau sa vad cum evoluam.');
INSERT INTO Vizite (id_vizitator, id_dosar_copil, durata, scopul) VALUES (2, 4, '01:15:00', 'vizita obisnuita');
INSERT INTO Vizite (id_vizitator, id_dosar_copil, durata, scopul, comentarii) VALUES (3, 5, '02:00:00', 'vizită de weekend', 'Ne-am jucat. Ma bucur ca ne intelegem.');
INSERT INTO Vizite (id_vizitator, id_dosar_copil, durata, scopul, comentarii) VALUES (5, 9, '01:30:00', 'vizita pentru adoptie', 'S-a deschis mai mult ca inainte.');
INSERT INTO Vizite (id_vizitator, id_dosar_copil, durata, scopul, comentarii) VALUES (4, 8, '02:15:00', 'vizita pentru plasament', 'Nu ne prea intelegem in ultima vreme.');
INSERT INTO Vizite (id_vizitator, id_dosar_copil, durata, scopul) VALUES (9, 3, '01:40:00', 'vizita obisnuita');
INSERT INTO Vizite (id_vizitator, id_dosar_copil, durata, scopul, comentarii) VALUES (6, 3, '01:05:00', 'vizita pentru adoptie', 'Nu am putut interactiona prea mult astazi.');
INSERT INTO Vizite (id_vizitator, id_dosar_copil, durata, scopul, comentarii) VALUES (6, 7, '01:05:00', 'vizita pentru adoptie', 'Nu am putut interactiona prea mult astazi.');
INSERT INTO Vizite (id_vizitator, id_dosar_copil, durata, scopul, comentarii) VALUES (7, 7, '02:05:00', 'vizita pentru plasament', 'S-a enervat putin pe mine.');
INSERT INTO Vizite (id_vizitator, id_dosar_copil, durata, scopul) VALUES (10, 2, '03:05:00', 'vizita obisnuita');
INSERT INTO Vizite (id_vizitator, id_dosar_copil, durata, scopul) VALUES (8, 2, '01:10:00', 'vizita de weekend');
INSERT INTO Vizite (id_vizitator, id_dosar_copil, durata, scopul) VALUES (8, 6, '01:10:00', 'vizita de weekend');
INSERT INTO Vizite (id_vizitator, id_dosar_copil, durata, scopul, comentarii) VALUES (11, 6, '01:30:00', 'vizita pentru adoptie', 'Ma place.');
INSERT INTO Vizite (id_vizitator, id_dosar_copil, durata, scopul) VALUES (10, 6, '00:50:00', 'vizita pentru adoptie');

--valori pentru tabela Activitati
INSERT INTO Activitati (cod_activitate, id_dosar_copil, descriere, indrumator_activitate, orar, locatie, numar_maxim_participanti, lucruri_necesare) VALUES (1, 1, 'Atelier de pictura', 'Ana Maria Popescu', '2023-11-10 14:00:00', 'Sala de arta din centru', 15, 'Panze, culori, pensule');
INSERT INTO Activitati (cod_activitate, id_dosar_copil, descriere, indrumator_activitate, orar, locatie, numar_maxim_participanti, lucruri_necesare) VALUES (1, 4, 'Atelier de pictura', 'Ana Maria Popescu', '2023-11-10 14:00:00', 'Sala de arta din centru', 15, 'Panze, culori, pensule');
INSERT INTO Activitati (cod_activitate, id_dosar_copil, descriere, indrumator_activitate, orar, locatie, numar_maxim_participanti, lucruri_necesare) VALUES (1, 8, 'Atelier de pictura', 'Ana Maria Popescu', '2023-11-10 14:00:00', 'Sala de arta din centru', 15, 'Panze, culori, pensule');
INSERT INTO Activitati (cod_activitate, id_dosar_copil, descriere, indrumator_activitate, orar, locatie, numar_maxim_participanti, lucruri_necesare) VALUES (2, 2, 'Lectie de matematica', 'George Ionescu', '2023-11-15 10:00:00', 'Sala de clasa', 10, 'Caiete, creioane');
INSERT INTO Activitati (cod_activitate, id_dosar_copil, descriere, indrumator_activitate, orar, locatie, numar_maxim_participanti, lucruri_necesare) VALUES (2, 9, 'Lectie de matematica', 'George Ionescu', '2023-11-15 10:00:00', 'Sala de clasa', 10, 'Caiete, creioane');
INSERT INTO Activitati (cod_activitate, id_dosar_copil, descriere, indrumator_activitate, orar, locatie, numar_maxim_participanti, lucruri_necesare) VALUES (2, 3, 'Lectie de matematica', 'George Ionescu', '2023-11-15 10:00:00', 'Sala de clasa', 10, 'Caiete, creioane');
INSERT INTO Activitati (cod_activitate, id_dosar_copil, descriere, indrumator_activitate, orar, locatie, numar_maxim_participanti, lucruri_necesare) VALUES (3, 2, 'Sesiune de terapie', 'Andreea Vasile', '2023-11-12 16:30:00', 'Cabinetul terapeutic', 5, 'Jucarii terapeutice');
INSERT INTO Activitati (cod_activitate, id_dosar_copil, descriere, indrumator_activitate, orar, locatie, numar_maxim_participanti, lucruri_necesare) VALUES (3, 8, 'Sesiune de terapie', 'Andreea Vasile', '2023-11-12 16:30:00', 'Cabinetul terapeutic', 5, 'Jucarii terapeutice');
INSERT INTO Activitati (cod_activitate, id_dosar_copil, descriere, indrumator_activitate, orar, locatie, numar_maxim_participanti, lucruri_necesare) VALUES (3, 1, 'Sesiune de terapie', 'Andreea Vasile', '2023-11-12 16:30:00', 'Cabinetul terapeutic', 5, 'Jucarii terapeutice');
INSERT INTO Activitati (cod_activitate, id_dosar_copil, descriere, indrumator_activitate, orar, locatie, numar_maxim_participanti, lucruri_necesare) VALUES (4, 5, 'Spectacol de teatru', 'Elena Marin', '2023-11-18 19:00:00', 'Sala de spectacole din parc', 20, 'Costume de teatru');
INSERT INTO Activitati (cod_activitate, id_dosar_copil, descriere, indrumator_activitate, orar, locatie, numar_maxim_participanti, lucruri_necesare) VALUES (4, 3, 'Spectacol de teatru', 'Elena Marin', '2023-11-18 19:00:00', 'Sala de spectacole din parc', 20, 'Costume de teatru');
INSERT INTO Activitati (cod_activitate, id_dosar_copil, descriere, indrumator_activitate, orar, locatie, numar_maxim_participanti, lucruri_necesare) VALUES (4, 1, 'Spectacol de teatru', 'Elena Marin', '2023-11-18 19:00:00', 'Sala de spectacole din parc', 20, 'Costume de teatru');
INSERT INTO Activitati (cod_activitate, id_dosar_copil, descriere, indrumator_activitate, orar, locatie, numar_maxim_participanti, lucruri_necesare) VALUES (5, 10, 'Excursie la muzeu', 'Ion Ionescu', '2023-11-20 09:30:00', 'Muzeu local', 25, 'Bilete de intrare');
INSERT INTO Activitati (cod_activitate, id_dosar_copil, descriere, indrumator_activitate, orar, locatie, numar_maxim_participanti, lucruri_necesare) VALUES (5, 3, 'Excursie la muzeu', 'Ion Ionescu', '2023-11-20 09:30:00', 'Muzeu local', 25, 'Bilete de intrare');
INSERT INTO Activitati (cod_activitate, id_dosar_copil, descriere, indrumator_activitate, orar, locatie, numar_maxim_participanti, lucruri_necesare) VALUES (5, 6, 'Excursie la muzeu', 'Ion Ionescu', '2023-11-20 09:30:00', 'Muzeu local', 25, 'Bilete de intrare');
INSERT INTO Activitati (cod_activitate, id_dosar_copil, descriere, indrumator_activitate, orar, locatie, numar_maxim_participanti, lucruri_necesare) VALUES (6, 7, 'Lectie de dans', 'Larisa Catanescu', '2023-11-16 14:30:00', 'Sala de dans de la scoala "Maltes"', 15, 'Haine confortabile');
INSERT INTO Activitati (cod_activitate, id_dosar_copil, descriere, indrumator_activitate, orar, locatie, numar_maxim_participanti, lucruri_necesare) VALUES (6, 6, 'Lectie de dans', 'Larisa Catanescu', '2023-11-16 14:30:00', 'Sala de dans de la scoala "Maltes"', 15, 'Haine confortabile');
INSERT INTO Activitati (cod_activitate, id_dosar_copil, descriere, indrumator_activitate, orar, locatie, numar_maxim_participanti, lucruri_necesare) VALUES (6, 10, 'Lectie de dans', 'Larisa Catanescu', '2023-11-16 14:30:00', 'Sala de dans de la scoala "Maltes"', 15, 'Haine confortabile');
INSERT INTO Activitati (cod_activitate, id_dosar_copil, descriere, indrumator_activitate, orar, locatie, numar_maxim_participanti, lucruri_necesare) VALUES (6, 5, 'Lectie de dans', 'Larisa Catanescu', '2023-11-16 14:30:00', 'Sala de dans de la scoala "Maltes"', 15, 'Haine confortabile');
INSERT INTO Activitati (cod_activitate, id_dosar_copil, descriere, indrumator_activitate, orar, locatie, numar_maxim_participanti) VALUES (7, 3, 'Club de carte', 'Lucaci Marinela', '2023-10-05 10:00:00', 'Biblioteca', 20);
INSERT INTO Activitati (cod_activitate, id_dosar_copil, descriere, indrumator_activitate, orar, locatie, numar_maxim_participanti) VALUES (7, 3, 'Club de carte', 'Lucaci Marinela', '2023-10-05 10:00:00', 'Biblioteca', 20);
INSERT INTO Activitati (cod_activitate, id_dosar_copil, descriere, indrumator_activitate, orar, locatie, numar_maxim_participanti) VALUES (7, 9, 'Club de carte', 'Lucaci Marinela', '2023-10-05 10:00:00', 'Biblioteca', 20);
INSERT INTO Activitati (cod_activitate, id_dosar_copil, descriere, indrumator_activitate, orar, locatie, numar_maxim_participanti) VALUES (7, 5, 'Club de carte', 'Lucaci Marinela', '2023-10-05 10:00:00', 'Biblioteca', 20);
INSERT INTO Activitati (cod_activitate, id_dosar_copil, descriere, indrumator_activitate, orar, locatie, numar_maxim_participanti) VALUES (7, 6, 'Club de carte', 'Lucaci Marinela', '2023-10-05 10:00:00', 'Biblioteca', 20);
INSERT INTO Activitati (cod_activitate, id_dosar_copil, descriere, indrumator_activitate, orar, locatie, numar_maxim_participanti) VALUES (7, 7, 'Club de carte', 'Lucaci Marinela', '2023-10-05 10:00:00', 'Biblioteca', 20);

--valori pentru tabela Angajati
INSERT INTO Angajati (id_angajat, nume, adresa, email, numar_telefon, experienta, data_angajarii, id_slujba) VALUES (11, 'Ana Maria Popescu', 'Strada Principala 123', 'ana.popescu@email.com', '0723456789', 'lucrat la spital de copii', '2023-09-15', 2);
INSERT INTO Angajati (id_angajat, nume, adresa, email, numar_telefon, experienta, data_angajarii, id_slujba) VALUES (22, 'George Ionescu', 'Strada Secundara 45', 'george.ionescu@email.com', '0732156487', 'Licenta in medicina', '2023-10-01', 2);
INSERT INTO Angajati (id_angajat, nume, adresa, email, numar_telefon, experienta, data_angajarii, id_slujba) VALUES (33, 'Andreea Vasile', 'Strada Primaverii 67', 'andreea.vasile@email.com', '0745123698', 'bucatar calificat', '2023-08-20', 3);
INSERT INTO Angajati (id_angajat, nume, adresa, email, numar_telefon, data_angajarii, id_slujba) VALUES (44, 'Mihai Gheorghe', 'Strada Soarelui 89', 'mihai.gheorghe@email.com', '0765432198', '2023-09-10', 3);
INSERT INTO Angajati (id_angajat, nume, adresa, email, numar_telefon, data_angajarii, id_slujba) VALUES (55, 'Elena Marin', 'Strada Frunzelor 12', 'elena.marin@email.com', '0749876512', '2023-11-02', 3);
INSERT INTO Angajati (id_angajat, nume, adresa, email, numar_telefon, data_angajarii, id_slujba) VALUES (66, 'Ion Ionescu', 'Strada Copiilor 34', 'ion.ionescu@email.com', '0759687451', '2023-07-15', 3);
INSERT INTO Angajati (id_angajat, nume, adresa, email, numar_telefon, data_angajarii, id_slujba) VALUES (77, 'Larisa Cătănescu', 'Strada Muzicii 56', 'larisa.catanesu@email.com', '0759841263', '2023-10-10', 4);
INSERT INTO Angajati (id_angajat, nume, adresa, email, numar_telefon, data_angajarii, id_slujba) VALUES (88, 'Cristina Vasile', 'Strada Fructelor 78', 'cristina.vasile@email.com', '0723658749', '2023-10-18', 4);
INSERT INTO Angajati (id_angajat, nume, adresa, email, numar_telefon, data_angajarii, id_slujba) VALUES (99, 'Alexandru Popa', 'Strada Florilor 23', 'alexandru.popa@email.com', '0732147896', '2023-09-30', 5);
INSERT INTO Angajati (id_angajat, nume, adresa, email, numar_telefon, data_angajarii, id_slujba) VALUES (111, 'Simona Iordache', 'Strada Pacii 67', 'simona.iordache@email.com', '0723654897', '2023-11-05', 5);
INSERT INTO Angajati (id_angajat, nume, adresa, email, numar_telefon, experienta, data_angajarii, id_slujba) VALUES (222, 'Andrei Ionescu', 'Strada Copiilor 56', 'andrei.ionescu@email.com', '0723456789', 'Licenta in educatie', '2023-08-10', 1);
INSERT INTO Angajati (id_angajat, nume, adresa, email, numar_telefon, data_angajarii, id_slujba) VALUES (333, 'Mariana Cozma', 'Strada Culorilor 34', 'mariana.cozma@email.com', '0732156487', '2023-11-20', 1);
INSERT INTO Angajati (id_angajat, nume, adresa, email, numar_telefon, experienta, data_angajarii, id_slujba) VALUES (444, 'Iulia Popescu', 'Strada Muzicii 78', 'iulia.popescu@email.com', '0745123698', 'Specializare asistenta sociala', '2023-09-05', 6);
INSERT INTO Angajati (id_angajat, nume, adresa, email, numar_telefon, experienta, data_angajarii, id_slujba) VALUES (555, 'Stefan Gheorghe', 'Strada Soarelui 23', 'stefan.gheorghe@email.com', '0765432198', 'Specializare in educatie speciala, experienta in arta terapiei', '2023-11-15', 7);
INSERT INTO Angajati (id_angajat, nume, adresa, email, numar_telefon, experienta, data_angajarii, id_slujba) VALUES (666, 'Raluca Iancu', 'Strada Frunzelor 67', 'raluca.iancu@email.com', '0732147896', 'Experienta in lucrul cu copiii', '2023-08-30', 8);

--valori pentru tabela Donatori
INSERT INTO Donatori (id_donator, nume, email, numar_telefon, data_inscrierii, stare_donator) VALUES (1010, 'John Smith', 'john.smith@gmail.com', '0723456789', '2023-09-05 10:00:00', 'Activ');
INSERT INTO Donatori (id_donator, nume, email, numar_telefon, data_inscrierii, stare_donator) VALUES (2020, 'Maria Popa', 'maria.popa@gmail.com', '0732156487', '2023-10-10 11:30:00', 'Activ');
INSERT INTO Donatori (id_donator, nume, numar_telefon, data_inscrierii, stare_donator) VALUES (3030, 'Ion Ionescu', '0765432198', '2023-11-15 14:45:00', 'Suspendat');
INSERT INTO Donatori (id_donator, nume, email, numar_telefon, data_inscrierii, stare_donator) VALUES (4040, 'Elena Marin', 'elena.marin@gmail.com', '0749876512', '2023-09-20 09:15:00', 'Activ');
INSERT INTO Donatori (id_donator, nume, numar_telefon, data_inscrierii, stare_donator) VALUES (5050, 'George Popescu', '0759687451', '2023-10-25 13:30:00', 'Inactiv');

--valori pentru tabela Donatii
INSERT INTO Donatii (id_departament, id_donator, continut, suma) VALUES (99, 1010, 'Haine pentru copii', 500.00);
INSERT INTO Donatii (id_departament, id_donator, continut, suma) VALUES (11, 2020, 'Rechizite', 500.00);
INSERT INTO Donatii (id_departament, id_donator, continut, suma) VALUES (77, 2020, 'Jucarii pentru copii', 300.00);
INSERT INTO Donatii (id_departament, id_donator, continut, suma) VALUES (88, 3030, 'Carti si materiale pentru educatie', 750.00);
INSERT INTO Donatii (id_departament, id_donator, continut, suma) VALUES (99, 4040, 'Haine pentru copii', 350.00);
INSERT INTO Donatii (id_departament, id_donator, continut, suma) VALUES (33, 5050, 'Mancare si provizii', 450.00);
INSERT INTO Donatii (id_departament, id_donator, continut, suma) VALUES (66, 1010, 'Bani renovari orfelinat', 1000.00);
INSERT INTO Donatii (id_departament, id_donator, continut, suma) VALUES (11, 4040, 'Bani banci si scaune', 6000.00);
INSERT INTO Donatii (id_departament, id_donator, continut, suma) VALUES (22, 5050, 'Bani medicamente si vaccinuri', 2500.00);
INSERT INTO Donatii (id_departament, id_donator, continut, suma) VALUES (55, 3030, 'Materiale curatatorie', 2500.00);

SELECT * FROM Slujba;
SELECT * FROM Departamente;
SELECT * FROM Incaperi;
SELECT * FROM Copii;
SELECT * FROM Vizitatori;
SELECT * FROM Vizite;
SELECT * FROM Activitati;
SELECT * FROM Angajati;
SELECT * FROM Donatori;
SELECT * FROM Donatii;

/*
DELETE FROM Donatii;
DELETE FROM Activitati;
DELETE FROM Vizite;
DELETE FROM Angajati;
DELETE FROM Copii;
DELETE FROM Incaperi;
DELETE FROM Departamente;
DELETE FROM Slujba;
DELETE FROM Vizitatori;
DELETE FROM Donatori;
*/