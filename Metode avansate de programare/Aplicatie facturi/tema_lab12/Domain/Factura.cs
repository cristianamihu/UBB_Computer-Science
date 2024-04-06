namespace tema_lab12.Domain;

public enum Categorii
{
    Utilities, Groceries, Fashion, Entertainment, Electronics
}
public class Factura : Document
{
    public DateTime dataScadenta { get; set; }
    public List<Achizitie> achizitii { get; set; }
    public Categorii categorie { get; set; }
    public override string ToString()
    {
        return base.ToString() + dataScadenta + " " + achizitii + " " + categorie;
    }
}