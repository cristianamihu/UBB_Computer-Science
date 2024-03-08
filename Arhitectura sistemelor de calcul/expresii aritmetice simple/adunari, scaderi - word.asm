bits 32 

global start        

extern exit               
import exit msvcrt.dll    

;Adunări, scăderi -word    
;a,b,c,d - word

segment data use32 class=data
   
    a dw 40
    b dw 40
    c dw 40
    d dw 40
    
;ex 10. b+c+d+a-(d+c)
segment code use32 class=code
    start:
        ;b+c+d+a 
        mov AX,[b]      ;AX = b 
        add AX,[c]      ;AX = AX+c 
        add AX,[d]      ;AX = AX+d 
        add AX,[a]      ;AX = AX+a 
        ;d+c
        mov BX,[d]      ;BX = d 
        add BX,[c]      ;BX = BX+c 
        ;b+c+d+a-(d+c)
        sub AX, BX      ;AX = AX-BX
        push    dword 0      
        call    [exit]       
