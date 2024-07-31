section .data
	back db "..", 0
	curr db ".", 0
	slash db "/", 0
	; declare global vars here

section .text
	global pwd
	extern strcat
	extern strcmp
	extern strlen

;;	void pwd(char **directories, int n, char *output)
;	Adauga in parametrul output path-ul rezultat din
;	parcurgerea celor n foldere din directories
pwd:
	enter 0, 0
	pusha
	mov ebx, dword[ebp + 8] ; char **directories
	mov ecx, dword[ebp + 12] ; int n
	mov edx, dword[ebp + 16] ; char *output

	xor edi, edi
loop_label:

	; Put in eax the current string
	mov eax, dword[ebx + 4 * edi]

	; Do strcmp(eax, back)
	push eax
	push ebx
	push ecx
	push edx

	push eax
	push back
	call strcmp
	add esp, 8
	mov esi, eax

	pop edx
	pop ecx
	pop ebx
	pop eax

	; If the result of strcmp is 0 do ".." command
	cmp esi, 0
	jnz no_back

	; Do strlen(edx) and keep the result in esi
	push eax
	push ebx
	push ecx
	push edx

	push edx
	call strlen
	add esp, 4
	mov esi, eax

	pop edx
	pop ecx
	pop ebx
	pop eax

	; If the string is empty just jump to the next command
	cmp esi, 0
	jz final_label

	; Loop back from the last character in the string until
	; I found '\' and replace that caracter with NULL
	dec esi
loop_back:

	; See if the current character is '\'
	cmp byte [edx + esi], 47
	jnz not_found

	; If it is change it with NULL and jump to the next command
	mov byte [edx + esi], 0
	jmp final_label

not_found:
	dec esi
	cmp esi, 0
	ja loop_back

	; In this case the string will become empty
	mov byte [edx], 0
	jmp final_label

no_back:

	; Do strcmp(eax, curr)
	push eax
	push ebx
	push ecx
	push edx

	push eax
	push curr
	call strcmp
	add esp, 8
	mov esi, eax

	pop edx
	pop ecx
	pop ebx
	pop eax

	; If the result of strcmp is 0 do "." command
	cmp esi, 0
	jnz no_curr

	; Jump to the next command
	jmp final_label

no_curr:

	; Then add the string to the path

	; Do strcat(output, slash)
	push eax
	push ebx
	push ecx
	push edx

	push slash
	push edx
	call strcat
	add esp, 8

	pop edx
	pop ecx
	pop ebx
	pop eax

	; Do strcat(output, current_word)
	push eax
	push ebx
	push ecx
	push edx

	push eax
	push edx
	call strcat
	add esp, 8

	pop edx
	pop ecx
	pop ebx
	pop eax

final_label:

	inc edi
	cmp ecx, edi 
	ja loop_label

	; Place the last '\'
	; Do strcat(output, slash)
	push eax
	push ebx
	push ecx
	push edx

	push slash
	push edx
	call strcat
	add esp, 8

	pop edx
	pop ecx
	pop ebx
	pop eax

	popa
	leave
	ret