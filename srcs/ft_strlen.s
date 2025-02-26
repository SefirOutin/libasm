section .data
	message db "Hell", 0
	ended db "ended", 10, 0
	buf db 0

section .text
	global _start

; putchar:
; 	mov rax, 1
; 	mov rdi, 1
; 	mov rsi, rdi + rax


end_loop:
	ret

ft_strlen_loop:
	cmp byte [rsi + rax], 0

	je end_loop

	inc rax
	jmp ft_strlen_loop

ft_strlen:
	xor rax, rax    ; Clear rax

	call ft_strlen_loop
	ret

_start:
	
	mov rsi, message
	call ft_strlen

	mov rbx, rax
	add rbx, 48
	mov [buf], bl


	mov rax, 1			; write syscall
	mov rdi, 1			; stdout
	lea rsi, [buf]
	mov rdx, 1
	syscall

	mov rax, 60
	xor rdi, rdi
	syscall
