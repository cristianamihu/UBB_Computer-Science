Cerințe de proiectare:
- Interfata IRepository<ID, E> where E : Entity<ID> expune o singură metodă publică, IEnumerable<E>
FindAll(), care returnează o colecție formata din toate entitățile de tipul <E>;
- Clasa Document (nume: string , dataEmitere: DateTime) extinde Entity <string>
- Clasa Factura (dataScadenta: DateTime, achizitii:List<Achizitie>, categorie: Enum{Utilities, Groceries,
Fashion, Entertainment, Electronics}) extinde Document;
- Clasa Achizitie extinde Entity <string> si are următoarele atribute:
produs: string, cantitate: int, pretProdus: double, factura: Factura
- Fișierele documente.txt, facturi.txt, achizitii.txt conțin informațiile despre documente, facturi și achizitii,
fiecare înregistrare pe o linie noua, atributele despărțite prin “,”.
In fișierul documente.txt o linie va fi de forma: <idDocument>, <nume>, <dataEmitere>;
In fișierul facturi.txt o linie va fi de forma: <idDocument>, <dataScadenta>, <categorie>;
In fisierul achizitii.txt o linie va fi de forma: <idAchizitie>, <produs>, <cantitate>,
<pretProdus>,<idDocument>.
- Procesarea va avea loc numai la nivel de service sau de controller; interacțiunea cu sursa de date se va face
numai prin intermediul repository-ului.
- La nivel de service se va folosi interfața IRepository de mai sus
- Interacțiunea cu utilizatorul va avea loc numai in UI
- Interfața IRepository nu va expune alte metode decat cele specificate mai sus
- La nivel de repository se pot folosi oricâte clase pentru implementarea interfeței IRepository si pentru
interacțiunea cu fișierele;
Cerințe funcționale
1. 2.0p Sa se afișeze toate documentele (nume, dataEmitere) emise in anul 2023
2. 2.0p Sa se afișeze toate facturile (nume, dataScadenta) scadente in luna curenta.
Luna curenta nu se hardcodeaza, este preluata de la sistem.
3. 1.5p Sa se afiseze toate facturile (nume, nrProduse) cu cel putin 3 produse achizitionate (se considera si
cantitatea).
4. 1.5p Sa se afișeze toate achizitiile (produs, numeFactura) din categoria Utilities.
5. 2.0p Sa se afișeze categoria de facturi care a înregistrat cele mai multe cheltuieli

Am folosit LINQ (ca sintaxa asemanatoare cu SQL).

![image](https://github.com/cristianamihu/UBB_Computer-Science/assets/128689630/1c720efc-df4f-45c4-b29d-5d79ef123133)
