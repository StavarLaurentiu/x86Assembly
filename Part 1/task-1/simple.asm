%include "../include/io.mac"

section .text
    global simple
    extern printf

simple:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     ecx, [ebp + 8]  ; len
    mov     esi, [ebp + 12] ; plain
    mov     edi, [ebp + 16] ; enc_string
    mov     edx, [ebp + 20] ; step

    ;; DO NOT MODIFY
   
    ;; Your code starts here

    ; Make sure eax is empty
    xor eax, eax

    ; Loop
label:  
    ; Move in al an character from "plain"
    mov al, byte [esi + ecx - 1]

    ; Increment the character by "step"
    add al, dl
    
    ; If the new character is greater than 'Z'
    ; then subtract 26 from it in order to keep
    ; the number in 'A' - 'Z' range
    cmp al, 91
    jb continue
    sub al, 26
continue:

    ; Move the new character in "enc_string"
    mov byte [edi + ecx - 1], al
    loop label

    ;; Your code ends here
    
    ;; DO NOT MODIFY

    popa
    leave
    ret
    
    ;; DO NOT MODIFY
