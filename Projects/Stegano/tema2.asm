%include "include/io.inc"

extern atoi
extern printf
extern exit
extern puts

; Functions to read/free/print the image.
; The image is passed in argv[1].
extern read_image
extern free_image
; void print_image(int* image, int width, int height);
extern print_image

; Get image's width and height.
; Store them in img_[width, height] variables.
extern get_image_width
extern get_image_height

section .rodata
        m_A dd ".-", 0
        m_B dd "-...", 0
        m_C dd "-.-.", 0
        m_D dd "-..", 0
        m_E dd ".", 0
        m_F dd "..-.", 0
        m_G dd "--.", 0
        m_H dd "....", 0
        m_I dd "..", 0
        m_J dd ".---", 0
        m_K dd "-.-", 0
        m_L dd ".-..", 0
        m_M dd "--", 0
        m_N dd "-.", 0
        m_O dd "---", 0
        m_P dd ".--.", 0
        m_Q dd "--.-", 0
        m_R dd ".-.", 0
        m_S dd "...", 0
        m_T dd "-", 0
        m_U dd "..-", 0
        m_V dd "...-", 0
        m_W dd ".--", 0
        m_X dd "-..-", 0
        m_Y dd "-.--", 0
        m_Z dd "--..", 0  
        
        m_1 dd ".----", 0
        m_2 dd "..---", 0
        m_3 dd "...--", 0
        m_4 dd "....-", 0
        m_5 dd ".....", 0
        m_6 dd "-....", 0
        m_7 dd "--...", 0
        m_8 dd "---..", 0
        m_9 dd "----.", 0
        m_0 dd "-----", 0
        
        m_coma dd "--..--", 0
section .data
	use_str db "Use with ./tema2 <task_num> [opt_arg1] [opt_arg2]", 10, 0

        task1_hint db "revient", 0
        
        task2_hint db "C'est un proverbe francais.", 0
        
section .bss
    task:       resd 1
    img:        resd 1
    img_width:  resd 1
    img_height: resd 1
    
    t1_line_number: resb 1

section .text
global main
main:
    mov ebp, esp; for correct debugging
    ; Prologue
    ; Do not modify!
    push ebp
    mov ebp, esp
    
    mov eax, [ebp + 8]
    cmp eax, 1
    jne not_zero_param

    push use_str
    call printf
    add esp, 4

    push -1
    call exit

not_zero_param:
    ; We read the image. You can thank us later! :)
    ; You have it stored at img variable's address.
    mov eax, [ebp + 12]
    push DWORD[eax + 4]
    call read_image
    add esp, 4
    mov [img], eax

    ; We saved the image's dimensions in the variables below.
    call get_image_width
    mov [img_width], eax
    
    call get_image_height
    mov [img_height], eax

    ; Let's get the task number. It will be stored at task variable's address.
    mov eax, [ebp + 12]
    push DWORD[eax + 8]
    call atoi
    add esp, 4
    mov [task], eax

    ; There you go! Have fun! :D
    mov eax, [task]
    cmp eax, 1
    je solve_task1
    cmp eax, 2
    je solve_task2
    cmp eax, 3
    je solve_task3
    cmp eax, 4
    je solve_task4
    cmp eax, 5
    je solve_task5
    cmp eax, 6
    je solve_task6
    jmp done

solve_task1:
    ; TODO Task1
    jmp done
solve_task2:
    ; TODO Task2
    jmp done
    
solve_task3:
    jmp done
   
    
solve_task4:
    mov eax, [ebp + 12]
    
    mov ebx, [eax + 12]     ;message string to be encoded
    mov edx, [eax + 16]     ;byte_nr in string

    push edx
    call atoi    
    add esp, 4
        
    push eax                ;byte_nr in an int
    push ebx                ;message starting address
    push dword [img]        ;image starting address    
    call lsb_encode   
    add esp, 12
    
    jmp done

lsb_encode:
    push ebp
    mov ebp, esp

    mov esi, [ebp + 8]          ;image
    mov edi, [ebp + 12]         ;message
    mov ebx, [ebp + 16]         ;byte_id (int)

    add esi, ebx
    add esi, ebx
    add esi, ebx
    add esi, ebx    ;get the address of encryption

initialize:
    mov ecx, 7
    cmp byte [edi], 0x00
    je end_encode

iterate:
    cmp ecx, 0
    je next_char_in_message

    xor ebx, ebx
    mov ebx, [edi]

    clc 
    shr bl, cl
    jc set_1
    jmp set_0
    
continue:
    dec ecx
    add esi, 4
    jmp iterate
    
set_1:
    xor eax, eax
    mov eax, 1
    or [esi], eax
    jmp continue

set_0:
    xor eax, eax
    mov eax, 1
    not eax
    and [esi], eax
    jmp continue
    
next_char_in_message:
    add esi, 4
    inc edi
    NEWLINE
    jmp initialize

end_encode:
    push dword [img_height]
    push dword [img_width]
    push dword [img]
    call print_image
    add esp, 12
    
    xor eax, eax
    xor ebx, ebx
    xor ecx, ecx
    xor edx, edx
    xor esi, esi
    xor edi, edi
    
    leave 
    ret

    
    
solve_task5:
    mov eax, [ebp + 12]
    
    mov edx, [eax + 12]     ;byte_nr in string
    
    push edx
    call atoi    
    add esp, 4
    
    push eax                ;byte_nr in an int
    push dword [img]        ;image starting address    
    call lsb_decode   
    add esp, 8
    
    jmp done
    
lsb_decode:
    push ebp
    mov ebp, esp

    mov esi, [ebp + 8]          ;image
    mov ebx, [ebp + 12]         ;byte_id (int)
    dec ebx
    
    ;get to the address of encryption
    add esi, ebx
    add esi, ebx
    add esi, ebx
    add esi, ebx

    xor edx, edx                ;will hold the consecutive number of 0s
    xor ebx, ebx
    xor ecx, ecx
    xor eax, eax
    
    ;eax holds the current char
    ;ecx holds the current number of bits set in the current char
    mov cl, 1
initialize_counter:
    mov bh, 8
    
add_char:
    cmp edx, 8
    je end_decode
    
    cmp bh, 0
    je next_and_print_char 
    
    dec bh
    mov bl, byte [esi]
    
    clc
    shr bl, cl
    jc found_1
    
    
found_0:
    inc edx
    shl al, cl
    
    add esi, 4
    jmp add_char
        
found_1:
    xor edx, edx    
    shl al, cl
    add al, 1
    
    add esi, 4
    jmp add_char

next_and_print_char:  
    PRINT_CHAR al
    
    xor eax, eax
    jmp initialize_counter

end_decode:
    xor eax, eax
    xor ebx, ebx
    xor ecx, ecx
    xor edx, edx
    xor esi, esi
    xor edi, edi  

    leave 
    ret
    
    
solve_task6:
    ; TODO Task6
    jmp done


    ; Free the memory allocated for the image.
done:
    
    push DWORD[img]
    call free_image
    add esp, 4
    ; Epilogue
    ; Do not modify!
    xor eax, eax
   
    leave
    ret
    
