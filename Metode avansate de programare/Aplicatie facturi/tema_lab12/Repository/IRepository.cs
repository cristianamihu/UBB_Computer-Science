using tema_lab12.Domain;

namespace tema_lab12.Repository;

public interface IRepository<ID,E> where E : Entity<ID>
{
    public IEnumerable<E> FindAll();
}