using tema_lab12.Domain;

namespace tema_lab12.Repository;

public delegate E CreateEntity<E>(string line);
public class InFileRepository<ID,E> : InMemoryRepository<ID,E> where E : Entity<ID>
{
    protected string fileName;
    protected CreateEntity<E> createEntity;
    public InFileRepository(String fileName, CreateEntity<E> createEntity)
    {
        this.fileName = fileName;
        this.createEntity = createEntity;
        if (createEntity != null)
            loadFromFile();
    }

    protected virtual void loadFromFile()
    {
        List<E> list = DataReader.ReadData(fileName, createEntity);
        list.ForEach(x => entities[x.Id] = x);
    }

    
}