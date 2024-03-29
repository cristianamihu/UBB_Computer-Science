%Dandu-se o valoare N, se cere sa se genereze permutarile de N elemente cu proprietatea ca oricare ar fi 2<=i<=n exista un 1<=j<=i astfel incat |v(i)-v(j)|=1.
%In orice permutare, valorile vecine sa aiba diferenta absoluta de 1.

%teste: [3, 2, 4, 1] => 3, 2 - nu respecta, [2, 3, 1, 4] -

%Genereaza o lista de numere de la 1 la n
%		  { [], daca n = 0 }
% createList(n) = { n + createList(n - 1), daca n > 0 }

% createList(N:integer, R:lista)
%N:- numarul pana la care se adauga numere in lista
%R:- lista rezultata cu numerele de la 1 la N

%Modele de flux: (i, o), (i, i)

createList(0, []).
createList(N, [N|R]) :-
    N > 0,
    N1 is N - 1,
    createList(N1, R).





%Insereaza in toate modurile posibile elemntul e in lista
%			 { [e], daca n = 0 }
% inserare(l1...ln, e) = { l1...ln + e, daca n >= 1 }
%			 { l1 + inserare(l2...ln, e), altfel }

% inserare(L:lista, E:integer, R:lista)
%L:- lista in care se insereaza elementul E
%E:- elemnetul pe care il inseram in lista
%R:- lista rezultata in urma adaugarii elementului E

%Modele de flux: (i, i, o), (i, i, i)

inserare([], E, [E]).
inserare([H|T], E, [E,H|T]).
%E este adăugat între primul element H și restul listei T, între primul și al doilea element dintr-o listă pentru a genera toate permutările posibile
inserare([H|T], E, [H|R]) :-
         inserare(T, E, R).
% E este adăugat la începutul listei, și restul listei T este păstrat neschimbat.



%Genereaza permutarile unei liste
%		       { [], daca l1...ln = [] }
% permutari(l1...ln) = { inserare(permutari(l2...ln), l1), altfel } %se generează permutările restului listei, iar fiecare permutare este inserată în toate modurile posibile în listă.

% permutari(L:lista, R:lista)
%L:- lista din care se genereaza toate permutarile posibile
%R:- permutarile posibile

%Modele de flux: (i, o), (i, i)

permutari([], []).
permutari([H|T], R) :-
    permutari(T, R1), % Generăm toate permutările posibile pentru restul listei T.
    inserare(R1, H, R). % Adăugăm elementul H în toate modurile posibile în permutările obținute anterior.



%Calculeaza diferenta absoluta dintre doua numere
%	       { a - b, daca a > b }
% diff(a, b) = { b - a, daca a < b }

% diff(A:integer, B:integer, R:integer)
%A:- un numar din diferenta
%B:- un numar din diferenta
%R:- rezultatul dieferentei celor doua numere

%Modele de flux: (i, i, o), (i, i, i)

diff(A, B, R) :-
    A > B,
    R is A - B.
diff(A, B, R) :-
    A =< B,
    R is B - A.



% Verifica daca ultimul element din lista de permutari e compatibil cu proprietatea. Aceasta se bazează pe diferența absolută între H și ultimul element adăugat în listă, reprezentat de primul argument al lui checkPerm. Verfică dacă o listă respectă proprietatea că oricare două elemente consecutive au diferența absolută de 1
%		      { true, daca l1...ln = [] }
%		      { true, daca diff(l1, e) = 1 }
% check(l1...ln, e) = { check(l2...ln, e), daca n > 0 }
%		      { false, altfel }

% check(L:lista, E:integer)
%L:- lista in care verificam
%E:- elementul caruia i se verifica compatibilitatea

%Modele de flux: (i, i)

check([], _). %pentru o listă goală, proprietatea este întotdeauna îndeplinită.
check([H|_], X) :-
    diff(X, H, R),
    R =:= 1, !.
check([_|T], X) :-
    check(T, X).





%Parcurge lista de la început la sfârșit, adăugând un element la fiecare pas și verificând dacă condiția specificată este respectată pentru permutarea curentă
%			       { true, daca l1...ln = [] }
%checkPerm(l1...ln, L1...Ln) = { check(checkPerm(l1...ln, L1...Ln), l1), daca n > 0 }

% checkPerm(L:lista, R:lista)
%L:- permutarea pe care o verificam
%R:- lista ce reprezinta secventa de elemente adaugate in timpul procesului de verificare a permutarii

%Modele de flux: (i, i)

checkPerm([], _). %pentru o permutare goală, proprietatea este întotdeauna îndeplinită
checkPerm([H|T], R) :-
    check(R, H), %verifica dacă elementul H (ultimul element adaugat in lista) ar fi compatibil cu proprietatea
    checkPerm(T, [H|R]). %Apelăm recursiv funcția checkPerm pentru a verifica restul listei T, adăugând elementul H la începutul listei L




%Verifica toate permutările posibile ale listei și apoi verifica proprietatea pentru fiecare permutare.

%onesolution(l1...ln) = { checkPerm(permutari(l1...ln))}

% onesolution(L:lista, R:lista)
%L:- lista pentru care se verifica permutarile
%R:- o permutare care verifica proprietatea

%Modele de flux: (i, o), (i, i)

onesolution(L, R) :-
    permutari(L, R),
    checkPerm(R, []).



%Generează toate permutările de N elemente cu proprietatea că oricare două elemente consecutive au diferența absolută de 1

%allsolutions(n) = { U onesolution(createList(n))}

% allsolutions(N:integer, R:lista)
%N:- numarul pana la care se adauga elemente in lista la care vrem sa aflam permutarile
%R:- toate permutarile care verifica proprietatea

%Modele de flux: (i, o), (i, i)

allsolutions(N, R) :-
    createList(N, RL),
    findall(RP, onesolution(RL, RP), R).
