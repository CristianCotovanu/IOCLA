%include "io.inc"

%define NUM_FIBO 10

section .text
global CMAIN
CMAIN:
    mov ebp, esp

    push 1
    push 1
    
    mov ecx, 2
compute_fibo:
    cmp ecx, NUM_FIBO       ;Stopping condition
    je print                ;if (ecx == 10) => 10 numbers were computed
    
    mov eax, [esp]
    add eax, [esp + 4]
    push eax
    
    inc ecx
    jmp compute_fibo
   
    mov ecx, NUM_FIBO
print:
    PRINT_UDEC 4, [esp + (ecx - 1) * 4]
    PRINT_STRING " "
    dec ecx
    cmp ecx, 0
    ja print

    mov esp, ebp
    xor eax, eax
    ret
