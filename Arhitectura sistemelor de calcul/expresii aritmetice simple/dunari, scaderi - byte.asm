bits 32 

global start

extern exit               
import exit msvcrt.dll    
      
;Adunări, scăderi -byte    
;a,b,c,d - byte
      
segment data use32 class=data
    
    a db 20
    b db 20
    c db 20
    d db 20

;ex 10. (a+d+d)-c+(b+b)
segment code use32 class=code
    start:
        ;a+d+d 
        mov AL,[a]      ;AL = a 
        add AL,[d]      ;AL = AL+d 
        add Al,[d]      ;AL = AL+d 
        ;(a+d+d)-c 
        sub AL,[c]      ;AL = AL-c 
        ;b+b 
        mov BL,[b]      ;BL = b 
        add BL,[b]      ;BL = BL+b 
        ;(a+d+d)-c+(b+b)
        add AL, BL      ;AL = AL+BL 
        push    dword 0      
        call    [exit]       
