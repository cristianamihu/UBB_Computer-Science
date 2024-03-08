def creaza_pachet(data_inceput_zi, data_inceput_luna, data_inceput_an, data_sfarsit_zi, data_sfarsit_luna, data_sfarsit_an, destinatie, pret):
    """
    :param data_inceput_zi: ziua datii de inceput a calatoriei, parametru de tip int
    :param data_inceput_luna: luna datii de inceput, parametru de tip int
    :param data_inceput_an: anul datii de inceput, parametru de tip int
    :param data_sfarsit_zi: ziua datii de sfarsit, parametru de tip int
    :param data_sfarsit_luna: luna datii de sfarsit, parametru de tip int
    :param data_sfarsit_an: anul datii de sfarsit, parametru de tip int
    :param destinatie: destinatia, parametru de tip int
    :param pret: pretul, parametru de tip float
    :return: Pachetul de calatorie, parametru de tip pachet
    """
    return{
        "data_inceput_zi":data_inceput_zi,
        "data_inceput_luna":data_inceput_luna,
        "data_inceput_an":data_inceput_an,
        "data_sfarsit_zi":data_sfarsit_zi,
        "data_sfarsit_luna":data_sfarsit_luna,
        "data_sfarsit_an":data_sfarsit_an,
        "destinatie":destinatie,
        "pret":pret
    }

def preia_datainceput_zi(pachet):
    return pachet["data_inceput_zi"]

def preia_datasfarsit_zi(pachet):
    return pachet["data_sfarsit_zi"]

def preia_datainceput_luna(pachet):
    return pachet["data_inceput_luna"]

def preia_datasfarsit_luna(pachet):
    return pachet["data_sfarsit_luna"]

def preia_datainceput_an(pachet):
    return pachet["data_inceput_an"]

def preia_datasfarsit_an(pachet):
    return pachet["data_sfarsit_an"]

def preia_destinatie(pachet):
    return pachet["destinatie"]


def afisare_datainceput(pachet):
    print(preia_datainceput_zi(pachet), '/', preia_datainceput_luna(pachet), '/',preia_datainceput_an(pachet))

def afisare_datasfarsit(pachet):
    print(preia_datasfarsit_zi(pachet), '/', preia_datasfarsit_luna(pachet), '/',preia_datasfarsit_an(pachet))

def afisare_pachet(pachet):
    print(preia_datainceput_zi(pachet), '/', preia_datainceput_luna(pachet), '/', preia_datainceput_an(pachet), '-', preia_datasfarsit_zi(pachet), '/', preia_datasfarsit_luna(pachet), '/', preia_datasfarsit_an(pachet), '-', preia_destinatie(pachet), '-', preia_pret(pachet))

def preia_pret(pachet):
    return pachet["pret"]
