section .text
	global ft_list_remove_if

	extern free

ft_list_remove_if:
	push rbp
	mov rbp, rsp

	sub rsp, 32
	push rbx
	push r12
	push r13

	; check args
	test rdi, rdi					; &head
	jz end
	test rsi, rsi					; data_ref
	jz end
	test rdx, rdx					; (*cmp)
	jz end
	test rcx, rcx					; (*free_fct)
	jz end

	; save args
	mov [rbp - 8], rdi				; &head
	mov [rbp - 16], rsi				; data_ref
	mov [rbp - 24], rdx				; (*cmp)
	mov [rbp - 32], rcx				; (*free_fct)

	mov r12, [rbp - 8]				; load head addr

	mov r12, [r12]					; load 1st node
	xor r13, r13					; prevNode

	listRemoveIfLoop:
		test r12, r12				; currNode
		jz end

		mov rdi, [r12]				; 1st arg: currNode->data
		mov rsi, [rbp - 16]			; 2nd arg: data_ref
		call [rbp - 24]				; (*cmp) ()

		test rax, rax				; data != data_ref
		jnz moveToNextNode

		; delete node
		mov rdi, [r12]				; 1st arg: currNode->data
		call [rbp - 32]				; (*free_fct) ()

		mov rdi, [r12 + 8]			; load currNode->next
		
		test r13, r13				; if prevNode
		jnz	deleteAfterFirst

		; delete head node
		mov rbx, [rbp - 8]			; load head addr
		mov [rbx], rdi				; update head list

		mov rdi, r12				; 1st arg: currNode
		call free wrt ..plt

		mov r12, [rbx]				; move to new head
		jmp listRemoveIfLoop
		
		deleteAfterFirst:
			mov [r13 + 8], rdi		; prevNode->next = nextNode

			mov rdi, r12			; 1st arg: currNode
			call free wrt ..plt

			mov r12, r13			; update currNode to prevNode
		moveToNextNode:
			mov r13, r12			; update prevNode with currNode
			mov r12, [r12 + 8]		; move to next node

			jmp listRemoveIfLoop

end:
	pop r13
	pop r12
	pop rbx
	add rsp, 32
	leave
	ret
	