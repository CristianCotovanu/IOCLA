%include "io.inc"
extern printf

section .data
    mystring db "This is my string", 0
    printf_string db "String length is %u", 10, 0
    store_string times 64 db 0

section .text
global CMAIN

reverse_string:
    push ebp
    mov ebp, esp

    mov eax, dword [ebp + 8]
    mov ecx, dword [ebp + 12]
    add eax, ecx
    dec eax
    mov edx, dword [ebp + 16]

copy_one_byte:
    mov bl, byte [eax]
    mov byte [edx], bl
    dec eax
    inc edx
    loopnz copy_one_byte

    inc edx
    mov byte [edx], 0

    leave
    ret

CMAIN:
    mov ebp, esp; for correct debugging
    push ebp
    mov ebp, esp

    mov eax, mystring
    xor ecx, ecx
test_one_byte:
    mov bl, byte [eax]
    test bl, bl
    je out
    inc eax
    inc ecx
    jmp test_one_byte

out:
    push ecx                    ;retain value of ecx as string length
    sub eax, mystring           ;so eax contains only the length of the string
    
print_string:
    push eax
    push printf_string
    call printf

reverse_my_string:
    pop edx
    ;PRINT_STRING [edx]          ; edx has the printf_string ---- why ?
    ;add esp, 4                  
    pop ecx
    push store_string
    push ecx
    push mystring
    call reverse_string
    
    ;push ecx
    ;push store_string
    ;call printf

    push store_string
    call puts
        
    leave
    ret
