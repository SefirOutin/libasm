extern malloc
extern __errno_location

section .text
	global ft_list_push_front

ft_list_push_front:
	push rbp
	mov rbp, rsp
	sub rsp, 8		; align stack (2 pushs, 1 ret addr (call))

	push rdi		; save data
	push rsi
	mov rdi, 16		; sizeof t_list
	call malloc
	pop rsi
	pop rdi
	test rax, rax	; error check
	jz error_syscall

	mov qword [rax], rsi	; list->data
	
	mov r14, [rdi]
	mov qword [rax+8], r14	; list->next

	mov [rdi], rax			; change list head

	leave
	ret

	error_syscall:
		neg rax
		push rax
		call __errno_location
		pop qword [rax]
		xor rax, rax
	
		leave
		ret