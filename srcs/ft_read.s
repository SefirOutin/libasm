extern __errno_location

section .text
	global ft_read


ft_read:
	push rbp
	mov rbp, rsp

	xor rax, rax			; syscall read
	syscall

	test rax, rax
	js error_syscall

	leave
	ret

	error_syscall:
		neg rax
		push rax
		call __errno_location
		pop qword [rax]

	error:
		mov rax, -1
		leave
		ret