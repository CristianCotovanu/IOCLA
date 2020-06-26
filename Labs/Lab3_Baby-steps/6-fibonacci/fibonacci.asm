%include "io.inc"

section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    mov eax, 7      ; vrem sa aflam al N-lea numar; N = 7
    mov ebx, 0
    mov ecx, 1
    sbb eax, 2      ; avem deja primele 2 numere din sir, acesta fiind recurent
    
fibonacci:
    sbb eax, 1
    mov edx, ecx
    add edx, ebx
    
    mov ebx, ecx
    mov ecx, edx
    
    cmp eax, 0
    ja fibonacci
    
    PRINT_DEC 4, ecx
  
    ret