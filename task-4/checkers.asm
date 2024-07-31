
section .data

section .text
	global checkers

checkers:
    ;; DO NOT MODIFY
    push ebp
    mov ebp, esp
    pusha

    mov eax, [ebp + 8]	; x
    mov ebx, [ebp + 12]	; y
    mov ecx, [ebp + 16] ; table

    ;; DO NOT MODIFY
    ;; FREESTYLE STARTS HERE

    xor edx, edx

    ; If x is 0 skip modifying the x - 1 row
    cmp eax, 0
    jng x_is_0

    lea edx, [ecx + 8 * eax - 8]

    ; If y is 0 skip modifying the y - 1 col
    cmp ebx, 0
    jng y_is_0
    mov byte [edx + ebx - 1], 1

y_is_0:
    ; If y is 7 skip modifying the y + 1 col
    cmp ebx, 7
    jnb y_is_7
    mov byte [edx + ebx + 1], 1

y_is_7:

x_is_0:

    ; If x is 7 skip modifying the x + 1 row
    cmp eax, 7
    jnb x_is_7

    lea edx, [ecx + 8 * eax + 8]
    
    ; If y is 0 skip modifying the y - 1 col
    cmp ebx, 0
    jng y_is_0_
    mov byte [edx + ebx - 1], 1

y_is_0_:
    ; If y is 7 skip modifying the y + 1 col
    cmp ebx, 7
    jnb y_is_7_
    mov byte [edx + ebx + 1], 1

y_is_7_:

x_is_7:

    ;; FREESTYLE ENDS HERE
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY