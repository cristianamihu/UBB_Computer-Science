% Sa se scrie un predicat care substituie intr-o lista un element prin altul.

%                           { [], daca n = 0 }
%substituire(l1..ln,e1,e2)= { l1 + substituire(l2..ln,e1,e2), daca e1 != l1}
%                           { e2 + substituire(l2..ln,e1,e2), daca e1 = l1 }

%Predicat: substituire(L:lista, E1:integer, E2:integer, R:lista)
%L:- lista din care substituim
%E1:- valoarea elementului care trebuie substituit
%E2:- valoarea cu care vom substitui valoarea lui E1
%R:- lista rezultat formata din lista initiala cu elementele egale cu E1 substituite cu elementul egal cu E2

%Modele de flux: (i, i, i, o) , (i, i, i, i)

substituire([], _, _, []).
substituire([H|T], E1, E2, R):- E1 \= H,
                                substituire(T, E1, E2, R1),
                                R = [H|R1].
substituire([H|T], E1, E2, R):- E1 = H,
                                substituire(T, E1, E2, R1),
                                R = [E2|R1].
