bits 32 

global start        

extern exit               
import exit msvcrt.dll    
       
;Înmulțiri, împărțiri _1     
;a,b,c - byte
       
segment data use32 class=data
    
    a db 20
    b db 20
    c db 20
    
;ex 10. 3*[20*(b-a+2)-10*c]/5
segment code use32 class=code
    start:
        ;b-a+2
        mov AL,[b]      ;AL = b 
        sub AL,[a]      ;AL = AL-a 
        add AL,2        ;AL = AL+2
        ;20 * (b-a+2)
        mov BL,20       ;BL = 20
        mul BL          ;AX = AL*BL
        ;10*c
        mov BX,AX       ;BX = AX , eliberam registrul AX
        mov AL,10       ;AL = 10 
        mul byte [c]    ;AX = AL*c 
        ;20*(b-a+2) - 10*c
        sub BX,AX       ;BX = BX-AX 
        ;3 * [20*(b-a+2)-10*c]
        mov AX,3        ;AX = 3 
        mul BX          ;DX:AX = AX*BX 
        ;3*[20*(b-a+2)-10*c] / 5
        mov BX,5        ;BX = 5 
        div BX          ;DX:AX = DX:AX/BX , in AX avem catul/AX = DX:AX/BX, iar in DX avem restul/DX = DX:AX%BX
        push    dword 0      
        call    [exit]       
