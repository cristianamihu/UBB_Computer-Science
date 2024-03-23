class ValidatorEmisiune:

    def __init__(self):
        pass

    def valideaza(self, emisiune):
        erori = ""
        if emisiune.get_nume() == "":
            erori += "Nume invalid!\n"
        if emisiune.get_tip() == "":
            erori += "Tip invalid!\n"
        if emisiune.get_durata() <= 0:
            erori += "Durata invalida!\n"
        if emisiune.get_descriere() =="":
            erori+= "Descriere invalida!\n"
        if len(erori) > 0:
            raise ValidError(erori)