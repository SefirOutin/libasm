extern malloc
extern ft_strlen
extern __errno_location
extern ft_write

section .text
	global ft_strdup

ft_strdup:
	; prologue
	push rbp
	mov rbp, rsp
	sub rsp, 8

    test rdi, rdi                        ; check if src is NULL
    jz error

	call ft_strlen						; len of src
	inc rax								;  + '\0'

	push rdi							; save src ptr

	mov rdi, rax						; size malloc
	call malloc
	test rax, rax						; error malloc
	jz error_pop

	mov rdi, rax						; put dest ptr in rdi
	pop rsi								; pop src ptr in rsi

	xor rcx, rcx    					; Clear rcx

	ft_strdup_loop:
		mov dl, byte [rsi + rcx]		; cpy src[i] -> dest[i]
		mov byte [rdi + rcx], dl	

		test dl, dl						; if src[i] is null
		jz end_loop

		inc rcx							; increment counter
		jmp ft_strdup_loop

	end_loop:
		mov rax, rdi
		leave
		ret

	error_pop:
    	pop rdi                             ; cleanup stack (src pointer)
		
	error:
		mov rax, -1
		push rax
		call __errno_location
		pop qword [rax]
		xor rax, rax                        ; return NULL
		leave                               ; restore stack frame
		ret

