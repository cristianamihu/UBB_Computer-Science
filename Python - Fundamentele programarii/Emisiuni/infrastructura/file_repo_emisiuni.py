from domeniu.emisiune import Emisiune
from erori.repo_error import RepoError


class FileRepoEmisiuni:

    def __init__(self, calea_catre_fisier):
        self.__emisiuni = {}
        self.__calea_catre_fisier = calea_catre_fisier

    def __read_all_from_file(self):
        with open(self.__calea_catre_fisier, "r") as f:
            lines = f.readlines()
            self.__emisiuni.clear()
            for line in lines:
                line = line.strip()
                if line != "":
                    parti = line.split(" ")
                    nume = parti[0]
                    tip = parti[1]
                    durata = int(parti[2])
                    descriere = parti[3]
                    emisiune = Emisiune(nume, tip, durata, descriere)
                    self.__emisiuni[nume] = emisiune

    def __write_all_to_file(self):
        with open(self.__calea_catre_fisier, "w") as f:
            for emisiune in self.__emisiuni.values():
                f.write(str(emisiune)+"\n")

    def adauga_emisiune(self, emisiune):
        self.__read_all_from_file()
        nume = emisiune.get_nume()
        if nume in self.__emisiuni:
            raise RepoError("Emisiune deja existenta!")
        self.__emisiuni[nume] = emisiune
        self.__write_all_to_file()

    def modifica_emisiune(self, nume,  emisiune):
        self.__read_all_from_file()
        if nume not in self.__emisiuni:
            raise RepoError("Emisiune inexistenta!")
        self.__emisiuni[nume] = emisiune
        self.__write_all_to_file()

    def sterge_emisiune(self, nume):
        self.__read_all_from_file()
        if nume not in self.__emisiuni:
            raise RepoError("Emisiune inexistenta!")
        del self.__emisiuni[nume]

    def get_all(self):
        self.__read_all_from_file()
        emisiuni = []
        for nume in self.__emisiuni:
            emisiuni.append(self.__emisiuni[nume])
        return emisiuni

    def __len__(self):
        return len(self.__emisiuni)

    def get_size(self):
        self.__read_all_from_file()
        return len(self.__emisiuni)
