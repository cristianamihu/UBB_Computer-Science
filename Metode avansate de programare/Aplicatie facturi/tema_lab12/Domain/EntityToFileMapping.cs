namespace tema_lab12.Domain;

public class EntityToFileMapping
{
    public static Document CreateDocument(string line)
    {
        string[] fields = line.Split(',');
        Document document = new Document()
        {
            Id = fields[0],
            nume = fields[1],
            dataEmitere = DateTime.Parse(fields[2])
        };
        return document;
    }
    public static Achizitie CreateAchizitie(string line)
    {
        string[] fields = line.Split(',');
        Achizitie achizitie = new Achizitie()
        {
            Id = fields[0],
            produs = fields[1],
            cantitate = Int32.Parse(fields[2]),
            pretProdus = Double.Parse(fields[3]),
            idDoc = fields[4]
        };
        return achizitie;
    }
}