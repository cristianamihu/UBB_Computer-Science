class UI:

    def __init__(self, service_emisiuni):
        self.__service_emisiuni = service_emisiuni
        self.__comenzi = {
            "1": self.__ui_adauga_emisiune,
            "2": self.__ui_modifica_emisiune,
            "3": self.__ui_sterge_emisiune
        }

    def __ui_adauga_emisiune(self):
        if len(self.__parametri) != 4:
            print("Numar parametri invalid!")
            return
        nume = self.__parametri[0]
        tip = self.__parametri[1]
        durata = int(self.__parametri[2])
        descriere = self.__parametri[3]
        self.__service_emisiuni.adauga_emisiune(nume, tip, durata, descriere)
        print("SEmisiune adaugata cu succes!")

    def __ui_afisare_emisiuni(self):
        if len(self.__parametri) != 0:
            print("Numar parametri invalid!")
            return
        emisiuni = self.__service_emisiuni.get_all_emisiuni()
        if len(emisiuni) == 0:
            print("Nu exista emisiuni in aplicatie!")
            return
        for emisiune in emisiuni:
            print(emisiune)

    def __ui_modifica_emisiune(self):
        if len(self.__parametri) != 2:
            print("Numar parametri invalid!")
            return
        nume = self.__parametri[0]
        tip_nou = self.__parametri[1]
        durata_noua = self.__parametri[2]
        descriere_noua = self.__parametri[3]
        self.__service_emisiuni.modifica_emisiune(nume, tip_nou, durata_noua, descriere_noua)
        print(f"Emisiunea cu numele {nume} a fost modificata cu succes!")

    def __ui_sterge_emisiune(self):
        if len(self.__parametri) != 1:
            print("Numar parametri invalid!")
            return
        nume = self.__parametri[0]
        self.__service_emisiuni.sterge_emisiune(nume)
        print(f"SEmisiunea cu numele {nume} a fost stearsa cu succes!")

    def run(self):
        while True:
            comanda = input(">>>")
            comanda = comanda.strip()
            if comanda == "":
                continue
            parti = comanda.split()
            nume_comanda = parti[0]
            self.__parametri = parti[1:]
            if nume_comanda in self.__comenzi:
                self.__comenzi[nume_comanda]()
            else:
                print("Comanda invalida!")
