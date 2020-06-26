%include "io.inc"

section .text
global CMAIN
CMAIN:
    ;cele doua numere se gasesc in eax si ebx
    mov eax, -5
    mov ebx, 9 

    cmp eax, ebx
    jg swap
    jl end
    
swap:
    xchg eax, ebx
    
end:
    PRINT_DEC 4, eax ; afiseaza minimul
    NEWLINE

    ret