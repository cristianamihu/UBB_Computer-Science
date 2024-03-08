bits 32 

global start        

extern exit, fopen, fprintf, fclose   
import exit msvcrt.dll
import fopen msvcrt.dll
import fprintf msvcrt.dll 
import fclose msvcrt.dll    
   
; ex. 21. Se dau un nume de fisier si un text (definite in segmentul de date). Textul contine litere mici, cifre si spatii. Sa se inlocuiasca toate cifrele de pe pozitii impare cu caracterul ‘X’. Sa se creeze un fisier cu numele dat si sa se scrie textul obtinut in fisier.

segment data use32 class=data
    
    nume_fisier db "functii.txt",0
	mod_acces db "w",0              ; modul de deschidere al fisierului = w (pentru scriere)
    text db "5792401968",0
    len_text equ $-text 
	text_obtinut times len_text db 0
	descriptor dd -1                ;?

segment code use32 class=code
    start:
        ; fopen("functii.txt","w")       
		push dword mod_acces
		push dword nume_fisier
		call [fopen]
		add esp, 4*2             ; eliberam parametri de pe stiva
        cmp eax, 0
		je final
		mov [descriptor], eax    ; salvam ce returneaza fopen in descriptor
		mov ecx, len_text
        jecxz final
		cld 
		mov esi, text 
		mov edi, text_obtinut
	repeta:
        movsb                   ;EDI = ESI, ESI++ si EDI++    
		lodsb                   ;AL = ESI, ESI++
		cmp al, 30h
		jb continua
		cmp al, 39h
		ja continua
		mov al, 'x'
	continua:
		stosb                   ;EDI = AL, EDI++
        ;lodsb                  
        ;stosb
	loop repeta
		; fprintf(descriptor, text_obtinut)
        push dword text_obtinut
		push dword [descriptor]
		call [fprintf]
		add esp, 4*2
		; fclose(descriptor), inchiderea fisierului
		push dword descriptor
		call [fclose]
		add esp, 4*1
    final:
        push    dword 0      
        call    [exit]       
        