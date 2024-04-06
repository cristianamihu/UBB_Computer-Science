namespace tema_lab12.Domain;

public class Achizitie : Entity<string>
{
    public String  produs { get; set; }
    public int cantitate { get; set; }
    public Double pretProdus { get; set; }
    public String idDoc { get; set; }
    public override string ToString()
    {
        return produs + " " + cantitate + " " + pretProdus + " " + idDoc;
    }
}