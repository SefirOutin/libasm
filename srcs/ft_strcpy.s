extern ft_strlen

section .text
	global ft_strcpy

ft_strcpy:
	push rbp
	mov rbp, rsp

	push rdi			; save dest ptr
	mov rdi, rsi		; 1st arg: src 
	call ft_strlen
	mov rcx, rax		; move len to count reg
	mov rsi, rdi
	pop rdi

	push rdi			; save rdi, it will be incremented
	rep movsb			; move rcx bytes from src to dest
	mov byte [rdi], 0	; '\0'
	pop rax

	strcpyEnd:
		leave
		ret