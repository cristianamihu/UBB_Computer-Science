from Business.Servicii import adaugare_pachet_servicii

def ruleaza_teste_pachet_service():
    data_inceput_zi_gresita = -1
    data_inceput_luna_gresita = 13
    data_inceput_an_gresita = -51
    data_sfarsit_zi_gresita = -17
    data_sfarsit_luna_gresita = -2
    data_sfarsit_an_gresita = -41
    destinatie_gresita = ""
    pret_gresit = 0.0
    try:
        adaugare_pachet_servicii(data_inceput_zi_gresita, data_inceput_luna_gresita, data_inceput_an_gresita, data_sfarsit_zi_gresita, data_sfarsit_luna_gresita, data_sfarsit_an_gresita, destinatie_gresita, pret_gresit)
        assert False
    except ValueError as ve:
        assert (str(ve) == "Ziua datii de inceput invalida!\nLuna datii de inceput invalida!\nAnul datii de inceput invalid!\nZiua datii de sfarsit invalida!\nLuna datii de sfarsit invalida!\nAnul datii de sfarsit invalid!\nDestinatie invalida!\nPret invalid!")
