extern ft_list_size

section .text
	global ft_list_sort

ft_list_sort:
	push rbp
	mov rbp, rsp

	sub rsp, 16
	push r12
	push r13
	push r14

	mov [rbp - 8], rdi					; save list head
	mov [rbp - 16], rsi					; save (*cmp)()

	test rdi, rdi						; check args
	jz endSortLoop
	test rsi, rsi
	jz endSortLoop

	listSortLoop:
		mov rdx, [rbp - 8]				; load 1st node
		mov rdx, [rdx]

		xor r13, r13
		xor r12, r12
		secondLoop:
			test rdx, rdx				; check currNode
			jz endSecondLoop

			mov r14, [rdx + 8]			; load nextNode
			test r14, r14					; check nextNode
			jz endSecondLoop

			push rcx
			push rdx
			mov rdi, [rdx]				; 1st arg: currNode->data
			mov rsi, [r14]				; 2nd arg: nextNode->data
			call [rbp - 16]				; (*cmp)()
			pop rdx
			pop rcx

			cmp rax, 0					; if data1 > data2
			jg swapNodes

			mov r13, rdx				; update prevNode
			mov rdx, [rdx + 8]			; move to nextNode
			jmp secondLoop

			swapNodes:
				mov rdi, [r14 + 8]		; currNode->next = nextNode->next
				mov [rdx + 8], rdi
				mov [r14 + 8], rdx		; nextNode->next = currNode
				;jmp endSortLoop

				mov rdi, [rbp - 8]
				cmp rdx, [rdi]			; if currNode == headNode
				je swapHead

				mov [r13 + 8], r14		; prevNode->next = nextNode (now currentNode)
				mov r13, r14			; update prevNode
				mov r12, 1				; set swap flag
				;jmp endSortLoop
				jmp secondLoop

				swapHead:
					mov rdi, [rbp - 8]	; load headList
					mov [rdi], r14		; change pointer
					mov r13, r14		; update prevNode
					mov r12, 1			; set swap flag
					jmp secondLoop

		endSecondLoop:
			;jmp endSortLoop
			test r12, r12
			jnz listSortLoop

	endSortLoop:
		pop r14
		pop r13
		pop r12
		add rsp, 16
		leave
		ret