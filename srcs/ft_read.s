section .text
	global ft_read

	extern __errno_location

ft_read:
	push rbp
	mov rbp, rsp

	sub rsp, 8
	xor rax, rax			; syscall read
	syscall
	add rsp, 8

	test rax, rax
	js error_syscall

	leave
	ret

	error_syscall:
		neg rax
		push rax
		call __errno_location wrt ..plt
		pop qword [rax]

	error:
		mov rax, -1
		leave
		ret