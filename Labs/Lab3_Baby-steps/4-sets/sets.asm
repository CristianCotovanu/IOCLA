%include "io.inc"

section .text
global CMAIN
CMAIN:
    ;cele doua multimi se gasesc in eax si ebx
    mov eax, 139
    mov ebx, 169
    PRINT_DEC 4, eax ; afiseaza prima multime
    NEWLINE
    PRINT_DEC 4, ebx ; afiseaza cea de-a doua multime
    NEWLINE
    jmp difference

reunion:
    PRINT_STRING "Set reunion is: "
    or eax, ebx
    PRINT_DEC 4, eax
    NEWLINE
    jmp print
    
add_element:
    PRINT_STRING "Set intersection is: "
    mov edx, 3
    or eax, 8
    PRINT_DEC 4, eax
    NEWLINE
    jmp print
    
intersection:
    PRINT_STRING "Set intersection is: "
    and eax, ebx
    PRINT_DEC 4, eax
    NEWLINE
    jmp print
    
complement:
    PRINT_STRING "Set complement is: "
    xor eax, 0xFFFF
    PRINT_DEC 4, eax
    NEWLINE
    jmp print
    
remove_element:
    mov ecx, 3
    mov edx, 8
    not edx
    or eax, edx
;    xor eax, 8
    jmp print
    
difference:
    PRINT_STRING "Set difference is (eax - ebx): "
    and eax, ebx
    xor ebx, eax
    PRINT_DEC 4, ebx
    NEWLINE
    jmp print

print:
    ;PRINT_STRING "First set is: "
    ;PRINT_DEC 4, eax ; afiseaza prima multime
    NEWLINE
    ;PRINT_STRING "Second set is: "
    ;PRINT_DEC 4, ebx ; afiseaza cea de-a doua multime
    NEWLINE
    xor eax, eax
    ret
