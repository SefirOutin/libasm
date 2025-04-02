section .text
	global ft_strcpy

ft_strcpy:
	xor rcx, rcx    					; Clear rcx

	ft_strcpy_loop:	
		mov al, [rsi + rcx]
		mov [rdi + rcx], al	

		inc rcx							; increment
		
		cmp byte [rsi + rcx], 0			; check if the current character is null
		je end_loop 					; if null end loop

		jmp ft_strcpy_loop				; return to the start of loop

	end_loop:
		mov rax, rdi
		ret