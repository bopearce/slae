global _start
section .text

 _start:
      ;push byte 2
      ;pop eax
      xor eax,eax
      inc eax
      inc eax
      int 0x80
      ;jmp short _start
      jmp _start
