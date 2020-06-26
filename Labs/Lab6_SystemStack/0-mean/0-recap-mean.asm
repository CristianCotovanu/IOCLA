%include "io.inc"

%define ARRAY_SIZE 13
%define DECIMAL_PLACES 5

section .data
    num_array dw 76, 12, 65, 19, 781, 671, 431, 761, 782, 12, 91, 25, 9
    array_sum_prefix db "Sum of numbers: ",0
    array_mean_prefix db "Numbers mean: ",0
    decimal_point db ".",0

section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    xor eax, eax
    mov ecx, ARRAY_SIZE

sum:
    add ax, [num_array + 2*(ecx - 1)]     ;Compute sum
    loop sum
    

    PRINT_STRING array_sum_prefix
    PRINT_UDEC 2, ax
    NEWLINE

quotient:                                ;Compute quotient
    xor edx, edx            ;divident is stored in edx:eax
    mov ebx, ARRAY_SIZE     ;divisor
    div bx

    PRINT_STRING array_mean_prefix
    PRINT_UDEC 2, ax
    PRINT_STRING decimal_point

    xor eax, eax
    ret
