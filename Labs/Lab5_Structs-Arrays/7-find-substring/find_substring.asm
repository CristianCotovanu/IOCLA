%include "io.inc"

section .data
source_text: db "ABCABCBABCBABCBBBABABBCBABCBAAACCCB", 0
substring: db "BABC", 0

source_length: resd 1
substr_length: dd 4

print_format: db "Index of substring: ", 0

section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    push ebp
    mov ebp, esp

    mov al, 0  ; \0
    lea edi, [source_text]
    cld
    
    ; FIND THE LENGTH 
    repne scasb
    
    sub edi, source_text + 1
    sub edi, [substr_length]
    mov [source_length], edi
   
    xor eax, eax

find_indices:
    cmp eax, [source_length]
    jg return
    
    mov ecx, [substr_length]
    lea esi, [source_text + eax]
    lea edi, [substring]
    
    repe cmpsb
    jne advance
    
    PRINT_STRING print_format
    PRINT_UDEC 4, eax
    NEWLINE
    
advance:
    inc eax    
    jmp find_indices
        
return:
    leave
    ret