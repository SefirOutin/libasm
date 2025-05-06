section .text
	global ft_list_remove_if

ft_list_remove_if:
	push rbp
	mov rbp, rsp

	push r12
	push r13
	sub rsp, 40

	test rdi, rdi			; check args
	jz end
	test rsi, rsi
	jz end
	test rdx, rdx
	jz end
	test rcx, rcx
	jz end

	mov [rbp - 8], rdi		; save args
	mov [rbp - 16], rsi
	mov [rbp - 24], rdx
	mov [rbp - 32], rcx


	mov r12, [rbp - 8]		; load 1st node
	mov r12, [r12]

	listRemoveIfLoop:
		test r12, r12
		jz end

		mov rdi, [r12]				; 1st arg: currNode->data
		mov rsi, [rbp - 16]			; 2nd arg: data_ref
		call [rbp - 24]				; (*cmp)( " " , data_ref)

		test rax, rax
		jz deleteNode

		mov r13, r12				; prevNode = currNode
		mov r12, [r12 + 8]			; move to next node
		jmp listRemoveIfLoop

		deleteNode:
			mov rdi, [r12]			; 1st arg: currNode->data
			call [rbp - 32]			; (*free_fct)()

			mov rax, [r12 + 8]		; load next node
			mov rdi, [rbp - 8]		; load list head
			cmp r12, [rdi]			; if currNode == headNode
			je deleteHead

			mov [r13 + 8], rax		; update prevNode->next

			mov rdi, r12			; 1st arg: currNode
			call [rbp - 32]			; (*free_fct)()
			
			mov r12, [r13 + 8]		; currNode = nextNode
			jmp listRemoveIfLoop

			deleteHead:
				mov [rdi], rax		; update list head

				mov rdi, r12		; 1st arg: currNode
				mov r12, rax
				call [rbp - 32]		; (*free_fct)()
				
				;mov rax, [rbp - 8]

				jmp listRemoveIfLoop

end:
	add rsp, 40
	pop r13
	pop r12
	leave
	ret
	