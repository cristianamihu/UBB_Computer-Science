using tema_lab12.Domain;

namespace tema_lab12.Repository;

public class InMemoryRepository<ID,E> : IRepository<ID,E> where E:Entity<ID>
{
    protected IDictionary<ID, E> entities = new Dictionary<ID, E>();
  
    public IEnumerable<E> FindAll()
    {
        return entities.Values.ToList<E>();
    }
    
    
}