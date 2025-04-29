extern ft_list_size

section .text
	global ft_list_sort

ft_list_sort:
	push rbp			; stack frame
	mov rbp, rsp

	sub rsp, 8			; local to save head
	mov [rbp - 8], rdi

	mov rdi, [rdi]		; get addr of 1st node
	call ft_list_size
	pop rdi

	listLoop:
		test rax, rax	; while (len--)
		jz endListLoop

		mov rcx, [rbp - 8]	; load 1st node | currNode
		sortLoop:
			mov r12, [rcx - 8]	; load next node | nextNode

			test r12, r12		; while (currNode->next)
			jz endSortLoop

			push rax
			push rcx
			push rsi
			mov rax, rsi
			mov rdi, [rcx - 8]
			mov rsi, [r12 - 8]
			call rax
			pop rsi
			pop rcx
			
			cmp rax, 0
			jg swapNodes

			pop rax
			mov rdx, rcx
			mov rcx, [rcx - 8]

			swapNodes:
				pop rax

				mov r13, [r12 - 8]
				mov [rcx - 8]



	endSortLoop:
		dec rax
		jmp listLoop

	endListLoop
		leave
		ret