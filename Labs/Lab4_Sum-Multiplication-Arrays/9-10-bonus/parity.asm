%include "io.inc"

%define ARRAY_SIZE 12

section .data
    dword_arraz dd 7, 7, 7, -1, -1, -1, -1, -1, -1, 7, 8, -12
    dword_array dd 2, 2, 2, 3, 3
section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    xor ecx, ecx
    xor eax, eax
    xor edx, edx
    xor ebx, ebx
    xor edi, edi
    xor esi, esi
    mov ebx, 2
    
check:
    cmp ecx, ARRAY_SIZE
    jz print
    
    mov eax, dword [dword_arraz + 4 * ecx]
    div ebx
    
    cmp edx, 1
    jnz countEven
    jmp countOdd
    
countEven:
    inc ecx
    inc esi
    jmp check
    
countOdd:
    inc ecx
    inc edi
    jmp check
    
print:  
    PRINT_STRING "Nr. even: "
    PRINT_DEC 2, esi
    NEWLINE
    PRINT_STRING "Nr. odd: "
    PRINT_DEC 2, edi
    NEWLINE
    
    xor eax, eax
    ret