%include "io.inc"

section .data
    myString: db "Hello, World!",0
    endString: db "Goodbye, World!",0

section .text
global CMAIN
CMAIN:
    mov ecx, 6                 ; N = valoarea registrului ecx
    mov eax, 1
    mov ebx, 1
    cmp eax, ebx
    jae print
    ret
print:
    sbb ecx, 1
    PRINT_STRING myString
    NEWLINE
    cmp ecx, 0
    ja print
    PRINT_STRING endString
    
    ret
