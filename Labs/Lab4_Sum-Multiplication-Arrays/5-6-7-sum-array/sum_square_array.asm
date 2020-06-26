%include "io.inc"

%define ARRAY_SIZE 10

section .data
    dword_array dd 1392, 12544, 7992, 6992, 7202, 27187, 28789, 17897, 12988, 17992
    print_format db "Squares sum is: ", 0

section .text
global CMAIN
CMAIN:
    push ebp
    mov ebp, esp
    
    mov ecx, ARRAY_SIZE
    xor eax, eax
    xor edx, edx
        
add_square:
    mov edx, dword [dword_array + 4*(ecx - 1)]
    imul edx, edx
    add eax, edx
    loop add_square
    
    PRINT_STRING print_format
    PRINT_UDEC 4, eax
    NEWLINE
    
    leave    
    ret