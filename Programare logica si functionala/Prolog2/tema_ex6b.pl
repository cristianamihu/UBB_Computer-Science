%Se da o lista eterogena, formata din numere intregi si liste de numere intregi. In fiecare sublista sa se inlocuiasca toate
%aparitiile primului element din sublista cu o lista data.
%De ex:[1, [4, 1, 4], 3, 6, [7, 10, 1, 3, 9], 5, [1, 1, 1], 7] si [11, 11] =>
% [1, [11, 11, 1, 11, 11], 3, 6, [11, 11, 10, 1, 3, 9], 5, [11, 11, 11, 11, 11, 11], 7]

%                                          { [], daca l1...ln = [] }
% inlocuire_lista_eterogena(l1...ln, L1) = { inlocuire_sublista(l1, , L1) (+) inlocuire_lista_eterogena(l2...ln, L1), daca l1 e lista }
%                                          { inlocuire_lista_eterogena(l2...ln, L1), daca l1 nu e lista

% Predicat: inlocuire_lista eterogena(L:lista eterogena, L1:lista, R:lista)
%L:- lista initiala eterogena in care facem inlocuirea
%L1:- lista cu care inlocuim valoarea primului element din subliste
%R:- lista rezultat formata din lista eterogena initiala cu elementele din subliste egale cu primul element din sublista inlocuite cu lista L1

%Model de flux: (i, i, o), (i, i, i)

%teste: ([1,[4,1,4],3,6,[7,10,1,3,9],5,[1,1,1],7],[11,11]), ([],[2,3,4])

inlocuire_lista_eterogena([], _, []).
inlocuire_lista_eterogena([H|T], L1, [R|T1]):-
    is_list(H),
    H=[H1|_],
    inlocuire_subliste(H, H1, L1, R),
    inlocuire_lista_eterogena(T, L1, T1).

inlocuire_lista_eterogena([H|T], L1, [H|T1]):-
    \+ is_list(H),
    inlocuire_lista_eterogena(T, L1, T1).

%                                    { [], daca l1...ln = [] }
% inlocuire_subliste(l1...ln, e, L1)={ inlocuire_subliste(l2...ln, e, L1), daca l1 = e }
%                                    { inlocuire(l2...ln, e, L1), daca l1 != e }


%Predicat auxiliar: inlocuire_subliste(L:lista, E:integer, L1:lista, R:lista)
%L:- sublista initiala in care facem inlocuirea
%E:- primul element din lista retinut pentru a-i inlocui toate aparitiile din sublista cu lista L1
%L1:- lista cu care inlocuim valoarea elementului E
%R:- lista rezultat formata din sublista initiala cu elementele egale cu E inlocuite cu lista L1

%Modele de flux: (i, o, i), (i, i, i)

inlocuire_subliste([], _, _, []).
inlocuire_subliste([E|T], E, L1, R):-
    inlocuire_subliste(T, E, L1, R1),
    concatenare(L1, R1, R).

inlocuire_subliste([H|T],E,L1,[H|R]):-
    H \= E,
    inlocuire_subliste(T,E,L1,R).


%concatenare(l1...ln,i1...im) = { i1...im, daca l1...ln = [] }
%                               { l1 + concatenare(l2...ln, i1...im), altfel }

%Predicat auxiliar: concatenare(L:lista, L1:lista, R:lista)
%L:- lista pe care o concatenam cu lista L1
%L1:- lista pe care o concatenam cu lista L
%R:- lista rezultat formata din lista L concatenata cu lista L1

%Modele de flux: (i, i, o), (i, i, i)

concatenare([],L1,L1):-!.
concatenare([H|T],L1,[H|R]):-concatenare(T,L1,R).











