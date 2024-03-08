bits 32

global start        

extern exit               
import exit msvcrt.dll    
          
;Exerciții simple    
          
segment data use32 class=data

;ex 10. 9+7
segment code use32 class=code
    start:
        mov al,9    ;AL = 9
        add al,7    ;AL = 9+7
        push    dword 0     
        call    [exit]       