bits 32 


global start        


extern exit               
import exit msvcrt.dll    
                          
;Adunari, scaderi - interpretare cu sem
;a-byte  b-word  c-doubleword  d-qword
segment data use32 class=data
    
    a db 5
    b dw 5
    c dd 3
    d dq 6
   
;ex 21.  d-a+(b+a-c)
segment code use32 class=code
    start:
    
        ;d-a
        mov ebx,[d]    
        mov ecx,[d+4]   ;ecx:ebx=d 
        mov al,[a]      ;al=a 
        cbw             ;conversie cu semn de la byte-ul din al la word-ul ax
        cwde            ;conversie cu semn de la word-ul din ax la dword-ul eax
        cdq             ;conversia cu semn de la dword-ul eax la quadword-ul edx:eax  => edx:eax=a
        sub ebx,eax
        sbb ecx,edx     ;ecx:ebx=d-a 
        
        ;b+a-c
        MOV ax,[b]
        MOV dl,[a]
        movsx eax,ax    ;conversie cu semn de la word-ul din ax la dword-ul eax  => eax=b 
        movsx edx,dl    ;conversie cu semn de la byte-ul din dl la dword-ul edx  => edx=a 
        add eax, edx    ;eax=b+a  
        mov edx,[c]     ;edx=c 
        sub eax,edx     ;eax=b+a-c 
        
        ;d-a+(b+a-c)
        add ebx,eax 
        adc ecx,edx      ;ecx:ebx=d-a+(b+a-c)
        
        push    dword 0      
        call    [exit]       
