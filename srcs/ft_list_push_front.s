section .text
	global ft_list_push_front

	extern malloc, __errno_location

ft_list_push_front:
	push rbp
	mov rbp, rsp

	sub rsp, 8		; align stack (3 pushs)

	push rdi		; save data
	push rsi
	mov rdi, 16		; sizeof t_list
	call malloc wrt ..plt
	pop rsi
	pop rdi
	test rax, rax			; error check
	jz error_syscall

	mov [rax], rsi			; list->data

	mov rcx, [rdi]
	mov [rax + 8], rcx		; list->next

	mov [rdi], rax			; change list head

	jmp end

	error_syscall:
		neg rax
		push rax
		call __errno_location wrt ..plt
		pop qword [rax]
		xor rax, rax
	end:
		add rsp, 8
		leave
		ret