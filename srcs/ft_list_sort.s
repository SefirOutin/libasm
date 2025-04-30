extern ft_list_size

section .text
	global ft_list_sort

ft_list_sort:
	push rbp					; stack frame
	mov rbp, rsp
	push r14
	push r15

	sub rsp, 16					; local vars to save head and (*cmp)()
	mov qword [rbp - 8], rdi
	mov qword [rbp - 16], rsi

	mov qword rdi, [rdi]		; get addr of 1st node
	call ft_list_size
	dec rax

	listLoop:
		test rax, rax	; while (len--)
		jz endListLoop

		mov rcx, [rbp - 8]		; load 1st node | currNode
		mov rcx, [rcx]
		xor rdx, rdx			; load prevNode
		sortLoop:
			test rcx, rcx
			jz endSortLoop

			mov r14, [rcx + 8]	; load currNode->next | nextNode
			test r14, r14		; while (currNode->next)
			jz endSortLoop

			push rax
			push rcx
			push rdx
			;sub rsp, 8
			mov rax, [rbp - 16]
			mov rdi, [rcx]		; 1st arg: currNode->data
			mov rsi, [r14]		; 2nd arg: tmpNode->data
			call rax			; call (*cmp)()
			;add rsp, 8
			pop rdx
			pop rcx
			
			cmp rax, 0			; return of cmp()
			jg swapNodes

			pop rax
			mov rdx, rcx		; prevNode = currNode
			mov rcx, [rcx + 8]	; currNode = currNode->next

			swapNodes:
				pop rax
				
				mov r15, [r14 +  8]	; load tmpNode->next
				mov [rcx + 8], r15	; currNode->next = tmpNode->next
				mov [r14 + 8], rcx	; tmpNode->next = currNode

				mov rdi, [rbp - 8]
				cmp rcx, [rdi]	; if currNode == *begin_list
				je swapHead

				mov [rdx + 8], r14	; prevNode->next = tmpNode
				mov rdx, r14
				jmp sortLoop

				swapHead:
					mov rdi, [rbp - 8]
					mov [rdi], r14	; *begin_list = tmpNode
					mov rdx, r14
					jmp sortLoop

	endSortLoop:
		dec rax
		jmp listLoop

	endListLoop:
		add rsp, 16
		pop r15
		pop r14
		leave
		ret