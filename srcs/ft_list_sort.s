extern ft_list_size

section .text
	global ft_list_sort

ft_list_sort:
	push rbp
	mov rbp, rsp

	push r12
	push r13
	push r14

	sub rsp, 16
	mov [rbp - 8], rdi		; save list head
	mov [rbp - 16], rsi		; save (*cmp)()

	test rdi, rdi			; check args
	jz endSortLoop
	test rsi, rsi
	jz endSortLoop

	listSortLoop:
		mov rdx, [rbp - 8]		; load 1st node
		mov rdx, [rdx]

		xor r12, r12
		xor r14, r14
		secondLoop:
			test rdx, rdx		; check currNode
			jz endSecondLoop

			mov r13, [rdx + 8]	; load nextNode
			test r13, r13		; check netNode
			jz endSecondLoop

			push rcx
			push rdx
			mov rdi, [rdx]		; 1st arg: currNode->data
			mov rsi, [r13]		; 2nd arg: nextNode->data
			call [rbp - 16]		; (*cmp)()
			pop rdx
			pop rcx

			cmp rax, 0			; if data1 > data2
			jg swapNodes

			mov r12, rdx		; update prevNode
			mov rdx, [rdx + 8]	; move to nextNode
			jmp secondLoop

			swapNodes:
				mov rdi, [r13 + 8]		; currNode->next = nextNode->next
				mov [rdx + 8], rdi
				mov [r13 + 8], rdx		; nextNode->next = currNode
				;jmp endSortLoop

				mov rdi, [rbp - 8]
				cmp rdx, [rdi]			; if currNode == headNode
				je swapHead

				mov [r12 + 8], r13		; prevNode->next = nextNode (now currentNode)
				mov r12, r13			; update prevNode
				mov r14, 1				; set swap flag
				;jmp endSortLoop
				jmp secondLoop

				swapHead:
					mov rdi, [rbp - 8]	; load headList
					mov [rdi], r13		; change pointer
					mov r12, r13		; update prevNode
					mov r14, 1			; set swap flag
					jmp secondLoop

		endSecondLoop:
			;jmp endSortLoop
			test r14, r14
			jnz listSortLoop

	endSortLoop:
		pop r14
		pop r13
		pop r12
		leave
		ret