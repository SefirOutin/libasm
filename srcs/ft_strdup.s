extern ft_strlen, ft_write, ft_strcpy

section .text
	global ft_strdup
	
	extern malloc, __errno_location

ft_strdup:
	; prologue
	push rbp
	mov rbp, rsp

	sub rsp, 8
	call ft_strlen						; len of src
	inc rax								;  + '\0'
	add rsp, 8

	push rdi							; save src ptr
	mov rdi, rax						; size malloc
	call malloc
	pop rsi								; pop src ptr in rsi
	test rax, rax						; error malloc
	jz strdupError

	mov rdi, rax						; put dest ptr in rdi
	call ft_strcpy

	jmp strdupEnd

	strdupError:
		mov rax, -1
		push rax
		call __errno_location
		pop qword [rax]
		xor rax, rax                        ; return NULL
	strdupEnd:
		leave                               ; restore stack frame
		ret