%include "io.inc"

extern printf

%DEFINE LENGTH 20

section .data
    string db "Nunc tristique ante maximus, dictum nunc in, ultricies dui.", 0
    char db 'a'

section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    push ebp
    mov ebp, esp

    mov al, byte [char]
    lea edi, [string]
    mov ecx, LENGTH

;set_byte:
    rep stosb
 ;   loop set_byte

    PRINT_STRING string

    xor eax, eax
    leave
    ret
