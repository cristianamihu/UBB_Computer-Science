bits 32 


global start        


extern exit               
import exit msvcrt.dll    
                          
;Adunari, scaderi - interpretare fara semn
;a-byte b-word  c-doubleword  d-qword 

segment data use32 class=data
    
    a db 2
    b dw 3
    c dd 3
    d dq 2
    
;ex 21.  (c-a)+(b-d)+d 
segment code use32 class=code
    start:
    
        ;c-a
        mov eax,[c]          ;eax=c
        movzx ebx,byte[a]    ;conversie fara semn de la byte la double word-ul ebx  => ebx=a 
        sub eax,ebx          ;eax=c-a
        mov edx,0            ;conversie fara semn de la eax la edx:eax  => edx:eax=c-a
        
        ;b-d
        mov bx,[b]           ;bx=b
        movzx ebx,bx         ;conersie fara semn de la bx la ebx
        mov ecx,0            ;conversie fara semn de la bx la ecx:ebx  => ecx:ebx=b
        sub ebx,[d]
        sbb ecx,[d+4]        ;ecx:ebx=b-d
        
        ;(c-a)+(b-d)
        add eax,ebx
        adc edx,ecx          ;edx:eax=(c-a)+(b-d)
        
        ;(c-a)+(b-d)+d
        add eax,[d]
        adc edx,[d+4]        ;edx:eax=(c-a)+(b-d)+d
        
        push    dword 0      
        call    [exit]       
