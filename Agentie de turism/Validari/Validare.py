from domain.Pachete import preia_datainceput_zi, preia_datainceput_luna, preia_datainceput_an, preia_datasfarsit_zi, \
    preia_datasfarsit_luna, preia_datasfarsit_an, preia_pret, preia_destinatie

def valideaza_pachet(pachet):
    erori = ""
    if isinstance(preia_datainceput_zi(pachet), str) == True:
        erori += "data inceput zi invalida\n"
    if isinstance(preia_datainceput_zi(pachet), float) == True:
        erori += "data inceput zi invalida\n"
    if isinstance(preia_datainceput_luna(pachet), str) == True:
        erori += "data inceput luna invalida\n"
    if isinstance(preia_datainceput_luna(pachet), float) == True:
        erori += "data inceput luna invalida\n"
    if isinstance(preia_datainceput_an(pachet), str) == True:
        erori += "data inceput an invalida\n"
    if isinstance(preia_datainceput_an(pachet), float) == True:
        erori += "data inceput an invalida\n"
    if isinstance(preia_datasfarsit_zi(pachet), str) == True:
        erori += "data sfarsit zi invalida\n"
    if isinstance(preia_datasfarsit_zi(pachet), float) == True:
        erori += "data sfarsit zi invalida\n"
    if isinstance(preia_datasfarsit_luna(pachet), str) == True:
        erori += "data sfarsit luna invalida\n"
    if isinstance(preia_datasfarsit_luna(pachet), float) == True:
        erori += "data sfarsit luna invalida\n"
    if isinstance(preia_datasfarsit_an(pachet), str) == True:
        erori += "data sfarsit an invalida\n"
    if isinstance(preia_datasfarsit_an(pachet), float) == True:
        erori += "data sfarsit an invalida\n"
    if isinstance(preia_pret(pachet), str) == True:
        erori += "pret invalid\n"

    if preia_destinatie(pachet) == "":
        erori += "destiantie invalida\n"
    if preia_datainceput_luna(pachet) <= 0:
        erori += "Luna datii de inceput invalida!\n"
    if preia_datainceput_luna(pachet) > 12:
        erori += "Luna datii de inceput invalida!\n"
    if preia_datasfarsit_an(pachet) <= 0:
        erori += "Anul datii de sfarsit invalid!\n"

    if len(erori) > 0:
        raise ValueError(erori)
