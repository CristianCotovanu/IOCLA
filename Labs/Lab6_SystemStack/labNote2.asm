%include "io.inc"
 
section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging                        
    mov eax, 7
    mov ebx, 8
    add eax, ebx
    sub esp, 4           ; rezerva 4 octeti pe stiva
    mov [esp], eax       ; muta la noua adresa catre care pointeaza esp continutul registrului eax
    mov eax, 10
    PRINT_UDEC 4, eax
    NEWLINE
 
    mov eax, [esp]       ; recupereaza valoarea de pe stiva
    add esp, 4           ; restabileste valoarea registrului esp
    PRINT_UDEC 4, eax
    
    