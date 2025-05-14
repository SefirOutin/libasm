section .text
	global ft_list_remove_if

	extern free

ft_list_remove_if:
	push rbp
	mov rbp, rsp

	push rbx
	push r12
	push r13

	sub rsp, 32

	; check args
	test rdi, rdi					
	jz end
	test rsi, rsi
	jz end
	test rdx, rdx
	jz end
	test rcx, rcx
	jz end

	; save args
	mov [rbp - 8], rdi				; headlist
	mov [rbp - 16], rsi				; data_ref
	mov [rbp - 24], rdx				; (*cmp)
	mov [rbp - 32], rcx				; (*free_fct)

	mov r12, [rbp - 8]				; load header addr
	mov r12, [r12]					; load 1st node
	xor r13, r13					; prevNode

	listRemoveIfLoop:
		test r12, r12
		jz end

		mov rdi, [r12]				; 1st arg: currNode->data
		mov rsi, [rbp - 16]			; 2nd arg: data_ref
		call [rbp - 24]				; (*cmp)()

		test rax, rax
		jz deleteNode

		mov r13, r12					; prevNode = currNode
		mov r12, [r12 + 8]				; move to next node
		jmp listRemoveIfLoop

		deleteNode:
			mov rbx, [r12 + 8]			; load next node
			
			mov rdi, [r12]				; 1st arg: currNode->data
			call [rbp - 32]				; (*free_fct)()

			test r13, r13				; if no prevNode
			je deleteHead

			mov [r13 + 8], rbx			; update prevNode->next

			jmp freeAndMove

			deleteHead:
				mov rdi, [rbp - 8]		; load head addr
				mov [rdi], rbx			; update list head with nextNode
			freeAndMove:
				mov rdi, r12			; 1st arg: currNode
				call free
				
				mov r12, rbx			; update currNode to nextNode

				jmp listRemoveIfLoop

end:
	add rsp, 32
	pop r13
	pop r12
	pop rbx
	leave
	ret
	