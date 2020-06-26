%include "io.inc"
section .data
    dword_array dd -1, -2, -3, 4, 5, 6, 8, -9, -11
    

section .text
global CMAIN
CMAIN:
    xor ecx, ecx
    xor eax, eax
    xor edx, edx
    xor ebx, ebx
    
check:
    cmp ecx, 9
    jz print
    
    cmp dword [dword_array + 4*(ecx - 1)], 0
    
    js countNeg
    jns countPos
    
    
countPos:
    inc ecx
    inc ebx
    jmp check
    
countNeg:
    inc ecx
    inc edx
    jmp check
    
print:  
    PRINT_STRING "Nr. negatives: "
    PRINT_DEC 4, edx
    NEWLINE
    PRINT_STRING "Nr. positives: "
    PRINT_DEC 4, ebx
    NEWLINE
    xor eax, eax
    ret