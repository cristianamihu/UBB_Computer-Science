bits 32 

global start        

extern exit, printf, scanf      ; adaugam printf si scanf ca functii externe
import exit msvcrt.dll
import printf msvcrt.dll        ; indicam asamblorului ca functia printf se gaseste in libraria msvcrt.dll
import scanf msvcrt.dll    
  
; ex. 10. Sa se citeasca de la tastatura un numar in baza 10 si sa se afiseze valoarea acelui numar in baza 16.

; Exemplu: Se citeste: 28, se afiseaza: 1C     
          
segment data use32 class=data
    
    n dd 0                       ; definim variabila n, unde se va stoca valoarea citita de la tastatura
	format1 db "%d",0            ; definim formatul
	format2 db "%x",0
    mesaj db "n=",0              ; definim mesajul

segment code use32 class=code
    start:
        ; printf(mesaj) => se va afisa "n="
		push dword mesaj 
		call [printf]           ; apelam functia printf pentru afisare
		add esp, 4*1            ; eliberam parametri de pe stiva; 4 = dimensiunea unui dword; 2 = numarul de parametri
		; scanf(format1, n), citirea unui numar in baza 10 in variabila n
        push dword n            ; punem adresa lui n pe stiva
		push dword format1
		call [scanf]            ; apelam functia scanf pentru citire
		add esp, 4*2            
		; printf(format2, n), afisarea numarului n in baza 16
		push dword [n]
		push dword format2 
		call [printf]
		add esp, 4*2
        push    dword 0      
        call    [exit]       