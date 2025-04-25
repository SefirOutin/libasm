extern ft_strlen

section .text
	global indexInBase, ft_iswspace, checkBase

indexInBase:
	xor rax, rax

	IndexInBaseLoop:
		mov byte cl, [rdi + rax]		; load str[i] in rcx
		test cl, cl						; if null
		js IndexInBaseLoopNotFound

		cmp cl, sil						; if str[i] == c
		je IndexInBaseLoopEnd
	
		inc rax
		jmp IndexInBaseLoop

	IndexInBaseLoopNotFound:
		mov rax, -1
	IndexInBaseLoopEnd:
		ret

ft_iswspace:
	xor rcx, rcx
	xor rax, rax
	xor rdx, rdx
	
	cmp dil, 8				; c > 8 set a bit
	seta cl
	cmp dil, 14				; c < 14 set a bit
	setb al
	cmp dil, 32				; c == ' ' set a bit
	sete dl

	and al, cl				; c > 8 && c < 14
	or al, dl				; ( " " ) || c == ' '
	ret


checkBase:
	xor rax, rax
	xor rcx, rcx

	checkBaseMainLoop:
		xor rdx, rdx
		mov dl, [rdi + rax]		; load str[i] in rdx

		test dl, dl				; check '\0' 
		jz endCheckBaseLoop

		cmp dl, 43 				; c == '-'
		je endCheckBaseLoopError
		cmp dl, 45 				; c == '+'
		je endCheckBaseLoopError

		push rax
		push rdi
		push rdx
		mov dil, dl
		call ft_iswspace
		cmp rax, 1				; if str[i] is a wspace
		je endCheckBaseLoopErrorAfterCall
		pop rdx
		pop rdi
		pop rax

		mov rcx, rax
		add rcx, 1
		checkDoubleCharLoop:
			xor r8b, r8b
			mov r8b, byte [rdi + rcx]

			test r8b, r8b
			jz continueMainLoop

			cmp dl, byte r8b
			je endLoopError

			inc rcx
			jmp checkDoubleCharLoop
			
		continueCheckBaseMainLoop:
			inc rax
			jmp checkBaseMainLoop

		endCheckBaseLoopErrorAfterCall:
			pop rdx
			pop rdi
			pop rax
		endCheckBaseLoopError:
			mov rax, 1
			ret
		endCheckBaseLoop:
			xor rax, rax
			ret

skipWhiteSpaces:
	mov dl, byte [rdi + rcx]

	test dl, dl
	jz	endSkip

	push rdi
	push rcx
	
	mov rdi, dl
	call ft_iswspace
	
	pop rcx
	pop rdi
	
	test rax, rax
	jz endSkip

	jmp skipWhiteSpaces

	endSkip:
		ret

skipOperators:
	xor al, al
	xor r9b, r9b
	mov dl, byte [rdi + rcx]

	test dl, dl
	setz al

	cmp dl, 43
	sete r9b
	shl r9b, 1
	or al, r9b

	cmp dl, 45
	sete r9b
	shl r9b, 2
	or al, r9b
	

ft_atoi_base:
	push rbp
	mov rbp, rsp
	
	xor rcx, rcx		; counter
	push rdi			; save input str
	
	mov rdi, rsi		; move input base as 1st arg
	call checkBase
	test rax, rax		; check for error
	jnz error

	call ft_strlen
	pop rdi
	cmp rax, 2			; check if base len is > 2
	jl error
	mov r8, rax			; save base len in r8

	call skipWhiteSpaces

	call skipOperators

	pop rbp
	ret

	endLoop:

	error:
		xor rax, rax

		pop rbp
		ret

