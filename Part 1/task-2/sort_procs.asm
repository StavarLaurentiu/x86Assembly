struc proc
    .pid: resw 1
    .prio: resb 1
    .time: resw 1
endstruc

section .text
    global sort_procs

sort_procs:
    ;; DO NOT MODIFY
    enter 0,0
    pusha

    mov edx, [ebp + 8]      ; processes
    mov eax, [ebp + 12]     ; length
    ;; DO NOT MODIFY

    ;; Your code starts here

    ; Prepare ebx, ebx, ecx and edx
    mov ecx, -1
    xor ebx, ebx
    sub eax, 1
    sub edx, 5

; Loop with i = 1:len-1 and j = 1:len, ecx = i and ebx = j
; Edi and esi point to 2 processes which are compared by priority,
; time and pid
iter_i:
    add edx, 5
    mov edi, edx
    inc ecx
    mov ebx, ecx
iter_j:
        inc ebx
        add edi, 5

        ; Free eax and ebx
        push eax
        push ebx
        xor eax, eax
        xor ebx, ebx

        ; Acces the priority
        mov al, byte [edx + 2]
        mov bl, byte [edi + 2]
        
        ; Compare the processes and swap if it is the case
        ; Compare priority
        cmp al, bl
        jnge no_swap

        cmp al, bl
        jnz swap

        ; Compare time
        mov ax, word [edx + 3]
        mov bx, word [edi + 3]

        cmp ax, bx
        jnge no_swap

        cmp ax, bx
        jnz swap

        ; Compare PID
        mov ax, word [edx]
        mov bx, word [edi]

        cmp ax, bx
        jng no_swap

swap:
        ; Swap priority
        mov al, byte [edx + 2]
        mov bl, byte [edi + 2]

        mov byte [edi + 2], al
        mov byte [edx + 2], bl

        ; Swap PID
        mov ax, word [edx]
        mov bx, word [edi]

        mov word [edi], ax
        mov word [edx], bx

        ; Swap time
        mov ax, word [edx + 3]
        mov bx, word [edi + 3]

        mov word [edi + 3], ax
        mov word [edx + 3], bx
no_swap:

        ; Get ebx and eax back from stack
        pop ebx
        pop eax

        ; Exit condition for j loop
        cmp eax, ebx
        jg iter_j

    ; Exit condition for i loop
    push eax
    sub eax, 1
    cmp eax, ecx
    pop eax

    jg iter_i

    ;; Your code ends here
    
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY