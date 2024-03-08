bits 32 

global start        

extern exit               
import exit msvcrt.dll    
      
;Înmulțiri, împărțiri _2
;a,b,c,d - byte
      
segment data use32 class=data
    
    a db 20
    b db 20
    c db 20
    d db 20
    
;ex 10. a*d+b*c
segment code use32 class=code
    start:
        ;a*d
        mov AL,[a]          ;AL = a 
        mul byte [d]        ;AX = AL*d 
        ;b*c
        mov BX,AX           ;BX = AX , eliberam registrul AX 
        mov AL,[b]          ;AL = b 
        mul byte [c]        ;AX = AL*c 
        ;a*d + b*c
        add BX, AX          ;BX = BX+AX 
        push    dword 0      
        call    [exit]       
