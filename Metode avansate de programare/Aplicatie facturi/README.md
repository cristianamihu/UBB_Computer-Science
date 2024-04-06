Cerinte de proiectare:
- Interfata IRepository<ID, E> where E : Entity<ID> expune o singura metoda publica, IEnumerable<E> FindAll(), care returneaza o colectie formata din toate entitatile de tipul <E>
- Clasa Document (nume: string , dataEmitere: DateTime) extinde Entity <string>
- Clasa Factura (dataScadenta: DateTime, achizitii: List<Achizitie>, categorie: Enum{Utilities, Groceries, Fashion, Entertainment, Electronics}) extinde Document
- Clasa Achizitie extinde Entity <string> si are urmatoarele atribute: produs: string, cantitate: int, pretProdus: double, factura: Factura
- Fisierele documente.txt, facturi.txt, achizitii.txt contin informatiile despre documente, facturi si achizitii, fiecare inregistrare pe o linie noua, atributele despartite prin “,”
    In fisierul documente.txt o linie este de forma: <idDocument>, <nume>, <dataEmitere>;
    In fisierul facturi.txt o linie este de forma: <idDocument>, <dataScadenta>, <categorie>;
    In fisierul achizitii.txt o linie este de forma: <idAchizitie>, <produs>, <cantitate>, <pretProdus>, <idDocument>.

- Procesarea are loc numai la nivel de service sau de controller
- Interactiunea cu sursa de date se face numai prin intermediul repository-ului
- La nivel de service se va folosi interfata IRepository de mai sus
- Interactiunea cu utilizatorul are loc numai in UI
- Interfata IRepository nu expune alte metode decat cele specificate mai sus
- Am folosit LINQ (ca sintaxa asemanatoare cu SQL).

  
Cerinte functionale:

1. 2.0p Se afiseaza toate documentele (nume, dataEmitere) emise in anul 2023
2. 2.0p Se afiseaza toate facturile (nume, dataScadenta) scadente in luna curenta. Luna curenta nu se hardcodeaza, este preluata de la sistem
3. 1.5p Se afiseaza toate facturile (nume, nrProduse) cu cel putin 3 produse achizitionate (se considera si cantitatea)
4. 1.5p Se afiseaza toate achizitiile (produs, numeFactura) din categoria Utilities
5. 2.0p Se afiseaza categoria de facturi care a inregistrat cele mai multe cheltuieli

![image](https://github.com/cristianamihu/UBB_Computer-Science/assets/128689630/1c720efc-df4f-45c4-b29d-5d79ef123133)
