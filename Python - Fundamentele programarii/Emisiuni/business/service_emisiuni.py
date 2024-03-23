from domeniu.emisiune import Emisiune


class ServiceEmisiuni:

    def __init__(self, validator_emisiune, repo_emisiuni):
        self.__validator_emisiune = validator_emisiune
        self.__repo_emisiuni = repo_emisiuni

    def adauga_student(self, nume, tip, durata, descriere):
        """

        :param id_student: id ul studentului care va fi adaugat
        :param nume: numele studentului care va fi adaugat
        :return:  studentul a fost adaugat
        """
        emisiune = Emisiune(nume, tip, durata, descriere)
        self.__validator_emisiune.valideaza(emisiune)
        self.__repo_emisiuni.adauga_emisiune(emisiune)

    def modifica_emisiune(self, nume, tip_nou, durata_noua, descriere_noua):
        emisiune_noua = Emisiune(nume, tip_nou, durata_noua, descriere_noua)
        self.__validator_emisiune.valideaza(emisiune_noua)
        self.__repo_emisiuni.modifica_emisiune(nume, emisiune_noua)

    def get_all_studenti(self):
        """

        :return: preluarea tuturor studentilor din repo
        """
        return self.__repo_emisiuni.get_all()

    def sterge_student(self, nume):
        """

        :param id_student: id-ul studentului care va fi sters
        :return:  lista cu disciplinele ramase
        """
        self.__repo_emisiuni.sterge_emisiune(nume)
