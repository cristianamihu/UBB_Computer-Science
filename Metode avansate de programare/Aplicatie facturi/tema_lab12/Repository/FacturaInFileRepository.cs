using tema_lab12.Domain;

namespace tema_lab12.Repository;

public class FacturaInFileRepository : InFileRepository<string,Factura>
{
    public FacturaInFileRepository( string fileName) : base(fileName, null)
    {
        loadFromFile();
    }

    private new void loadFromFile()
    {
        List<Achizitie> achizitii = DataReader.ReadData<Achizitie>(
            "C:\\Users\\fgfhf\\Documents\\UBB - Computer science\\second year\\first semester\\Metode avansate de programare\\tema_lab12\\tema_lab12\\Resources\\achizitii.txt",
            EntityToFileMapping.CreateAchizitie);
        List<Document> documente = DataReader.ReadData<Document>(
            "C:\\Users\\fgfhf\\Documents\\UBB - Computer science\\second year\\first semester\\Metode avansate de programare\\tema_lab12\\tema_lab12\\Resources\\documente.txt",
            EntityToFileMapping.CreateDocument);
        using (StreamReader sr = new StreamReader(fileName))
        {
            string line;
            while ((line = sr.ReadLine()) != null)
            {
                string[] fields = line.Split(',');
                Document d = documente.Find(x => x.Id.Equals(fields[0]));
                string nume = d.nume;
                DateTime dataEmitere = d.dataEmitere;
                List<Achizitie> achizitii1 = achizitii.Where(x => x.idDoc.Equals(fields[0])).ToList();
                Factura factura = new Factura()
                {
                    Id = fields[0],
                    nume = nume,
                    dataEmitere = dataEmitere,
                    dataScadenta = DateTime.Parse(fields[1]),
                    achizitii = achizitii1,
                    categorie = (Categorii)Enum.Parse(typeof(Categorii), fields[2]),
                };
                base.entities[factura.Id] = factura;
            }
        }
    }
}