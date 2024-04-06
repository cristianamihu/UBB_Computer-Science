// See https://aka.ms/new-console-template for more information

using tema_lab12.Domain;
using tema_lab12.Repository;
using tema_lab12.Service;
using tema_lab12.UI;

IRepository<string,Document> repod=new DocumentInFileRepository("C:\\Users\\fgfhf\\Documents\\UBB - Computer science\\second year\\first semester\\Metode avansate de programare\\tema_lab12\\tema_lab12\\Resources\\documente.txt");
IRepository<string,Factura> repof=new FacturaInFileRepository("C:\\Users\\fgfhf\\Documents\\UBB - Computer science\\second year\\first semester\\Metode avansate de programare\\tema_lab12\\tema_lab12\\Resources\\facturi.txt");
IRepository<string,Achizitie> repoa=new AchizitieInFileRepository("C:\\Users\\fgfhf\\Documents\\UBB - Computer science\\second year\\first semester\\Metode avansate de programare\\tema_lab12\\tema_lab12\\Resources\\achizitii.txt");
Service service=new Service(repoa,repod,repof);
UI ui=new UI(service);
ui.run();