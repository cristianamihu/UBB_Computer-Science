	Am creat o aplicatie Windows folosind framework-ul .NET si o baza de date Microsoft SQL Server. Aplicatia contine o fereastra prin intermediul careia se pot manipula datele a doua tabele aflate in
 relatie 1-n (pe care le numim tabela parinte si tabela fiu). Functionalitatile implementate sunt:
	- se afiseaza toate inregistrarile tabelei parinte (tabela Copii);
	- la selectarea unei inregistrari din parinte se vor afisa toate inregistrarile tabelei fiu (tabela Activitati);
	- la selectarea unei inregistrari din fiu se permite stergerea sau actualizarea datelor acesteia;
	- avand selectata o inregistrare din parinte se permite adaugarea unei noi inregistrari fiu;

	Pentru comunicarea cu baza de date am utilizat data sets si data adapters.

Apasand butonul "Display" se vor incarca toate inregistrarile din tabela Copii, iar in momentul in care selectezi o inregistrare din acest tabel se vor afisa toate inregistrarile aferente acelui copil din tabela Activitati. Introducand date dorite in fiecare textBox si apasand botunoul "Adauga" va aparea inregistrarea in tabelul de Activitati destinat copilului selectat. Daca se selecteaza o inregistrare din tabelul Activitati se permite stergerea sau actualizarea acesteia.
 ![image](https://github.com/cristianamihu/UBB_Computer-Science/assets/128689630/3c19c6d7-308f-4a7c-895e-4a98619c1dc5)

  Toate aceste functionalitati se observa si in baza de date.

 Aceasta este diagrama bazei de date, iar tabelele folosite in aceasta aplicatie sunt Copii si Activitati:
![Diagrama Orfelinat](https://github.com/cristianamihu/UBB_Computer-Science/assets/128689630/4935afa9-1b96-4304-89fd-e911e06ff11f)
