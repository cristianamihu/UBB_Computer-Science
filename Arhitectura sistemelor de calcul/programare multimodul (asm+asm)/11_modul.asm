bits 32 

global print_hexa
global print_binar

extern printf
import printf msvcrt.dll

segment data use32 class=code public

    format_afisare_hexa db "%x",0
    format_afisare_zeci db "%s",0
    format_afisare_spatiu db "%s",0
    spatiu db " ",0
    sir_binar resw 100

segment code public use32 class=code
        ;esp = adresa de retur
        ;esp+4 = len
        ;esp+8 = sir
    print_hexa:
        mov ecx,[esp+4]
        mov esi,[esp+8]
    repeta:
        lodsb
        push ecx
        movzx eax,al
        push eax
        push format_afisare_hexa
        call [printf]
        add esp,4*2
        push dword spatiu
        push format_afisare_spatiu
        call [printf]
        add esp,4*2
        pop ecx
    loop repeta
    ret 4*2
    print_binar:
        mov ecx,[esp+4]
        mov esi,[esp+8]
    repeta_1:
        lodsb
        push ecx
        mov bl,al
        mov ecx, 8
        mov edi,sir_binar
        cld
    repeta_2:
        shl bl, 1
        mov al, 0
        rcl al, 1
        add al, '0'
        stosb
    loop repeta_2
        push dword sir_binar
        push dword format_afisare_zeci
        call [printf]
        add esp,4*2
        push dword spatiu
        push dword format_afisare_spatiu
        call [printf]
        add esp,4*2
        pop ecx
    loop repeta_1
        ret 4*2
