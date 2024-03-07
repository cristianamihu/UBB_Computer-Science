;7.Sa se scrie o functie care calculeaza suma numerelor pare minus suma numerelor impare la toate nivelurile unei liste.

;   	   {l, daca l e numar si l % 2 = 0}
;	   {-l, daca l e numar si l % 2 = 1}
;suma(l) = {suma de la i=1,n din suma(li),daca l e lista = (l1...ln)}
;	   {0, altfel}
 
;par_impar_suma(l:lista)
;l:- lista initiala din care calculam suma dorita


(defun suma(l)
    (cond 
        ((and (numberp l) (eq 0 (mod l 2))) l)
        ((and (numberp l) (eq 1 (mod l 2))) (* l -1))
        ((listp l) (apply #'+(mapcar #'suma l)))
        (t 0)
    )
)

(print (suma '(2 4 6 A (1 3 11 B (C)))))

