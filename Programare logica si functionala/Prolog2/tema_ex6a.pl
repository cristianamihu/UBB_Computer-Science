%Intr-o lista L sa se inlocuiasca toate aparitiile unui element E cu elementele unei alte liste, L1.
%De ex:inloc([1,2,1,3,1,4],1,[10,11],X)va produce X=[10,11,2,10,11,3,10,11,4].

%                             { [], daca l1...ln = [] }
% inlocuire(l1...ln, e, L1) = { concatenare( L1, inlocuire(l2...ln, e, L1)) , daca l1 = e }
%                             { inlocuire(l2...ln, e, L1), daca l1 != e }

%Predicat: inlocuire(L:lista, E:integer, L1:lista, R:lista)
%L:- lista initiala din care inlocuim toate aparitiile elementului E
%E:- valoarea elementului care trebuie inlocuit
%L1:- lista cu care vom inlocui valoarea lui E
%R:- lista rezultat formata din lista initiala cu elementele egale cu E inlocuite cu lista L1

%Modele de flux: (i, i, i, o), (i, i, i, i)

%teste: ([1,2,1,3,1,4],1,[10,11]), ([],2,[6,5,6]), ([6,8,3,8],8,[1,1])

inlocuire([],_,_,[]):-!.
inlocuire([E|T],E,L,R):-!,
    inlocuire(T,E,L,R1),
    concatenare(L,R1,R).

inlocuire([H|T],E,L,[H|R]):-
    H \= E,
    inlocuire(T,E,L,R).

%concatenare(l1...ln,i1...im) = { i1...im, daca l1...ln = [] }
%                               { l1 + concatenare(l2...ln, i1...im), altfel }

%Predicat auxiliar: concatenare(L:lista, L1:lista, R:lista)
%L:- lista pe care o concatenam cu lista L1
%L1:- lista pe care o concatenam cu lista L
%R:- lista rezultat formata din lista L concatenata cu lista L1

%Modele de flux: (i, i, o), (i, i, i)

concatenare([],L1,L1):-!.
concatenare([H|T],L1,[H|R]):-concatenare(T,L1,R).








