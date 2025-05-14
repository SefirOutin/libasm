section .text
	global ft_list_push_front

	extern malloc, __errno_location

ft_list_push_front:
	push rbp
	mov rbp, rsp

	push rdi		; save data
	push rsi
	sub rsp, 8		; align stack (3 pushs)
	mov rdi, 16		; sizeof t_list
	call malloc
	add rsp, 8
	pop rsi
	pop rdi
	test rax, rax	; error check
	jz error_syscall

	mov [rax], rsi	; list->data
	
	;test rdi, rdi
	;jz emptyList

	mov rcx, [rdi]
	mov qword [rax+8], rcx	; list->next

	mov [rdi], rax			; change list head

	jmp end

	error_syscall:
		neg rax
		push rax
		call __errno_location
		pop qword [rax]
		xor rax, rax
	end:
		leave
		ret