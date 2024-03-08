from Business.Servicii import adaugare_pachet_servicii, afisare_pachete_servicii, sterge_pachet_destinatie_servicii, sterge_pachet_durata_scurta_servicii, sterge_pachet_pret_servicii, \
        modifica_pachet_servicii, tiparire_destinatie_data_pret_mic_servicii
from domain.Pachete import afisare_pachet


lista =  []

def adaugare_pachet(lista):
    try:
        data_inceput_zi = int(input("Introduceti ziua datii de inceput:"))
    except:
        print("Ziua datii de inceput invalida")
        data_inceput_zi = int(input("Introduceti ziua datii de inceput:"))

    try:
        data_inceput_luna = int(input("Introduceti luna datii de inceput:"))
    except:
        print("Luna datii de inceput invalida")
        data_inceput_luna = int(input("Introduceti luna datii de inceput:"))

    try:
        data_inceput_an = int(input("Introduceti anul datii de inceput:"))
    except:
        print("Anul datii de inceput invalid")
        data_inceput_an = int(input("Introduceti anul datii de inceput:"))
    try:
        data_sfarsit_zi = int(input("Introduceti ziua datii de sfarsit:"))
    except:
        print("Ziua datii de sfarsit invalida")
        data_sfarsit_zi = int(input("Introduceti ziua datii de sfarsit:"))

    try:
        data_sfarsit_luna = int(input("Introduceti luna datii de sfarsit:"))
    except:
        print("Luna datii de sfarsit invalida")
        data_sfarsit_luna = int(input("Introduceti luna datii de sfarsit:"))

    try:
        data_sfarsit_an = int(input("Introduceti anul datii de sfarsit:"))
    except:
        print("Anul datii de sfarsit invalid")
        data_sfarsit_an = int(input("Introduceti anul datii de sfarsit:"))

    try:
        destinatie = str(input("Introduceti destinatia:"))
    except:
        print("Destinatie invalida")
        destinatie = str(input("Introduceti destinatia:"))

    try:
        pret = float(input("Introduceti pretul:"))
    except:
        print("Pret invalid")
        pret = float(input("Introduceti pretul:"))

    adaugare_pachet_servicii(lista, data_inceput_zi, data_inceput_luna, data_inceput_an, data_sfarsit_zi, data_sfarsit_luna, data_sfarsit_an, destinatie, pret)



def afisare_pachete(lista):
    if len(lista) < 1:
        print("Nu exista pachete inca")
    else:
        afisare_pachete_servicii(lista)

def stergere_destinatie(lista):
    if len(lista) < 1:
        print("Nu exista pachete inca")
    else:
        destinatie = str(input("Alegeti destinatia dorita:"))
        sterge_pachet_destinatie_servicii(lista, destinatie)
        afisare_pachete_servicii(lista)

def sterge_durata_zile(lista):
    if len(lista) < 1:
        print("Nu exista pachete inca")
    else:
        zi = int(input("Introduceti numarul de zile dorit:"))
        sterge_pachet_durata_scurta_servicii(lista, zi)
        afisare_pachete_servicii(lista)

def sterge_pret(lista):
    if len(lista) < 1:
        print("Nu exista pachete inca")
    else:
        pret = float(input("Introduceti pretul dorit:"))
        sterge_pachet_pret_servicii(lista, pret)
        afisare_pachete_servicii(lista)

def modifica_pachet(lista):
    if len(lista) < 1:
        print("Nu exista pachete inca")
    else:
        data_inceput_zi_noua = int(input("Ziua de inceput noua:"))
        data_inceput_luna_noua = int(input("Luna de inceput noua:"))
        data_inceput_an_noua = int(input("An de inceput nou:"))
        data_sfarsit_zi_noua = int(input("Ziua de sfarsit noua:"))
        data_sfarsit_luna_noua = int(input("Luna de sfarsit noua:"))
        data_sfarsit_an_noua = int(input("An de sfarsit nou:"))
        destinatie_noua = str(input("Destinatia noua"))
        pret_nou = float(input("Pret nou"))
        g = int(input("Pozitia pachetului pe care doriti sa il modificati:"))
        modifica_pachet_servicii(lista, g, data_inceput_zi_noua, data_inceput_luna_noua, data_inceput_an_noua, data_sfarsit_zi_noua, data_sfarsit_luna_noua, data_sfarsit_an_noua, destinatie_noua, pret_nou)
        afisare_pachete_servicii(lista)

def tipareste_pachete_dest_data_suma_mica(lista):
    if len(lista) < 1:
        print("Nu exista pachete inca")
    else:
        dest = str(input("Introduceti destinatia dorita:"))
        pret = float(input("Introduceti pretul dorit:"))
    lista_noua = tiparire_destinatie_data_pret_mic_servicii(lista, dest, pret)
    for i in range(0, len(lista_noua)):
        afisare_pachet(lista_noua[i])
def print_menu():

    """
       Printeaza meniul principal de accesare al cerintelor aplicatiei.
    """
        print("Meniu:")
    print("   1. adaugare pachet de calatorie")
    print("   2. afisarea tuturor pachetelor de calatorie")
    print("   3. modifica pachet de calatorie")
    print("   4. stergerea tuturor pachetelor de calatorie disponibile pentru o destinatie data")
    print("   5. stergerea tuturor pachetelor de calatorie care au o durata mai scurta decat un numar de zile dat")
    print("   6. stergerea tuturor pachetelor de calatorie care au pretul mai mare decat o suma data")
    print("   7. tiparirea pachetelor de calatorie cu o destinatie data si cu pret mai mic decat o suma data")
    print("   8. exit")

def run_ui():
    """
       Implementeaza interfata de meniu stabilita.
    """
    finish = False
    while not finish:
        print_menu()
        opt = input("Introduceti optiunea dorita:").strip()
        if opt == '1':
            adaugare_pachet(lista)
        elif opt == '2':
            afisare_pachete(lista)
        elif opt == '3':
            modifica_pachet(lista)
        elif opt == '4':
            stergere_destinatie(lista)
        elif opt == '5':
            sterge_durata_zile(lista)
        elif opt == '6':
            sterge_pret(lista)
        elif opt == '7':
            tipareste_pachete_dest_data_suma_mica(lista)
        elif opt == '8':
            finish
            exit()
