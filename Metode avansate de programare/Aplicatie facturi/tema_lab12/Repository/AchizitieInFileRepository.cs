using tema_lab12.Domain;

namespace tema_lab12.Repository;

public class AchizitieInFileRepository: InFileRepository<string,Achizitie>
{
    public AchizitieInFileRepository(string fileName) : base(fileName, EntityToFileMapping.CreateAchizitie)
    {
    } 
}