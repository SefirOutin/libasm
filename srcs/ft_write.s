extern __errno_location

section .text
	global ft_write


ft_write:
	push rbp
	mov rbp, rsp

	mov rax, 1			; syscall write
	syscall

	test rax, rax
	js error

	leave
	ret

	error:
		neg rax
		push rax
		call __errno_location
		pop qword [rax]
		mov rax, -1
		leave
		ret
	
