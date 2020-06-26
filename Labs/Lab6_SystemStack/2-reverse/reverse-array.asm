%include "io.inc"

section .data

%define ARRAY_LEN 7

    input dd 122, 184, 199, 242, 263, 845, 911
    output times ARRAY_LEN dd 0

section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    
    
    mov ecx, ARRAY_LEN
    xor edx, edx
reverse_array:
    push dword [input + 4 * (ecx - 1)]
    pop dword [output + 4 * edx]
    
    inc edx
    loop reverse_array
    

    PRINT_STRING "Reversed array:"
    NEWLINE
    xor ecx, ecx
print_array:
    PRINT_UDEC 4, [output + 4 * ecx]
    NEWLINE
    inc ecx
    cmp ecx, ARRAY_LEN
    jb print_array

    xor eax, eax
    ret
