section .text
	global ft_strlen

ft_strlen:
	xor rax, rax    			; Clear rax

	ft_strlen_loop:		
		cmp byte [rdi + rax], 0		; check if the current character is null
		je end_loop 				; if null end loop

		inc rax						; increment
		jmp ft_strlen_loop			; return to the start of loop

	end_loop:
		ret
