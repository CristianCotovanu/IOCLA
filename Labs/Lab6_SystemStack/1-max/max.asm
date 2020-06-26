%include "io.inc"

section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    ; cele doua numere se gasesc in eax si ebx
    mov eax, 122
    mov ebx, 99

    cmp eax, ebx
    jle print
    
    push ebx
    mov ebx, eax
    pop eax


print:
    PRINT_DEC 4, eax ; afiseaza maximul
    NEWLINE

    ret
