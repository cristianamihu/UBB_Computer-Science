def menu():
    print("""Meniu:
        1.Citirea unei liste de numere intregi.
        2.Gasirea secventei de lungime maxima care are suma maxima.(proprietatea 11)
        3.Gasirea secventei de lungime maxima care are oricare doua elemente consecutive de semne contrare.(proprietatea 12)
        4.Gasirea secventei de lungime maxima care are p=1 sau in oricare trei elemente consecutive exista o valoare care se repeta.(proprietatea 9)
        5.Iesire din aplicatie.""")

lista = []

def run():
    #Citire
    menu_check = False
    while True:
        if menu_check == False:
            menu()
            menu_check = True
        nr = int(input("Alege optiunea:"))
        if nr == 1:
            proprietatea1()
        elif nr == 2:
            proprietatea2(lista)
        elif nr == 3:
            proprietatea3(lista)
        elif nr == 4:
            proprietatea4(lista)
        elif nr == 5:
            print("Program inchis!")
            break


def proprietatea1():
    v = []
    x = int(input("Numarul de numere intregi:"))
    i = 0
    for i in range (0, x):
        element = int(input())
        v.append(element)
    global lista
    lista = v


def proprietatea2(lista1):
    if len(lista1) < 1:
        print("Introdu numerele")
    else:
        dr = 0
        s = 0
        st = 0
        si = 0
        smax = 0
        n = len(lista1)
        f = 0
        lmax = 0
        d = 0
        while lista1[f] < 0:
            f = f + 1
        st = 1
        dr = 5
        for i in range(f, n):
            if lista1[i] >= 0:
                if s + lista1[i] >= smax:
                    smax = s + lista1[i]
                else:
                    smax = si
                    lmax = lmax - d
                s = s + lista1[i]
                si = s
                d = 0
                lmax = lmax + 1
            else:
                s = s + lista1[i]
                d = d + 1
                lmax = lmax + 1
        if s + lista1[i] > smax:
            smax = s + lista[i]
        else:
            lmax = lmax - d
        print(lista[st:dr])

                
def proprietatea3(lista):
        if len(lista) < 1:
            print("Lista e invalida")
        else:
            n = len(lista)
            li = 1
            lmax = 0
            x = lista[0]
            for i in range(1, n):
                if x * lista[i] < 0:
                    li = li + 1
                    x = lista[i]
                else:
                    if li > lmax:
                        lmax = li
                        x = lista[i]
                    li = 1
            if li > lmax:
                lmax = li
            li = 1
            curentlist = [lista[0]]
            y = lista[0]
            lista_secvente = []
            for i in range(1, n):
                if y * lista[i] < 0:
                    li = li + 1
                    curentlist.append(lista[i])
                    y = lista[i]
                else:
                    if li == lmax:
                        lista_secvente.append(curentlist)
                        curentlist = [lista[i]]
                        y = lista[i]
                    li = 1
            if li == lmax:
                lista_secvente.append(curentlist)
            print(lista_secvente)
            return(lista_secvente)


def proprietatea4(lista1):
    if len(lista1) < 1:
        print("Mai intai citeste numerele.")
        return []
    maxLen = 0
    maxStIndex = 0
    index = 2
    currLen = 0
    currStIndex = 0
    while index < len(lista1):
        if lista1[index - 2] == lista1[index - 1] or lista1[index - 2] == lista1[index] or lista1[index - 1] == lista1[index]:
            currLen = currLen + 1
        else:
            if maxLen < currLen + 2:
                maxLen = currLen + 2
                maxStIndex = currStIndex
            currLen = 0
            currStIndex = index - 1
        index += 1
    if maxLen == 0:
        maxLen = 1
    if maxLen < currLen + 2 and len(lista1) > 2:
        maxLen = currLen + 2
        maxStIndex = currStIndex
    index = maxStIndex
    newList = []
    while index < maxStIndex + maxLen:
        newList.append(lista1[index])
        index += 1
    print(newList)
    return(newList)
    

def test_vid():
    assert proprietatea4([1,2,1,4,5,4])==[1,2,1]
    assert proprietatea4([7,6,5,6,1,6,4])==[6,5,6] 
       

test_vid()
run()
