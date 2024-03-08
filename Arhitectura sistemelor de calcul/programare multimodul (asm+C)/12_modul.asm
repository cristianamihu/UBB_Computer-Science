bits 32 

global _print_hexa
global _print_binar

extern _printf

segment data use32 class=code public

    format_afisare_hexa db "%x",0
    format_afisare_zeci db "%s",0
    format_afisare_spatiu db "%s",0
    format_afisare_binar db "%b",0
    spatiu db " ",0
    sir_binar resw 100

segment code public use32 class=code
        ;ebp = old ebp
        ;ebp+4 = adresa de retur
        ;ebp+8 = len
        ;ebp+12 = sir
        push ebp
        mov ebp, esp
    _print_hexa:
        mov ecx,[esp+8]
        mov esi,[esp+12]
    repeta:
        lodsb
        push ecx
        movzx eax,al
        push eax
        push format_afisare_hexa
        call _printf
        add esp,4*2
        push dword spatiu
        push format_afisare_spatiu
        call _printf
        add esp,4*2
        pop ecx
    loop repeta
        ret 4*2
    _print_binar:
        mov ecx,[esp+8]
        mov esi,[esp+12]
    repeta_1:
        ; lodsb
        ; push ecx
        ; movzx eax,al
        ; push eax
        ; push format_afisare_binar
        ; call _printf
        ; add esp,4*2
        ; push dword spatiu
        ; push format_afisare_spatiu
        ; call _printf
        ; add esp,4*2
        ; pop ecx
    ; loop repeta_1
        ; ret 4*2
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
        call _printf
        add esp,4*2
        push dword spatiu
        push dword format_afisare_spatiu
        call _printf
        add esp,4*2
        pop ecx
    loop repeta_1
        mov esp, ebp
        pop ebp
        ret 4*2
    