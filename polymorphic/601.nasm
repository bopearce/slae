global _start

section .text

_start:
    ;xor eax,eax
    xor ecx, ecx ;new
    mul ecx ;new 
    push eax
    push dword 0x68732f2f
    push dword 0x6e69622f
    mov ebx,esp
    ;mov ecx,eax not needed due to new xor ecx, ecx
    ;mov edx,eax not needed due to new mul ecx, which zeros edx
    mov al,0xb
    int 0x80
    ; the following instructions are not needed
    ;xor eax,eax
    ;inc eax
    ;int 0x80
