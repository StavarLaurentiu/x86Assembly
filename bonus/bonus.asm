section .data

section .text
    global bonus

bonus:
    ;; DO NOT MODIFY
    push ebp
    mov ebp, esp
    pusha

    mov eax, [ebp + 8]	; x
    mov ebx, [ebp + 12]	; y
    mov ecx, [ebp + 16] ; board

    ;; DO NOT MODIFY
    ;; FREESTYLE STARTS HERE

    ; Save x in esi
    mov esi, eax

    ; Free eax and edx because we will use them (in "mul")
    xor eax, eax
    xor edx, edx
    inc eax

    ; Store in edi how many shifts we need to do in order to be at (x, y) position
    ; edi = 8 * x + y
    xor edi, edi
    mov edi, esi
    shl edi, 3
    add edi, ebx

    ; Keep on stack the current edi (IT WILL BE USED FOR EVERY OF
    ; THE 4 BYTES: BOTTOM LEFT, RIGHT AND TOP LEF, RIGHT)
    push edi

    ; Check if we can add a byte to the bottom left
    cmp esi, 0
    jz skip_

    cmp ebx, 0
    jz skip_

    ; Bottom left
    sub edi, 9
    push edi

    ; Use ebx to multiply eax
    ; Basically shift eax 1 byte to the left
    ; Save value of ebx on stack
    push ebx
    mov ebx, 2
loop_label:
    mul ebx

    ; If eax is 0 it means that edi was bigger than 31
    ; so we clear edx and start from the beginning
    ; After the loop eax will be placed in board[0]
    cmp eax, 0
    jg no_swap

    dec edi
    xor edx, edx
    mov eax, 1

no_swap:

    dec edi
    cmp edi, 0
    jg loop_label

    ; Decide where to put the computed number (board[0] or board[1])
    pop ebx
    pop edi 
    cmp edi, 31
    jg put_in_first

    add [ecx + 4], eax
    jmp skip_

put_in_first:
    add [ecx], eax

skip_:

    ; Get (x,y) position back in edi
    pop edi 
    push edi

    ; Check if we can add a byte to the bottom right
    cmp esi, 0
    jz skip_2_

    cmp ebx, 7
    jz skip_2_

    ; Bottom right
    sub edi, 7
    push edi

    xor eax, eax
    xor edx, edx
    inc eax
    
    ; Use ebx to multiply eax
    ; Basically shift eax 1 byte to the left
    ; Save ebx on stack
    push ebx
    mov ebx, 2
loop_label_2:
    mul ebx

    ; If eax is 0 it means that edi was bigger than 31
    ; so we clear edx and start from the beginning
    ; After the loop eax will be placed in board[0]
    cmp eax, 0
    jg no_swap_2

    dec edi
    xor edx, edx
    mov eax, 1

no_swap_2:

    dec edi
    cmp edi, 0
    jg loop_label_2

    ; Decide where to put the computed number (board[0] or board[1])
    pop ebx
    pop edi 
    cmp edi, 31
    jg put_in_first_2

    add [ecx + 4], eax
    jmp skip_2_

put_in_first_2:
    add [ecx], eax

skip_2_:

    ; Get (x,y) position back
    pop edi 
    push edi

    ; Check if we can add a byte to the top left
    cmp esi, 7
    jz skip_3_

    cmp ebx, 0
    jz skip_3_

    ; Top left
    add edi, 7
    push edi 

    xor eax, eax
    xor edx, edx
    inc eax
    
    ; Use ebx to multiply eax
    ; Basically shift eax 1 byte to the left
    ; Save ebx on stack
    push ebx
    mov ebx, 2
loop_label_3:
    mul ebx

    ; If eax is 0 it means that edi was bigger than 31
    ; so we clear edx and start from the beginning
    ; After the loop eax will be placed in board[0]
    cmp eax, 0
    jg no_swap_3

    xor edx, edx
    mov eax, 1
    dec edi

no_swap_3:

    dec edi
    cmp edi, 0
    jg loop_label_3

    ; Decide where to put the computed byte (board[0] or board[1])
    pop ebx
    pop edi 
    cmp edi, 31
    jg put_in_first_3

    add [ecx + 4], eax
    jmp skip_3_

put_in_first_3:
    add [ecx], eax

skip_3_:

    ; Get (x,y) position back
    pop edi 

    ; Check if we can add a byte to the top right
    cmp esi, 7
    jz skip_4_

    cmp ebx, 7
    jz skip_4_

    ; Top right
    add edi, 9
    push edi 

    xor eax, eax
    xor edx, edx
    inc eax
    
    ; Use ebx to multiply eax
    ; Basically shift eax 1 byte to the left
    ; Save ebx on stack
    mov ebx, 2
loop_label_4:
    mul ebx

    ; If eax is 0 it means that edi was bigger than 31
    ; so we clear edx and start from the beginning
    ; After the loop eax will be placed in board[0]
    cmp eax, 0
    jg no_swap_4

    xor edx, edx
    mov eax, 1
    dec edi

no_swap_4:

    dec edi
    cmp edi, 0
    jg loop_label_4

    ; Decide where to put the computed byte (board[0] or board[1])
    pop edi 
    cmp edi, 31
    jg put_in_first_4

    add [ecx + 4], eax
    jmp skip_4_

put_in_first_4:
    add [ecx], eax

skip_4_:

    ;; FREESTYLE ENDS HERE
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY