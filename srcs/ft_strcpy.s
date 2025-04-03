section .text
	global ft_strcpy

ft_strcpy:
	xor rcx, rcx    					; Clear rcx

	ft_strcpy_loop:	
		mov al, [rsi + rcx]				; cpy src[i] -> dest[i]
		mov [rdi + rcx], al	

		inc rcx							; increment counter
		
		cmp byte [rsi + rcx], 0			; check if the current character in src is null
		je end_loop 					; if null end loop

		jmp ft_strcpy_loop

	end_loop:
		mov rax, rdi
		ret