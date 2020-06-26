%include "io.inc"

section .text
global CMAIN
CMAIN:
    push ebp
    mov ebp, esp

    mov eax, 211    ; to be broken down into powers of 2
    mov ebx, 1      ; stores the current power

check:
    mov ecx, eax
    
    cmp eax, ebx
    jl end
    
    and ecx, ebx
    jnz print
    
    imul ebx, 2
    jmp check

print:
    PRINT_DEC 4, ebx
    NEWLINE
    cmp eax, ebx
    jl end
    imul ebx, 2
    jmp check
    
end:
    leave
    ret
