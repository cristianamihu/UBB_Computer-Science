	Am creat o aplicatie Windows folosind framework-ul .NET si o baza de date Microsoft SQL Server. Aplicatia contine o fereastra prin intermediul careia se pot manipula datele a doua tabele aflate in relatie 1-n (pe care le numim tabela parinte si tabela fiu). Functionalitatile implementate sunt:
	- se afiseaza toate inregistrarile tabelei parinte (tabela Copii);
	- la selectarea unei inregistrari din parinte se vor afisa toate inregistrarile tabelei fiu (tabela Activitati);
	- la selectarea unei inregistrari din fiu se permite stergerea sau actualizarea datelor acesteia;
	- avand selectata o inregistrare din parinte se permite adaugarea unei noi inregistrari fiu;

	Pentru comunicarea cu baza de date am utilizat data sets si data adapters.
