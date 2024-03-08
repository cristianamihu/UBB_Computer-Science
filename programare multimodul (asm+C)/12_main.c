#include <stdio.h>

// ex.4.Se da un sir de numere. Sa se afiseze valorile in baza 16 si in baza 2.
void print_hexa(char*);
void print_binar(char*);

int main()
{
    char sir[100] = "1, 2";
    print_hexa(sir);
    print_binar(sir);
    
    return 0;
}
    