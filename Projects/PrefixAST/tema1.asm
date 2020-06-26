%include "io.inc"

extern getAST
extern freeAST

section .bss
    ; La aceasta adresa, scheletul stocheaza radacina arborelui
    root: resd 1

section .text
global main
   
atoi:
    push ebp
    mov ebp, esp
    
    mov ebx, [ebp + 8]
    mov edx, ebx
    
    xor eax, eax
    xor ebx, ebx
    xor ecx, ecx
    
    cmp byte [edx], '-'             ; checks first char for negative numbers
    jne char_to_int
    
    inc ecx                         ; flag register: ecx = 0 -> positive number
                                    ; ecx = 1 -> negative number                         
    inc edx

char_to_int:
    xor ebx, ebx
    movzx ebx, byte [edx]           ; get current char from string
    
    test ebx, ebx                   ; checks for null terminator
    je if_negative
                                    ; checks for number to be in [0, 9] interval for ascii
    cmp ebx, '0'                   
    jl not_number
    
    cmp ebx, '9'
    jg not_number
     
    sub ebx, '0'                    ; ascii to decimal
    imul eax, 10                    ; multiply total by 10
    add eax, ebx                    ; add current digit to total
    
    inc edx                         ; get address of the next char
    jmp char_to_int
 
not_number:
    jmp done
    
if_negative:
    cmp ecx, 1
    jne done
    
negative:
    mov ebx, eax
    xor eax,eax
    sub eax, ebx
    
done:
    leave
    ret 
    
    
visit_node:
    push ebp
    mov ebp, esp
    
    mov ecx, dword [ebp + 8]
    mov ebx, [ecx + 4]
    mov edx, [ecx + 8]
    
    mov esi, [ebx]
    mov edi, [edx]

    mov esi, [esi]
    mov edi, [edi]
    
    cmp esi, '0'
    jae get_left_int
    
    push esi
    jmp check_right

get_left_int:
    push edx
    push ebx
    push ecx
    
    push dword [ebx]
    call atoi
    add esp, 4
    
    pop ecx
    pop ebx
    pop edx
    
    push eax 

check_right:
    cmp edi, '0'
    jae get_right_int
    
    push edi
    jmp visit_left_node

get_right_int:
    push edx
    push ebx
    push ecx
    
    push dword [edx]
    call atoi
    add esp, 4
    
    pop ecx
    pop ebx
    pop edx
    
    push eax
    jmp visit_left_node

recc_left:
    push edi
    push edx
    push eax
    
    push ebx
    call visit_node
    add esp, 4
    pop eax

    pop edx
    pop edi
    mov [esp + 4], eax

    mov ecx, [esp + 16]
    jmp return_from_left
    
recc_right:
    push eax
    push edx
    call visit_node
    add esp, 4
    
    pop eax
    mov [esp], eax
    mov ecx, [esp + 16]
    jmp compute_operation

visit_left_node:
    cmp esi, '0'
    jl recc_left

return_from_left:
    cmp edi, '0'
    jl recc_right

compute_operation:
    mov ecx, [ecx]
    mov ecx, [ecx]

    cmp ecx, '+'
    je addition
    cmp ecx, '*'
    je multiplication
    cmp ecx, '-'
    je subtraction
    
    cmp ecx, '/'
    je division

addition:
    xor eax, eax
    pop ecx
    pop eax
    add eax, ecx
    jmp return

multiplication:
    xor eax, eax
    pop ecx
    pop eax
    imul eax, ecx
    jmp return

subtraction:
    xor eax, eax
    pop ecx
    pop eax
    sub eax, ecx
    jmp return

division:
    xor eax, eax
    pop ecx
    pop eax
    cdq
    idiv ecx
    
return:
    mov [ebp + 12], eax                 ; put result at saved address in memory
    leave
    ret
        
    
main:
    push ebp
    mov ebp, esp
    
    ; put arguments in an AST and get root's address into eax
    call getAST
    mov [root], eax
    
    push eax        
    push dword [root]
    call visit_node
    add esp, 4

    PRINT_DEC 4, eax
    
    ; free memory allocated for tree
    push dword [root]
    call freeAST
    
    leave
    ret