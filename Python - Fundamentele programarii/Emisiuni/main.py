from business.service_emisiuni import ServiceEmisiuni
from infrastructura.file_repo_emisiuni import FileRepoEmisiuni
from prezentare.consola import UI
from validare.validator_emisiune import ValidatorEmisiune
from teste.teste import Teste


def main():
    calea_catre_fisier = "emisiuni.txt"
    repo_emisiuni = FileRepoEmisiuni(calea_catre_fisier)
    """for emisiune in repo_emisiuni:
        print(emisiune)"""
    validator_emisiune = ValidatorEmisiune()
    service_emisiuni = ServiceEmisiuni(validator_emisiune, repo_emisiuni)
    consola = UI(service_emisiuni)
    teste = Teste()

    teste.ruleaza_toate_testele()
    consola.run()


main()
