from domeniu.Emisiune import Emisiune
from infrastructura.file_repo_emisiuni import FileRepoEmisiuni


class Teste:
    def ruleaza_toate_testele(self):
        return self.__ruleaza_toate_testele()

    def __goleste_fisier(self, calea_catre_fisier):
        with open(calea_catre_fisier, "w") as f:
            pass

    def __ruleaza_toate_testele(self):
        calea_catre_teste_file = "teste/teste_emisiuni.txt"
        self.__goleste_fisier(calea_catre_teste_file)
        repo = FileRepoEmisiuni(calea_catre_teste_file)
        assert repo.get_size() == 0
        emisiune = Emisiune("Salvator", "comedie", 2, "descriere")
        repo.adauga_emisiune(emisiune)
        assert repo.get_size() == 1
