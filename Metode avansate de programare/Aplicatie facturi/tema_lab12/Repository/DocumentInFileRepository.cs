using tema_lab12.Domain;

namespace tema_lab12.Repository;

public class DocumentInFileRepository : InFileRepository<string,Document>
{
    public DocumentInFileRepository(string fileName) : base(fileName,
        EntityToFileMapping.CreateDocument)
    {
        
    }
}