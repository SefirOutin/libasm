extern ft_strlen

section .text
	global ft_atoi_base

indexInBase:
	xor rax, rax						; clear counter

	IndexInBaseLoop:
		xor rcx, rcx					; clear char buffer
		mov byte cl, [rsi + rax]		; load str[i] in rcx
		test cl, cl						; if null
		jz IndexInBaseLoopNotFound

		cmp cl, dil						; if str[i] == c
		je IndexInBaseLoopEnd
	
		inc rax
		jmp IndexInBaseLoop

	IndexInBaseLoopNotFound:
		mov rax, -1						; error code return
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
		mov dl, [rdi + rax]				; load base[i] in rdx

		test dl, dl						; check '\0' 
		jz endCheckBaseLoop

		cmp dl, 43 						; c == '-'
		je endCheckBaseLoopError
		cmp dl, 45 						; c == '+'
		je endCheckBaseLoopError

		push rax
		push rdi
		push rdx
		mov dil, dl						; arg1 is base[i]
		call ft_iswspace
		cmp rax, 1						; if base[i] is a wspace
		je endCheckBaseLoopErrorAfterCall
		pop rdx
		pop rdi
		pop rax

		mov rcx, rax
		add rcx, 1						; j = i + 1
		checkDoubleCharLoop:
			xor r8b, r8b
			mov r8b, byte [rdi + rcx]	; load base[j]

			test r8b, r8b				; check for null char
			jz continueCheckBaseMainLoop

			cmp dl, byte r8b			; check for dup char
			je endCheckBaseLoopError

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
	mov dl, byte [rdi + rcx]		; load str[i]

	test dl, dl						; check null char
	jz	endSkipWs

	push rdi
	push rcx
	
	mov dil, dl						; arg1 is str[i]
	call ft_iswspace
	
	pop rcx
	pop rdi
	
	test rax, rax					; if not wspace, stop
	jz endSkipWs

	inc rcx
	jmp skipWhiteSpaces

	endSkipWs:
		ret

skipOperators:
	xor al, al
	xor r9b, r9b
	mov dl, byte [rdi + rcx]		; load str[i]

	test dl, dl						; check null char
	jz endSkipOp

	cmp dl, 43						; if '+'
	sete al							; set a flag bit

	cmp dl, 45						; if '-'
	sete r9b						; set a flag bit
	
	or al, r9b						; if none of the above,
	jz endSkipOp					; stop

	bt r9, 0						; if it's '-'
	jc changeSign

	inc rcx
	jmp skipOperators

	changeSign:
		imul rsi, rsi, -1			; change sign

		inc rcx
		jmp skipOperators

	endSkipOp:
		mov rax, rsi

		ret



ft_atoi_base:
	push rbp
	mov rbp, rsp

	sub rsp, 16						; create local 64bit var & stack align
	mov qword [rbp-8], 0			; init var

	test rdi, rdi					; check if str or
	jz error						; base is null
	test rsi, rsi
	jz error

	push rdi						; save input str
	mov rdi, rsi					; move input base as 1st arg
	call checkBase
	test rax, rax					; check for error
	jnz error

	call ft_strlen
	pop rdi
	cmp rax, 2						; check if base len is > 2
	jl error
	mov r8, rax						; save base len in r8

	xor rcx, rcx					; clear counter
	call skipWhiteSpaces			; f(str, base)
	
	push rsi
	mov rsi, 1
	call skipOperators				; f(str, &sign)
	mov r9, rax
	pop rsi

	atoiBaseLoop:
		xor rax, rax
		mov dl, [rdi + rcx]			; load str[i]

		test dl, dl					; check null char
		jz endAtoiBaseLoop

		push rdi
		push rcx
		sub rsp, 8
		xor rdi, rdi
		mov dil, dl
		call indexInBase			; f(str[i], base)
		add rsp, 8
		pop rcx
		pop rdi

		cmp rax, 0					; check if char is in base
		jl endAtoiBaseLoop

		push rax
		mov qword rax, [rbp-8]		; put local var in rax for calc
		imul rax, r8				; nb *= baselen
		mov qword [rbp-8], rax
		pop rax
		add qword [rbp-8], rax		; nb += indexInBase

		inc rcx
		jmp atoiBaseLoop


	endAtoiBaseLoop:
		mov qword rax, [rbp - 8]	; put final nb to rax for output
		imul r9						; apply sign

		add rsp, 16
		leave
		ret

	error:
		xor rax, rax

		add rsp, 16
		leave
		ret

