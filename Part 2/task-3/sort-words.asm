section .data
	delim db " .,", 0

global get_words
global compare_func
global sort

section .text
    extern strlen
    extern strtok
    extern strcmp
    extern qsort

;; compare_func(const void *A, const void *B)
; Compare function used for qsort
compare_func:
    enter 0, 0

    push ebx
    push ecx
    push edx
    push esi
    push edi

    ; Get parameters and cast to char *
    mov ebx, [ebp + 8] ; char *A
    mov ebx, dword [ebx]
    mov edx, [ebp + 12] ; char *B
    mov edx, dword [edx]

    ; Call strlen(A)
    push eax
    push ebx
    push ecx 
    push edx
    push edi

    push ebx
    call strlen
    add esp, 4
    mov esi, eax

    pop edi 
    pop edx
    pop ecx
    pop ebx
    pop eax

    ; Call strlen(B)
    push eax
    push ebx
    push ecx 
    push edx
    push esi

    push edx
    call strlen
    add esp, 4
    mov edi, eax

    pop esi 
    pop edx
    pop ecx
    pop ebx
    pop eax

    cmp esi, edi
    jle no_first

    ; The first one is longer
    xor eax, eax
    inc eax
    jmp exit_function

no_first:

    jge no_second

    ; The second one is longer
    xor eax, eax
    dec eax
    jmp exit_function

no_second:
    
    ; Then they are equal so do strcmp
    ; Call strcmp(A, B)
	push ebx
	push ecx
	push edx

    push edx
    push ebx
    call strcmp
    add esp, 8

    pop edx
	pop ecx
	pop ebx

exit_function:

    pop edi 
    pop esi
    pop edx
    pop ecx
    pop ebx
    leave
    ret    

;; sort(char **words, int number_of_words, int size)
;  functia va trebui sa apeleze qsort pentru soratrea cuvintelor 
;  dupa lungime si apoi lexicografix
sort:
    enter 0, 0
    pusha

    mov ebx, dword [ebp + 8]
    mov ecx, dword [ebp + 12]
    mov edx, dword [ebp + 16]

    ; Call qsort function
    push compare_func
    push edx
    push ecx
    push ebx
    call qsort
    add esp, 16

    popa
    leave
    ret

;; get_words(char *s, char **words, int number_of_words)
;  separa stringul s in cuvinte si salveaza cuvintele in words
;  number_of_words reprezinta numarul de cuvinte
get_words:
    enter 0, 0
    pusha

    ; Get parameters
    mov ebx, dword [ebp + 8] ; char *s
    mov edx, dword [ebp + 12] ; char **words
    mov ecx, dword [ebp + 16] ; int number_of_words

    ; Call strtok(word, delim)
    push eax
	push ebx
	push ecx
	push edx

    push delim
    push ebx
    call strtok
    add esp, 8
    mov esi, eax

    pop edx
	pop ecx
	pop ebx
	pop eax

    ; Now in esi is the first word
    ; Place it in word
    mov dword [edx], esi

    ; Loop for every word, call strtok, place the result in word
    xor edi, edi 
    inc edi 

loop_label:

    ; Call strtok(NULL, delim)
    push eax
	push ebx
	push ecx
	push edx

    push delim
    push 0
    call strtok
    add esp, 8
    mov esi, eax

    pop edx
	pop ecx
	pop ebx
	pop eax

    ; Place the word in word[edi]
    mov dword [edx + 4 * edi], esi

    inc edi
    cmp ecx, edi 
    ja loop_label

    popa
    leave
    ret
