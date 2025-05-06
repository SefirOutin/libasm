section .text
	global ft_strcmp

ft_strcmp:
	push rbp
	mov rbp, rsp
	xor rcx, rcx    					; Clear rcx

	ft_strcmp_loop:
		movzx eax, byte [rdi + rcx]		; load and zero extend byte from s1
    	movzx edx, byte [rsi + rcx]		; load and zero extend byte from s2

		cmp eax, 0						; check if end of s1
		je end_loop
		cmp edx, 0						; check if end of s2
		je end_loop

		cmp eax, edx					; check if characters matches
		jne end_loop

		inc rcx							; increment counter
		jmp ft_strcmp_loop

	end_loop:
    	sub eax, edx					; compute difference using 32-bit registers
		movsxd rax, eax					; sign-extend in rax

		leave
		ret