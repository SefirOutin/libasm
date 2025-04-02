section .text
	global ft_strcmp

ft_strcmp:
	xor rcx, rcx    					; Clear rcx

	ft_strcmp_loop:
		mov al, byte [rdi + rcx]
		mov dl, byte [rsi + rcx]

		cmp al, 0						; check if end of s1
		je end_loop
		cmp dl, 0						; check if end of s2
		je end_loop

		cmp al, dl						; check if characters matches
		jne end_loop

		inc rcx							; increment counter
		jmp ft_strcmp_loop

	end_loop:
   		movzx rax, al                 ; zero extend al to rax
    	movzx rdx, dl                 ; zero extend dl to rdx
    	sub eax, edx                  ; compute difference using 32-bit registers
		ret