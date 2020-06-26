%include "io.inc"

%define NUM 5

section .text
global CMAIN
CMAIN:
    mov ebp, esp

    ; TODO 1: replace every push by an equivalent sequence of commands
    
    ; pushing an array on the stack
    mov ecx, NUM
    
push_nums:
    sub esp, 4
    mov [esp], ecx
    loop push_nums

    
    mov edx, esp

    ; pushing a string on the stack
    sub esp, 4
    mov byte [esp], 0
    
    sub esp, 4
    mov dword [esp], "mere"
    
    sub esp, 4
    mov dword [esp], "are "
    
    sub esp, 4
    mov dword [esp], "Ana "
    
    
    PRINT_STRING [esp]
    NEWLINE
    NEWLINE
    
    
    ; TODO 2: print the stack in "address: value" format in the range of [ESP:EBP]
    ; (from low addresses to high addresses, byte by byte)
    lea eax, [ebp]
print:
    cmp eax, esp
    jl print_string         ;when esp reaches eax(holds the base of the stack) it ends
    
    PRINT_STRING "0x"
    PRINT_HEX 1, eax        ;stack address
    PRINT_STRING ": "  
    PRINT_HEX 1, [eax]      ;value at stack address
    NEWLINE
    
    ;PRINT_STRING "0x"
    ;PRINT_HEX 1, esp        ;stack address
    ;PRINT_STRING ": "  
    ;PRINT_HEX 1, [esp]      ;value at stack address
    ;NEWLINE
    
    ;low to high
    ;add esp, 1              ;iterate through stack by 1 byte
    
    ;high to low
    sub eax, 1              ;iterate through stack by 1 byte
    jmp print
    
    
    ;init esp to string 1st byte
    lea esp, [edx]
print_string:
    ; TODO 3: print the string byte by byte
    lea ecx, [esp]
    NEWLINE
    
    
print_char:
    cmp byte [ecx], 0
    je return
    
    PRINT_CHAR [ecx]
    inc ecx
    jmp print_char


return:    
    NEWLINE    
    mov ecx, NUM            ;put in ecx number of elems from array
    mov esp, edx            ;put into esp the address of array (retained into edx)
    xor eax, eax            ;zero eax
print_array:
    PRINT_HEX 4, [esp + 4*eax]
    inc eax
    loop print_array
    

    ; restore the previous value of the EBP (Base Pointer)
    mov esp, ebp

    ; exit without errors
    xor eax, eax
    ret
