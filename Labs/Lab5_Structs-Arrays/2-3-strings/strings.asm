%include "io.inc"

section .data
    string db "Lorem ipsum dolor sit amet.", 0
    print_strlen db "strlen: ",  0
    print_occ db "occurences of `i`: ", 0

    occurences dd 0
    length dd 0    
    char db 'i'

section .text
global CMAIN
CMAIN:
    push ebp
    mov ebp, esp

    ;COMPUTE STRING LENGTH
    xor ecx, ecx
    xor eax, eax
    
    mov edi, string
    not ecx
    cld
    repne scasb
    not ecx
    dec ecx
    mov dword [length], ecx
    PRINT_STRING print_strlen
    PRINT_UDEC 4, [length]
    NEWLINE
    
    ;COMPUTE OCCURENCES OF CHAR IN STRING
    mov ecx, dword [length]
    mov edi, string
    mov esi, char
    mov eax, char
    xor ebx, ebx
    
    mov al, byte [char]
    lea edi, [string]
    
count:
    repne scasb
    jcxz print
    inc ebx
    jmp count
    
print:
    mov [occurences], ebx
    PRINT_STRING print_occ
    PRINT_UDEC 4, [occurences]
    NEWLINE

    xor eax, eax
    leave
    ret
