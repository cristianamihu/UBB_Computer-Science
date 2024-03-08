bits 32 


global start        


extern exit               
import exit msvcrt.dll 

     ;Operatii pe biti 
     
;ex 4. Se da octetul A. Sa se obtina numarul intreg n reprezentat de bitii 2-4 ai lui A. Sa se obtina apoi in B octetul rezultat prin rotirea spre dreapta a lui A cu n pozitii. Sa se obtina dublucuvantul C:
      ;-bitii 8-15 ai lui C sunt 0
      ;-bitii 16-23 ai lui C coincid cu bitii lui B
      ;-bitii 24-31 ai lui C coincid cu bitii lui A
      ;-bitii 0-7 ai lui C sunt 1               
segment data use32 class=data

    a db 9fh
    b resb 1
    c resd 1
;rezultat: b = 3f, n=07, c=9f3f00ff
segment code use32 class=code
    start:
        ;obtinerea numarului intreg n reprezentat de bitii 2-4 ai lui A
        mov al,[a]              ;AL=a
        and al,00011100b        ;pastrez in AL doar bitii 2-4
        shr al,2                ;duc acei biti de care am nevoie pe pozitiile 0-2
        mov cl,al               ;pun in CL numarul obtinut pentru a putea roti ulterior de CL ori pentru a obtine B-ul
        
        ;obtinerea in B a octetului rezultat prin rotirea spre dreapta a lui A cu n pozitii
        mov al,[a]              ;pun in AL din nou valoarea lui a
        ror al,cl               ;il obtin pe B facand rotirea lui A la dreapta de n ori ;AL=b
        
        ;obtinerea dublucuvantului C
        ;-bitii 0-7 ai lui C sunt 1 
        or dword[c],00000000000000000000000011111111b   ;adaug pe pozitiile 0-7 din c valoarea 1
        
        ;-bitii 16-23 ai lui C coincid cu bitii lui B
        cbw                     ;convertirea byte-ului din AL in word-ul AX ;AX=b
        cwde                    ;convertirea word-ului din AX la doubleword-ul EAX ; EAX=b
        shl eax,16              ;duc bitii lui b pe pozitiile 16-23
        and eax,00000000111111110000000000000000b       ;pastrez in EAX doar bitii 16-23 ai lui b 
        or dword[c],eax         ;pun in c pe poztiile 16-23 valoarea lui b 
        
        ;-bitii 24-31 ai lui C coincid cu bitii lui A
        mov al,[a]              ;AL=a
        cbw                     ;convertirea byte-ului din AL la word-ul AX ;AX=a
        cwde                    ;convertirea word-ului din AX la doubleword-ul EAX ;EAX=a
        shl eax,24              ;duc pe pozitiile 24-31 valoarea lui a
        and eax,11111111000000000000000000000000b       ;pastrez doar pozitiile 24-31 de care am nevoie 
        or dword[c],eax         ;pun pe pozitile 24-31 ale lui c, valoarea lui a
        
        ;-bitii 8-15 ai lui C sunt 0
        ;C-ul este complet pentru ca pe pozitiile 8-15 am deja valoarea 0

        push    dword 0      
        call    [exit]       
