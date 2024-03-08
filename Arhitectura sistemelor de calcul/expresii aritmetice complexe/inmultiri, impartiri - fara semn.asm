bits 32 


global start        


extern exit               
import exit msvcrt.dll    
                          
;Inmultiri, impartiri - interpretarea fara semn
;a-byte b-word e-doubleword x-qword 
segment data use32 class=data
    
    a db 4
    b dw 2
    e dd 5
    x dq 3
    
;ex 21.  (a*a/b+b*b)/(2+b)+e-x
segment code use32 class=code
    start:
        
        ;a*a/b 
        mov al,[a]        ;al=a
        mul byte[a]       ;ax=a*a           
        mov dx,0          ;conversie fara semn de la word-ul din ax la dword-ul dx:ax  => dx:ax=a*a
        div word[b]       ;dx:ax=a*a/b , in ax=dx:ax/b avem câtul și in dx=dx:ax%b avem restul
        mov cx,ax         ;cx=a*a/b 
        
        ;a*a/b+b*b
        mov ax,[b]        ;ax=b
        mul word[b]       ;dx:ax=b*b
        add ax,cx         ;dx:ax=a*a/b+b*b
        
        ;2+b 
        mov bx,[b]        ;bx=b
        add bx,2          ;bx=2+b 
        
        ;(a*a/b+b*b)/(2+b)+e
        div bx            ;ax=(a*a/b+b*b)/(2+b)
        movzx ebx,ax      ;conversie fara semn de la ax la ebx  => ebx=(a*a/b+b*b)/(2+b)
        add ebx,[e]       ;ebx=(a*a/b+b*b)/(2+b)+e
        mov ecx,0         ;ecx:ebx=(a*a/b+b*b)/(2+b)+e
        
        ;(a*a/b+b*b)/(2+b)+e-x
        mov eax,[x]
        mov edx,[x+4]     ;edx:eax=x 
        sub ebx,eax 
        sbb ecx,edx       ;ecx:ebx=(a*a/b+b*b)/(2+b)+e-x

        push    dword 0      
        call    [exit]       
