%include "io.inc"
extern printf

section .data
    before_format db "Before: %s", 13, 10, 0
    after_format db "After: %s", 13, 10, 0
    mystring db "abcdefGHIj", 0

section .text
global CMAIN

toupper:
    push ebp
    mov ebp, esp
    
    xor ebx, ebx
    xor edx, edx
    
    mov ebx, [ebp + 8]
    ;mov al, 0x20
test_char:
    mov dl, [ebx]
    
    test dl, dl
    jz return
    
    ;if a < dl < z
    cmp dl, 'a'         ;ascii for a = 97 and A = 65 => ascii(a) > ascii(A->Z)
    jb next_char
    cmp dl, 'z'         ;ascii for z = 122
    ja next_char
    
    sub dl, 0x20        ;toupper(dl)

next_char:
    mov [ebx], dl
    inc ebx
    jmp test_char

return:
    leave
    ret

CMAIN:
    mov ebp, esp; for correct debugging
    push ebp
    mov ebp, esp

    push mystring
    push before_format
    call printf
    add esp, 8

    push mystring
    call toupper
    add esp, 4

    push mystring
    push after_format
    call printf
    add esp, 8

    leave
    ret
