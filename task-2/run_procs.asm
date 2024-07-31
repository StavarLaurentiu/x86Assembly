    ;;
    ;;   TODO: Declare 'avg' struct to match its C counterpart
    ;;

struc avg
    .quo: resw 1
    .remain: resw 1
endstruc


struc proc
    .pid: resw 1
    .prio: resb 1
    .time: resw 1
endstruc

    ;; Hint: you can use these global arrays
section .data
    prio_result dd 0, 0, 0, 0, 0
    time_result dd 0, 0, 0, 0, 0

section .text
    global run_procs

run_procs:
    ;; DO NOT MODIFY

    push ebp
    mov ebp, esp
    pusha

    xor ecx, ecx

clean_results:
    mov dword [time_result + 4 * ecx], dword 0
    mov dword [prio_result + 4 * ecx],  0

    inc ecx
    cmp ecx, 5
    jne clean_results

    mov ecx, [ebp + 8]      ; processes
    mov ebx, [ebp + 12]     ; length
    mov eax, [ebp + 16]     ; proc_avg
    ;; DO NOT MODIFY
   
    ;; Your code starts here

    ; Prepare ebx, ecx and edx
    sub ecx, 5
    mov edx, -1
    sub ebx, 1

    ; Loop with i = 1:len
iter_i:
    add ecx, 5
    inc edx

    ; Free eax
    push ebx
    xor ebx, ebx

    ; Increase priority counter
    mov bl, byte [ecx + 2]
    inc dword [prio_result + 4 * ebx - 4]

    ; Increase time counter
    mov edi, ebx
    xor ebx, ebx
    mov bx, word [ecx + 3]
    add dword [time_result + 4 * edi - 4], ebx

    ; Get eax back from stack
    pop ebx

    ; Exit condition for i loop
    cmp ebx, edx
    jg iter_i

    ; Make the div and put the result in avg structure for each priority

    push eax

    ; Priority '1'
    xor eax, eax
    xor ebx, ebx
    xor edx, edx

    mov eax, dword [time_result]
    mov ebx, dword [prio_result]

    ; If the number of apereances is 0
    cmp ebx, 0
    je skip_div_1
    div bx
skip_div_1:

    ; Write the structure for priority 1
    mov ebx, eax
    pop eax
    mov word [eax], bx
    mov ebx, edx
    mov word [eax + 2], bx
    push eax

    ; Priority '2'
    xor eax, eax
    xor ebx, ebx
    xor edx, edx

    mov eax, dword [time_result + 4]
    mov ebx, dword [prio_result + 4]

    ; If the number of apereances is 0
    cmp ebx, 0
    je skip_div_2
    div bx
skip_div_2:

    ; Write the structure for priority 2
    mov ebx, eax
    pop eax
    mov word [eax + 4], bx
    mov ebx, edx
    mov word [eax + 6], bx
    push eax

    ; Priority '3'
    xor eax, eax
    xor ebx, ebx
    xor edx, edx
    
    mov eax, dword [time_result + 8]
    mov ebx, dword [prio_result + 8]

    ; If the number of apereances is 0
    cmp ebx, 0
    je skip_div_3
    div bx
skip_div_3:

    ; Write the structure for priority 3
    mov ebx, eax
    pop eax
    mov word [eax + 8], bx
    mov ebx, edx
    mov word [eax + 10], bx
    push eax

    ; Priority '4'
    xor eax, eax
    xor ebx, ebx
    xor edx, edx

    mov eax, dword [time_result + 12]
    mov ebx, dword [prio_result + 12]

    ; If the number of apereances is 0
    cmp ebx, 0
    je skip_div_4
    div bx
skip_div_4:

    ; Write the structure for priority 4
    mov ebx, eax
    pop eax
    mov word [eax + 12], bx
    mov ebx, edx
    mov word [eax + 14], bx
    push eax

    ; Priority '5'
    xor eax, eax
    xor ebx, ebx
    xor edx, edx

    mov eax, dword [time_result + 16]
    mov ebx, dword [prio_result + 16]

    ; If the number of apereances is 0
    cmp ebx, 0
    je skip_div_5
    div bx
skip_div_5:

    ; Write the structure for priority 5
    mov ebx, eax
    pop eax
    mov word [eax + 16], bx
    mov ebx, edx
    mov word [eax + 18], bx
    push eax

    pop eax

    ;; Your code ends here
    
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY