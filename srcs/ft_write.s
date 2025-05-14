section .text
	global ft_write

	extern __errno_location

ft_write:
	push rbp
	mov rbp, rsp

	cmp rdx, 0			; test if len is neg
	jl	writeError

	sub rsp, 8
	mov rax, 1			; syscall write
	syscall
	add rsp, 8
	

	test rax, rax
	js writeErrorSyscall

	leave
	ret

	writeErrorSyscall:
		neg rax
		push rax
		call __errno_location
		pop qword [rax]
	writeError:
		mov rax, -1
		leave
		ret
	
