bits 32 
global start        

;Să se scrie un program în limbaj de asamblare care:

;citește de la tastatură cuvinte (cel mult 20 de caractere) până se introduce caracterul '$'; creează un fișier text cu numele "cuvinte1.txt"; scrie în fișierul creat doar cuvintele care conțin o literă MICĂ și care au un număr PAR de caractere.
;Exemplu:

;Dacă se citește de la tastatură:

;Cuvinte: abc Ab ABCD abcd aBc abcde aBCd AB abcD ABCDEF $

;fișierul "cuvinte1.txt" va conține:

;Ab abcd aBCd abcD
extern exit, fclose, fopen, scanf, fprintf  
import exit msvcrt.dll 
import scanf msvcrt.dll
import fclose msvcrt.dll 
import fopen msvcrt.dll  
import fprintf msvcrt.dll 

segment data use32 class=data

        nume_fisier db "cuvinte1.txt", 0
        mod_fisier db "w", 0
        desc_fisier dd 0
        format_citire_cuvinte db "%s",0
        format_afisare db "%s" , 0
        spatiu db 32, 0
        max_len equ 100
        ;cuvant times max_len db 0
        buffer times max_len+1 db 0
        n db 0
        
segment code use32 class=code
    start:
        ;deschidem fisierul cu modul de scriere
        push dword mod_fisier
        push dword nume_fisier
        call [fopen]
        add esp,4*2
        cmp eax, 0 
        je final
        mov [desc_fisier], eax
    citire:
        ;citim cuvinte de la tastatura
        push dword buffer 
        push dword format_citire_cuvinte
        call [scanf]
        add esp,4*2
        cmp byte [buffer] , '$'
        je final
        mov esi, buffer
        mov dx,0            ; aici numaram cate caractere contine cuvantul
        mov ebx,0           ; aici verificam daca are litera mica
    parcurgere_cuvant:
        lodsb
        cmp al,0
        je verificare_par
        inc dx
        cmp al,'a'
        jl mai_departe
        cmp al,'z'
        jg mai_departe
        inc ebx
    mai_departe:
        jmp parcurgere_cuvant
    verificare_par:         ;verificam daca avem un numar par de cuvinte 
        mov cl,2
        mov ax,dx
        idiv cl
        cmp ah,0
        je verificare_litera
        jmp citire
    verificare_litera:
        cmp ebx,0
        je citire
    afisare:
        push dword buffer
        push dword format_afisare
        push dword [desc_fisier]
        call [fprintf]
        add esp, 4*3
                
        push dword spatiu
        push dword format_afisare
        push dword [desc_fisier]
        call [fprintf]
        add esp, 4*3
        jmp citire
    final:
        push dword [desc_fisier]
        call [fclose]
        add esp, 4
        push    dword 0      
        call    [exit]          