%Sa se construiasca sublista (lm, ..., ln) a listei (l1, ..., lk).

%                                       {[], daca l1 ...lk = []}
% construieste_sublista(l1...lk, M, N)= {pastreaza(N-1, elimina(M-1, l1 ... lk)), daca M>0, N>=M, N<=lenght(l1 ...lk, Len)}

% Predicat: construieste_sublista(L:lista, M:integer, N:integer, R:lista)
% L:- lista din care extragem sublista dorita, unde L = [l1, l2, ..., lk]
% M:- indexul de la care incepe sublista
% N:- indexul la care se termina sublista
% R:- sublista rezultata, unde R = [lm, lm+1, ..., ln]

%Modele de flux: (i, i, i, o) , (i, i, i, i) 

construieste_sublista([], _, _, []).
construieste_sublista(L, M, N, R) :-
    length(L, Len),
    M > 0,
    N >= M,
    N =< Len,
    M1 is M - 1,
    N1 is N - 1,
    elimina(M1, L, T),
    pastreaza(N1, T, R).

%elimina(M, L)={l1 ...lk, daca M=0}
%                       {elimna(l2 ... lk), daca M>0}

% Predicat auxiliar: elimina(M:integer, L:lista, R:lista)
% Elimina primele M-1 elemente din lista L

elimina(0, L, L).
elimina(M, [_|T], R) :-
    M > 0,
    M1 is M - 1,
    elimina(M1, T, R).

%pastreaza(N, l1 ...lk)={[], daca N=0}
%                       {l1 + pastreaza(N-1, l2 ... lk), daca N>0}

% Predicat auxiliar: pastreaza(N:integer, L:lista, R:lista)
% Pastreaza urmatoarele N-M+1 elemente din lista L

pastreaza(0, _, []).
pastreaza(N, [H|T], [H|R]) :-
    N > 0,
    N1 is N - 1,
    pastreaza(N1, T, R).