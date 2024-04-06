using tema_lab12.Domain;
using tema_lab12.Repository;

namespace tema_lab12.Service;

public class Service
{
    private IRepository<string, Achizitie> repoa;
    private IRepository<string, Document> repod;
    private IRepository<string, Factura> repof;

    public Service(IRepository<string, Achizitie> repoa,IRepository<string, Document> repod,IRepository<string, Factura> repof)
    {
        this.repoa = repoa;
        this.repod = repod;
        this.repof = repof;
    }
    public List<Achizitie> FindAllAchizitii()
    {
        return repoa.FindAll().ToList();
    } 
    public List<Document> FindAllDocumente()
    {
        return repod.FindAll().ToList();
    }
    public List<Factura> FindAllFacturi()
    {
        return repof.FindAll().ToList();
    }
    public IEnumerable<string> documente2023()
    {
        List<Document> all = FindAllDocumente();
        var d2023 = from d in all
            where d.dataEmitere.Year.Equals(2023)
            select d.nume + ", "+ d.dataEmitere;
        return d2023;
    }
    public IEnumerable<string> facturiLunaCurenta()
    {
        List<Factura> all = FindAllFacturi();
        var fc = from f in all
            where f.dataScadenta.Month.Equals(DateTime.Now.Month)
            select f.nume + ", "+ f.dataScadenta;
        return fc;
    }

    public IEnumerable<string> facturiMin3()
    {
        List<Factura> all = FindAllFacturi();
        var fm3 = from f in all
            where f.achizitii.Sum(a => a.cantitate) >= 3
            select f.nume + ", " + f.achizitii.Sum(a => a.cantitate);
        return fm3;
    }

    public IEnumerable<string> achizitiiU()
    {
        List<Factura> allf = FindAllFacturi();
        List<Achizitie> alla = FindAllAchizitii();
        var aU = from a in alla
            join f in allf on a.idDoc equals f.Id
            where f.categorie.ToString().Equals("Utilities")
            select a.produs + ", " + f.nume;
        return aU;
    }

    public Nullable<Categorii> categorieMax()
    {
        List<Factura> allf = FindAllFacturi();
        return allf
            .SelectMany(f => f.achizitii, ((factura, achizitie) => new { factura.categorie, achizitie.cantitate }))
            .GroupBy(f => f.categorie)
            .Select(f => new { categorie = f.Key, CantitateTotala = f.Sum(x => x.cantitate) })
            .MaxBy(f => f.CantitateTotala)?.categorie;
    }
}