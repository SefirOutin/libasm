section .text
	global ft_list_size

ft_list_size:
	xor rax, rax

	listSizeloop:
		test rdi, rdi
		jz endLoop

		inc rax
		mov rdi, [rdi + 8]

		jmp listSizeloop

	endLoop:
		ret