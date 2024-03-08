bits 32 

global start        

extern exit, print_hexa, print_binar              
import exit msvcrt.dll   

; ex. 4.Se da un sir de numere. Sa se afiseze valorile in baza 16 si in baza 2.
segment data use32 class=data public 

    sir db 1,2
    len equ $-sir

segment code use32 class=code public 
    start:
        push dword sir
        push dword len
        call print_hexa
        push dword sir
        push dword len
        call print_binar
        push    dword 0      
        call    [exit]        
