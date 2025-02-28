section .data
	message db "Hell", 0
	ended db "ended", 10, 0
	buf db 0

section .text
	global _start

putchar:
	push rbp
	mov rbp, rsp

	sub rsp , 1
	mov [rsp - 1], rdi
	; mov rsi, rdi

	mov rax, 1			; write syscall
	mov rdi, 1			; stdout
	lea rsi, [rsp - 1]
	mov rdx, 1			; length of the string
	syscall

	add rsp, 1
	pop rbp
	ret



ft_strlen:
	push rbp
	mov rbp, rsp
	push rbx
	sub rsp, 8

	xor rbx, rbx    ; Clear rbx

	call ft_strlen_loop


	mov rax, rbx
	ret

	ft_strlen_loop:
		; mov rdi, [rbp + 16]		; get pointer of the string 
		
		cmp byte [rdi + rbx], 0		; check if the current character is null
		je end_loop 

		push rdi
		mov rdi, [rdi + rbx]	; pass the current character
		call putchar

		pop rdi
		inc rbx
		jmp ft_strlen_loop

	end_loop:
		add rsp, 16
		pop rbx
		pop rbp
		ret
_start:
	push rbp
	mov rbp, rsp

	sub rsp, 8
	mov rdi, message
	call ft_strlen

	add rax, 48
	mov [buf], al


	mov rdi, 32
	call putchar

	mov rax, 1			; write syscall
	mov rdi, 1			; stdout
	lea rsi, [buf]
	mov rdx, 1
	syscall

	add rsp, 8
	pop rbp

	mov rax, 60
	xor rdi, rdi
	syscall
