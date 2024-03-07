;Sa se construiasca lista nodurilor unui arbore de tipul (2) parcurs in preordine.

;                     { [] , daca l1...ln = [] }
; preordine(l1..ln) = { [l1] , daca l2...ln = [] }
;                     { [l1] (+) preordine(l3), daca ramura stanga este vida }
;                     { [l1] (+) preordine(l2) (+) preordine(l3), altfel }

;preordine(l:lista)
; l:- lista nodurilor unui arbre de tipul (2)


(defun preordine(l)
	(cond
        	((null l) nil)
		((null (cdr l)) (list (car l)) )
		((null (cadr l)) (append (list (car l))
				 	 (preordine (caddr l))) )
		(t(append(list (car l))
		 	 (preordine (cadr l))
		 	 (preordine (caddr l)) ))
	)
)


(print (preordine '() ))
(print (preordine '(A) ))
(print (preordine '(A (B) (C (D)(E)) ) ))
(print (preordine '(A (B (D (F (K)) (G)) (E)) (C () (H (I () (Y)))) )  ))