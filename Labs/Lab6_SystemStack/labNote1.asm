%include "io.inc"
 
section .text
global CMAIN
CMAIN:                        
 
    mov eax, 7
    mov ebx, 8
    add eax, ebx
    push eax            ; pune pe stiva continutul registrului eax
    mov eax, 10         ; acum putem folosi registrul, intrucat valoarea lui este salvata pe stiva
    PRINT_UDEC 4, eax   ; 10
    NEWLINE
 
    pop eax             ; recupereaza valoarea registrului eax
    PRINT_UDEC 4, eax   ; 15