section .text
	global ft_write

	extern __errno_location

ft_write:
	push rbp
	mov rbp, rsp

	sub rsp, 8

	test rsi, rsi
	jz writeError
	
	mov rax, 1			; syscall write
	syscall

	test rax, rax
	js writeErrorSyscall

	add rsp, 8
	leave
	ret

	writeErrorSyscall:
		neg rax
		push rax
		call __errno_location wrt ..plt
		pop qword [rax]
		jmp skipErrno
	writeError:
		mov rax, 22
		push rax
		call __errno_location wrt ..plt
		pop qword [rax]
	skipErrno:
		mov rax, -1
		add rsp, 8
		leave
		ret
	
