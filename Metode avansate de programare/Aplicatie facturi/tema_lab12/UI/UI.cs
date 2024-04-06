namespace tema_lab12.UI;

public class UI
{
    private Service.Service service;

    public UI(Service.Service serv)
    {
        this.service = serv;
    }

    public void cerinta1()
    {
        foreach (var x in service.documente2023().ToList())
        {
            Console.WriteLine(x);
        }
    }
    public void cerinta2()
    {
        Console.WriteLine("Facturi din luna curenta:");
        string l = Console.ReadLine();
            foreach (var x in service.facturiLunaCurenta())
            {
                Console.WriteLine(x);
            }
    }
    public void cerinta3()
    {
        foreach (var x in service.facturiMin3().ToList())
        {
            Console.WriteLine(x);
        }
    }
    public void cerinta4()
    {
        foreach (var x in service.achizitiiU().ToList())
        {
            Console.WriteLine(x);
        }

    }
    public void cerinta5()
    {
        Console.WriteLine(service.categorieMax().Value.ToString());
    }
    public void run()
    { 
        Console.WriteLine(" Optiuni:");
        Console.WriteLine("   1.  Sa se afiseze toate documentele (nume, dataEmitere) emise in anul 2023.");
        Console.WriteLine("   2.  Sa se afiseze toate facturile (nume, dataScadenta) scadente in luna curenta.");
        Console.WriteLine("   3.  Sa se afiseze toate facturile (nume, nrProduse) cu cel putin 3 produse achizitionate.");
        Console.WriteLine("   4.  Sa se afiseze toate achizitiile (produs, numeFactura) din categoria Utilities.");
        Console.WriteLine("   5.  Sa se afiseze categoria de facturi care a înregistrat cele mai multe cheltuieli.");
        Console.WriteLine("exit");
        while (true)
        {
            string x = Console.ReadLine();
            if(x.Equals("exit"))
                break;
            switch (x)
            {
                case "1":
                    cerinta1();
                    break;
                case "2":
                    cerinta2();
                    break;
                case "3":
                    cerinta3();
                    break;
                case "4":
                    cerinta4();
                    break;
                case "5":
                    cerinta5();
                    break;
                default:
                    Console.WriteLine("Introdu un numar de cerinta valid!");
                    break;
            }
        }
    }
}