bits 32 

global start        

extern exit               
import exit msvcrt.dll  
  
;Problemele din acest laborator trebuie rezolvate folosind instructiuni specifice lucrului cu siruri: LODSB, STOSB, MOVSB, SCASB, CMPSB, LODSW, STOSW, MOVSW, SCASW, CMPSW, LODSD, STOSD, MOVSD, SCASD, CMPSD. 

;ex 21. Dandu-se un sir de cuvinte sa se obtina sirul (de octeti) cifrelor in baza zece ale fiecarui cuvant din acest sir.            
segment data use32 class=data

    sir dw 1234h,5678h,1122h
    len equ ($-sir)/2       ;lungimea lui sir in word-uri
    ;d resw len*2    
    d times len dw 0

segment code use32 class=code
    start:
        mov ecx,len*2   ?   
        mov esi,sir         ;ESI = offset-ul sirului sursa
        mov edi,d
        jecxz final                          de ce nu trebuie cld?
    repeta:
        lodsb               ;AL = [sir+ESI], ESI++                               (= 34h, a doua oara il ia pe 12h)
        mov dl,10h          ;DL = 10 pentru a putea obtine ulterior restul impartirii la 10
        mov bl,al           ;BL = AL
        movzx ax,al         ;convertim byte-ul AL la word-ul AX fara semn pentru a putea impartii 10
        div dl              ;AX = AX/DL = AX/10                                  (AL = 3 catul, AH = 4 restul)
        mov al,ah           ;AL = AH = restul impartirii 
        stosb               ;[d+EDI] = AL, EDI++
        mov al,bl           ;AL = BL readucem valoarea initiala in AL            (=34h) 
        ror al,4            ;AL = AL inversat (pentru ca e word are 4 bytes)     (=43h)
        movzx ax,al 
        div dl 
        mov al,ah 
        stosb               ;[d+EDI] = AL, EDI++
        loop repeta
    final:
        push    dword 0      
        call    [exit]       
