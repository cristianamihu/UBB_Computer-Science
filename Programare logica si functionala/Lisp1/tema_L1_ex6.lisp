;6.
;a)
; Sa se scrie de doua ori elementul de pe pozitia a n-a a unei liste liniare. De exemplu, pentru (10 20 30 40 50) si n=3 se va produce (10 20 30 30 40 50).

; 		       { nil, daca l = [] }
;dublare(l1...ln, n) = { l1 (+) l1...ln, daca n = 1 }
;		       { l1 (+) dublare(l2...ln, n-1), altfel }

;dublare(l:lista, n:atom numeric, poz:atom numeric)
; l:- lista unde cautam pozitia a n-a pentru a dubla elementul
; n:- pozitia elementului din lista l pe care dorim sa il dublam
 

(defun dublare (l n)
    (cond
        ((null l) nil)
        ((= n 1) (cons (car l) l))
        (T (cons (car l) (dublare (cdr l) (- n 1))))
    )
)


(print "a)")
(print (dublare '() 2))
(print (dublare '(9 10 100) 1))
(print (dublare '(10 20 30 40 50) 3))
(print (dublare '(7 9) 4))




;b)
; Sa se scrie o functie care realizeaza o lista de asociere cu cele doua liste pe care le primeste. De ex: (A B C) (X Y Z) --> ((A.X) (B.Y) (C.Z)).

;			      { nil, daca l = [] }
;asociere(l1...ln, L1...LN) = { nil, daca L = [] }
;			      { cons(l1 L1) (+) asociere(l2...ln, L2...Ln), altfel }

;asociere(l1:lista, l2:lista)
; l1:- prima lista din cadrul asocierii
; l2:- a doua lista din cadrul asocierii


(defun asociere (l1 l2)
    (cond
        ((null l1) nil)
	((null l2) nil)
        (t (append (list(cons (car l1) (car l2)))
		   (asociere (cdr l1) (cdr l2))))
    )
)


(print "b)")
(print (asociere '() '()))
(print (asociere '() '(A B)))
(print (asociere '(A B) '()))
(print (asociere '(A B C D) '(X Y Z T)))




;c)
; Sa se determine numarul tuturor sublistelor unei liste date, pe orice nivel. Prin sublista se intelege fie lista insasi, fie un element de pe orice nivel, care este lista. Exemplu: (1 2 (3 (4 5) (6 7)) 8 (9 10)) => 5 (lista insasi, (3 ...), (4 5), (6 7), (9 10)).

;			    { 1, daca l = [] }
;numara_subliste(l1...ln) = { numara_subliste(l1) + numara_subliste(l2...ln), daca l1 este lista }
;			    { numara_subliste(l2...ln), altfel }

;numar_subliste(l:lista)
; l:- lista in care cautam subliste si le numaram


(defun numara_subliste(l)
  (cond
    ((null l) 1)
    ((listp (car l)) (+ (numara_subliste (car l)) (numara_subliste (cdr l))))
    (t (numara_subliste (cdr l)))
  )
)


(print "c)")
(print (numara_subliste '()))
(print (numara_subliste '(1 2)))
(print (numara_subliste '((9 (4 10) k 1 (2 3)) 8)))
(print (numara_subliste '(1 2 (3 (4 5) (6 7)) 8 (9 10))))




;d)
; Sa se construiasca o functie care intoarce numarul atomilor dintr-o lista, de la nivel superficial.

;			  { 0, daca l = [] }
;numara_atomi (l1...ln) = { 1 + numara_atomi(l2...ln), daca l1 este atom }
;			  { numara_atomi(l2...ln), altfel }

;numara_atomi(l:lista)
; l:- lista in care cautam atomi si ii numaram


(defun numara_atomi (l)
    (cond
        ((null l) 0)
        ((atom (car l)) (+ 1 (numara_atomi (cdr l))))
        (T (numara_atomi (cdr l)))
    )
)


(print "d)")
(print (numara_atomi '()))
(print (numara_atomi '((2) a 3)))
(print (numara_atomi '(1 2 (a b) s 5 (6) fg 5)))