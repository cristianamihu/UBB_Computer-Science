from Repo.Repository import adaugare_lista
from Validari.Validare import valideaza_pachet
from domain.Pachete import creaza_pachet, afisare_pachet


def adaugare_pachet_servicii(lista, data_inceput_zi, data_inceput_luna, data_inceput_an, data_sfarsit_zi, data_sfarsit_luna, data_sfarsit_an, destinatie, pret):
    """

    :param lista: lista de pachete
    :param data_inceput_zi: ziua datii de inceput
    :param data_inceput_luna: luna datii de inceput
    :param data_inceput_an: anul datii de inceput
    :param data_sfarsit_zi: ziua datii de sfarsit
    :param data_sfarsit_luna: luna datii de sfarsit
    :param data_sfarsit_an: anul datii de sfarsit
    :param destinatie: destinatia
    :param pret: pretul
    :return: Lista de pachete creata
    """

    pachet = creaza_pachet(data_inceput_zi, data_inceput_luna, data_inceput_an, data_sfarsit_zi, data_sfarsit_luna, data_sfarsit_an, destinatie, pret)
    valideaza_pachet(pachet)
    adaugare_lista(lista, pachet)
    return lista

def afisare_pachete_servicii(lista):
    for i in range(0,len(lista)):
        afisare_pachet(lista[i])
    return lista

def modifica_pachet_servicii(lista, i, data_inceput_zi_noua, data_inceput_luna_noua, data_inceput_an_noua, data_sfarsit_zi_noua, data_sfarsit_luna_noua, data_sfarsit_an_noua, destinatie_noua, pret_nou):

    pachet_nou=creaza_pachet(data_inceput_zi_noua, data_inceput_luna_noua, data_inceput_an_noua, data_sfarsit_zi_noua, data_sfarsit_luna_noua, data_sfarsit_an_noua, destinatie_noua, pret_nou)
    lista[i] = pachet_nou
    return lista

def sterge_pachet_destinatie_servicii(lista, destinatie_dorita):
    for i in range(0, len(lista)):
        if lista[i]['destinatie'] == destinatie_dorita:
            del(lista[i])
    return lista

def numarzile_intre_doua_date(zi1, luna1, an1, zi2, luna2, an2):
    an = an2 - an1
    luna = luna2 - luna1
    zile = zi2 - zi1
    rez = 0
    if an == 0:
        rez = 30 * luna + zile
    else:
        rez = an * 365 - 30 * luna - zile
    return rez

def sterge_pachet_durata_scurta_servicii(lista, nr_zile_dorit):
    for i in range(0, len(lista)):
        if numarzile_intre_doua_date(lista[i]['data_inceput_zi'], lista[i]['data_inceput_luna'], lista[i]['data_inceput_an'], lista[i]['data_sfarsit_zi'], lista[i]['data_sfarsit_luna'], lista[i]['data_sfarsit_an']) < nr_zile_dorit:
            del(lista[i])
    return lista

def sterge_pachet_pret_servicii(lista, pret_dorit):
    i = len(lista) - 1
    while (i >= 0):
        if lista[i]["pret"]>pret_dorit:
            del (lista[i])
        i = i - 1
    return lista

def tiparire_destinatie_data_pret_mic_servicii(lista, destinatie_data, pret_dat):
    lista_noua=[]
    for i in range(0, len(lista)):
        if lista[i]['destinatie'] == destinatie_data:
            if lista[i]['pret'] < pret_dat:
                lista_noua.append(lista[i])
    return lista_noua
