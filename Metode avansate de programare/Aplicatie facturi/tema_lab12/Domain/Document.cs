namespace tema_lab12.Domain;

public class Document : Entity<string>
{
    public String nume { get; set; }
    public DateTime dataEmitere { get; set; }
    public override string ToString()
    {
        return Id +" "+ nume +" "+ dataEmitere;
    }
}