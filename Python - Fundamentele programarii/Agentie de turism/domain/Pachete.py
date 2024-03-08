def creaza_pachet(data_inceput_zi, data_inceput_luna, data_inceput_an, data_sfarsit_zi, data_sfarsit_luna, data_sfarsit_an, destinatie, pret):
    """
    :param data_inceput_zi: Acest parametru este un parametru int, care stocheaza ziua datii de inceput a calatoriei
    :param data_inceput_luna: Acest parametru este un parametru int, care stocheata luna datii de inceput
    :param data_inceput_an: Acest parametru este un parametru int, care stocheaza anul datii de inceput
    :param data_sfarsit_zi: Acest parametru este un parametru int, care stocheaza ziua datii de sfarsit
    :param data_sfarsit_luna: Acest parametru este un parametru int, care stocheata luna datii de sfarsit
    :param data_sfarsit_an: Acest parametru este un parametru int, care stocheaza anul datii de sfarsit
    :param destinatie: Acest parametru este un parametru string, care stocheaza destinatia
    :param pret: Acest parametru este un paremtru float, care stocheaza pretul
    :return: Pachetul de calatorie de tip pachet
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
