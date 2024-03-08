#include<iostream>
#include<fstream>
using namespace std;

int a[101][101],b[101][101],nr_vecini[10],n,d[101][101],nr_muchii=0;

ifstream f("in.txt");

void trecere_matrice_adiacenta_in_lista_adiacenta(int a[101][101],int b[101][101],int n)
{
    for(int i=1;i<=n;i++)
        {
            int k=1;
            for(int j=1;j<=n;j++)
                if(a[i][j]==1)
                    {
                        k=k+1;
                        b[i][k]=j;
                    }
        }
    for(int i=1;i<=n;i++)
        b[i][1]=i;
}

void trecere_matrice_adiacenta_in_matrice_incidenta(int a[101][101],int d[101][101],int n)
{
    int k=0;
    for(int i=1;i<=n;i++)
        {
            for(int j=1;j<=n;j++)
                if(a[i][j]==1 && i<j )
                    {
                        k=k+1;
                        d[i][k]=1;
                        d[j][k]=1;
                    }
        }
}

void afisare(int a[101][101],int n,int m)
{
    for(int i=1;i<=n;i++)
        {
            for(int j=1;j<=m;j++)
                cout<<a[i][j];
            cout<<endl;
        }
}

int main()
{
    f>>n;
    int x,y;
    while(f>>x>>y)
        {
            nr_muchii++;
            a[x][y]=a[y][x]=1;
        }
    for(int i=1;i<=n;i++)
        for(int j=1;j<=n;j++)
            {
                if(a[i][j]==1)
                nr_vecini[i]++;
            }

    afisare(a,n,n);    //afisare matrice de adiacenta
    cout<<endl;

    trecere_matrice_adiacenta_in_lista_adiacenta(a,b,n);
    afisare(b,n,n);    //afisare lista de adiacenta
    cout<<endl;

    trecere_matrice_adiacenta_in_matrice_incidenta(a,d,n);
    afisare(d,n,nr_muchii);     //afisare matrice de incidenta
    cout<<endl;

    return 0;
}











//void trecere_lista_adiacenta_in_matrice_adiacenta(int a[101][101],int b[101][101],int c[10],int n)
//{
//    for(int i=1;i<=n;i++)
//        for(int j=1;j<=c[i];j++)
//            a[i][b[i][j]] = 1;
//}

//void trecere_matrice_incidenta_in_matrice_adiacenta(int d[101][101],int a[101][101],int n,int nr_muchii)
//{
//    for(int i=1;i<=n;i++)
//        for(int j=1;j<=nr_muchii;j++)
//            for(int z=1;z<=n;z++)
//                if(d[i][j]==1 && d[z][j]==1 && z!=i)
//                a[i][z]=1;
//}

    //trecere_lista_adiacenta_in_matrice_adiacenta(b,a,nr_vecini,n);
    //afisare(a,n,n);     //afisare matrice de adiacenta
    //cout<<endl;

    //trecere_matrice_incidenta_in_matrice_adiacenta(d,a,n,nr_muchii);
    //afisare(a,n,n);      //afisare matrice de adiacenta
    //cout<<endl;

    //afisare();      //afisare matrice de incidenta
    //cout<<endl;

    //trecere_matrice_incidenta_in_lista_adiacenta();
    //afisare();    //afisare lista de adiacenta
    //cout<<endl;

    //trecere_lista_adiacenta_in_matrice_incidenta();
    //afisare();     //afisare matrice de incidenta
