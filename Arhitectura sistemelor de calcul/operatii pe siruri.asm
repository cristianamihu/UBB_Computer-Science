bits 32 


global start        


extern exit               
import exit msvcrt.dll  
  
;Instructiuni de comparare, salt conditionat si de ciclare. Operatii pe siruri.

;ex 23. Se da un sir de octeti S. Sa se obtina in sirul D multimea elementelor din S.
  ;Exemplu:
    ;S: 1, 4, 2, 4, 8, 2, 1, 1
    ;D: 1, 4, 2, 8
segment data use32 class=data

    s db 1,4,2,4,8,2,1,1
    len equ $-s
    d times len db 0 
    
segment code use32 class=code
    start:
        mov ecx,len           ;ECX=lungimea sirului initial s 
        mov esi,0             ;i=0
        mov edi,0             ;j=0
        jecxz sfarsit
        repeta:
            ;citesc s[i]
            mov al,[s+esi]  
            push ecx
            mov ecx,edi           
            jecxz pune_in_d
            compara:
                cmp al,[d+ecx]
                je mai_departe         ;verifica s[i] = d[i]
            loop compara
            pune_in_d:
                mov [d+edi],al    ;pun in d[i]
                inc edi           ;j++
            mai_departe:
                inc esi           ;i++
                pop ecx
        loop repeta
    sfarsit:   
        push    dword 0      
        call    [exit]       
