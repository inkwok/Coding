	.file	"main.c"
	.intel_syntax noprefix
	.text
	.globl	FILE_EXTENSION
	.section	.rodata
.LC0:
	.string	".bf"
	.section	.data.rel.local,"aw"
	.align 8
	.type	FILE_EXTENSION, @object
	.size	FILE_EXTENSION, 8
FILE_EXTENSION:
	.quad	.LC0
	.globl	DIE_TEXT
	.section	.rodata
	.align 8
.LC1:
	.string	"Usage: %s [FILE]... [OPTIONS]...\nExecutes brainfuck programs.\n"
	.section	.data.rel.local
	.align 8
	.type	DIE_TEXT, @object
	.size	DIE_TEXT, 8
DIE_TEXT:
	.quad	.LC1
	.globl	DBG_TEXT
	.section	.rodata
	.align 8
.LC2:
	.string	"\n\033[1;32mMemory size: %lu KiB\033[0m\n"
	.section	.data.rel.local
	.align 8
	.type	DBG_TEXT, @object
	.size	DBG_TEXT, 8
DBG_TEXT:
	.quad	.LC2
	.globl	FDBG_TEXT
	.section	.rodata
	.align 8
.LC3:
	.string	"\033[1;32mMemory size: %lu KiB\033[0m\n"
	.section	.data.rel.local
	.align 8
	.type	FDBG_TEXT, @object
	.size	FDBG_TEXT, 8
FDBG_TEXT:
	.quad	.LC3
	.text
	.type	die_usage, @function
die_usage:
.LFB6:
	.cfi_startproc
	endbr64
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	sub	rsp, 16
	mov	QWORD PTR -8[rbp], rdi
	mov	rcx, QWORD PTR DIE_TEXT[rip]
	mov	rax, QWORD PTR stderr[rip]
	mov	rdx, QWORD PTR -8[rbp]
	mov	rsi, rcx
	mov	rdi, rax
	mov	eax, 0
	call	fprintf@PLT
	mov	edi, 0
	call	exit@PLT
	.cfi_endproc
.LFE6:
	.size	die_usage, .-die_usage
	.type	is_brainfuck, @function
is_brainfuck:
.LFB7:
	.cfi_startproc
	endbr64
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	sub	rsp, 32
	mov	QWORD PTR -24[rbp], rdi
	mov	rax, QWORD PTR -24[rbp]
	mov	esi, 46
	mov	rdi, rax
	call	strrchr@PLT
	mov	QWORD PTR -8[rbp], rax
	cmp	QWORD PTR -8[rbp], 0
	jne	.L3
	mov	eax, 1
	jmp	.L4
.L3:
	mov	rcx, QWORD PTR FILE_EXTENSION[rip]
	mov	rax, QWORD PTR -8[rbp]
	mov	edx, 2
	mov	rsi, rcx
	mov	rdi, rax
	call	strncmp@PLT
.L4:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE7:
	.size	is_brainfuck, .-is_brainfuck
	.type	ensure_size, @function
ensure_size:
.LFB8:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	sub	rsp, 48
	mov	QWORD PTR -24[rbp], rdi
	mov	QWORD PTR -32[rbp], rsi
	mov	QWORD PTR -40[rbp], rdx
	mov	eax, ecx
	mov	BYTE PTR -44[rbp], al
	cmp	QWORD PTR -24[rbp], 0
	je	.L6
	mov	rax, QWORD PTR -24[rbp]
	mov	rax, QWORD PTR 16[rax]
	lea	rdx, [rax+rax]
	mov	rax, QWORD PTR -24[rbp]
	mov	QWORD PTR 16[rax], rdx
	mov	rax, QWORD PTR -24[rbp]
	mov	rax, QWORD PTR 16[rax]
	lea	rdx, 0[0+rax*8]
	mov	rax, QWORD PTR -24[rbp]
	mov	rax, QWORD PTR [rax]
	mov	rsi, rdx
	mov	rdi, rax
	call	realloc@PLT
	mov	rdx, QWORD PTR -24[rbp]
	mov	QWORD PTR [rdx], rax
	mov	rax, QWORD PTR -24[rbp]
	mov	rax, QWORD PTR [rax]
	test	rax, rax
	jne	.L6
	mov	eax, 1
	jmp	.L7
.L6:
	cmp	QWORD PTR -32[rbp], 0
	je	.L8
	mov	rax, QWORD PTR -32[rbp]
	mov	rax, QWORD PTR 16[rax]
	lea	rdx, [rax+rax]
	mov	rax, QWORD PTR -32[rbp]
	mov	QWORD PTR 16[rax], rdx
	mov	rax, QWORD PTR -32[rbp]
	mov	rax, QWORD PTR 16[rax]
	lea	rdx, 0[0+rax*4]
	mov	rax, QWORD PTR -32[rbp]
	mov	rax, QWORD PTR [rax]
	mov	rsi, rdx
	mov	rdi, rax
	call	realloc@PLT
	mov	rdx, QWORD PTR -32[rbp]
	mov	QWORD PTR [rdx], rax
	mov	rax, QWORD PTR -32[rbp]
	mov	rax, QWORD PTR [rax]
	test	rax, rax
	jne	.L8
	mov	eax, 1
	jmp	.L7
.L8:
	cmp	QWORD PTR -40[rbp], 0
	je	.L9
	mov	rax, QWORD PTR -40[rbp]
	mov	rax, QWORD PTR 16[rax]
	lea	rdx, [rax+rax]
	mov	rax, QWORD PTR -40[rbp]
	mov	QWORD PTR 16[rax], rdx
	mov	rax, QWORD PTR -40[rbp]
	mov	rax, QWORD PTR 16[rax]
	lea	rdx, 0[0+rax*4]
	mov	rax, QWORD PTR -40[rbp]
	mov	rax, QWORD PTR [rax]
	mov	rsi, rdx
	mov	rdi, rax
	call	realloc@PLT
	mov	rdx, QWORD PTR -40[rbp]
	mov	QWORD PTR [rdx], rax
	mov	rax, QWORD PTR -40[rbp]
	mov	rax, QWORD PTR [rax]
	test	rax, rax
	jne	.L10
	mov	eax, 1
	jmp	.L7
.L10:
	mov	rax, QWORD PTR -40[rbp]
	mov	rax, QWORD PTR 8[rax]
	mov	QWORD PTR -8[rbp], rax
	jmp	.L11
.L12:
	mov	rax, QWORD PTR -40[rbp]
	mov	rax, QWORD PTR [rax]
	mov	rdx, QWORD PTR -8[rbp]
	sal	rdx, 2
	add	rax, rdx
	mov	DWORD PTR [rax], 0
	add	QWORD PTR -8[rbp], 1
.L11:
	mov	rax, QWORD PTR -40[rbp]
	mov	rax, QWORD PTR 16[rax]
	cmp	QWORD PTR -8[rbp], rax
	jb	.L12
	cmp	BYTE PTR -44[rbp], 0
	je	.L9
	mov	rax, QWORD PTR -40[rbp]
	mov	rax, QWORD PTR 16[rax]
	sal	rax, 2
	shr	rax, 10
	mov	rdx, rax
	mov	rax, QWORD PTR DBG_TEXT[rip]
	mov	rsi, rdx
	mov	rdi, rax
	mov	eax, 0
	call	printf@PLT
.L9:
	mov	eax, 0
.L7:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE8:
	.size	ensure_size, .-ensure_size
	.section	.rodata
.LC4:
	.string	"%u"
	.text
	.type	interpret, @function
interpret:
.LFB9:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	sub	rsp, 48
	mov	QWORD PTR -24[rbp], rdi
	mov	QWORD PTR -32[rbp], rsi
	mov	eax, edx
	mov	BYTE PTR -36[rbp], al
	mov	DWORD PTR -4[rbp], 0
	mov	rax, QWORD PTR -24[rbp]
	mov	rdx, QWORD PTR [rax]
	mov	rax, QWORD PTR -24[rbp]
	mov	rax, QWORD PTR 8[rax]
	sal	rax, 3
	add	rax, rdx
	mov	eax, DWORD PTR [rax]
	cmp	eax, 8
	ja	.L14
	mov	eax, eax
	lea	rdx, 0[0+rax*4]
	lea	rax, .L16[rip]
	mov	eax, DWORD PTR [rdx+rax]
	cdqe
	lea	rdx, .L16[rip]
	add	rax, rdx
	notrack jmp	rax
	.section	.rodata
	.align 4
	.align 4
.L16:
	.long	.L14-.L16
	.long	.L23-.L16
	.long	.L22-.L16
	.long	.L21-.L16
	.long	.L20-.L16
	.long	.L19-.L16
	.long	.L18-.L16
	.long	.L17-.L16
	.long	.L15-.L16
	.text
.L23:
	mov	rax, QWORD PTR -32[rbp]
	mov	rdx, QWORD PTR [rax]
	mov	rax, QWORD PTR -32[rbp]
	mov	rax, QWORD PTR 8[rax]
	sal	rax, 2
	add	rax, rdx
	mov	rsi, rax
	lea	rax, .LC4[rip]
	mov	rdi, rax
	mov	eax, 0
	call	__isoc99_scanf@PLT
	mov	DWORD PTR -4[rbp], eax
	jmp	.L24
.L22:
	mov	rax, QWORD PTR -32[rbp]
	mov	rdx, QWORD PTR [rax]
	mov	rax, QWORD PTR -32[rbp]
	mov	rax, QWORD PTR 8[rax]
	sal	rax, 2
	add	rax, rdx
	mov	eax, DWORD PTR [rax]
	mov	edi, eax
	call	putchar@PLT
	jmp	.L24
.L21:
	mov	rax, QWORD PTR -32[rbp]
	mov	rdx, QWORD PTR [rax]
	mov	rax, QWORD PTR -32[rbp]
	mov	rax, QWORD PTR 8[rax]
	sal	rax, 2
	add	rax, rdx
	mov	edx, DWORD PTR [rax]
	add	edx, 1
	mov	DWORD PTR [rax], edx
	jmp	.L24
.L20:
	mov	rax, QWORD PTR -32[rbp]
	mov	rdx, QWORD PTR [rax]
	mov	rax, QWORD PTR -32[rbp]
	mov	rax, QWORD PTR 8[rax]
	sal	rax, 2
	add	rax, rdx
	mov	edx, DWORD PTR [rax]
	sub	edx, 1
	mov	DWORD PTR [rax], edx
	jmp	.L24
.L18:
	mov	rax, QWORD PTR -32[rbp]
	mov	rax, QWORD PTR 8[rax]
	lea	rdx, 1[rax]
	mov	rax, QWORD PTR -32[rbp]
	mov	QWORD PTR 8[rax], rdx
	jmp	.L24
.L19:
	mov	rax, QWORD PTR -32[rbp]
	mov	rax, QWORD PTR 8[rax]
	lea	rdx, -1[rax]
	mov	rax, QWORD PTR -32[rbp]
	mov	QWORD PTR 8[rax], rdx
	jmp	.L24
.L17:
	mov	rax, QWORD PTR -32[rbp]
	mov	rdx, QWORD PTR [rax]
	mov	rax, QWORD PTR -32[rbp]
	mov	rax, QWORD PTR 8[rax]
	sal	rax, 2
	add	rax, rdx
	mov	eax, DWORD PTR [rax]
	test	eax, eax
	jne	.L31
	mov	rax, QWORD PTR -24[rbp]
	mov	rdx, QWORD PTR [rax]
	mov	rax, QWORD PTR -24[rbp]
	mov	rax, QWORD PTR 8[rax]
	sal	rax, 3
	add	rax, rdx
	mov	eax, DWORD PTR 4[rax]
	mov	edx, eax
	mov	rax, QWORD PTR -24[rbp]
	mov	QWORD PTR 8[rax], rdx
	jmp	.L31
.L15:
	mov	rax, QWORD PTR -32[rbp]
	mov	rdx, QWORD PTR [rax]
	mov	rax, QWORD PTR -32[rbp]
	mov	rax, QWORD PTR 8[rax]
	sal	rax, 2
	add	rax, rdx
	mov	eax, DWORD PTR [rax]
	test	eax, eax
	je	.L32
	mov	rax, QWORD PTR -24[rbp]
	mov	rdx, QWORD PTR [rax]
	mov	rax, QWORD PTR -24[rbp]
	mov	rax, QWORD PTR 8[rax]
	sal	rax, 3
	add	rax, rdx
	mov	eax, DWORD PTR 4[rax]
	mov	edx, eax
	mov	rax, QWORD PTR -24[rbp]
	mov	QWORD PTR 8[rax], rdx
	jmp	.L32
.L14:
	mov	eax, 1
	jmp	.L27
.L31:
	nop
	jmp	.L24
.L32:
	nop
.L24:
	mov	rax, QWORD PTR -24[rbp]
	mov	rax, QWORD PTR 8[rax]
	lea	rdx, 1[rax]
	mov	rax, QWORD PTR -24[rbp]
	mov	QWORD PTR 8[rax], rdx
	mov	rax, QWORD PTR -32[rbp]
	mov	rdx, QWORD PTR 8[rax]
	mov	rax, QWORD PTR -32[rbp]
	mov	rax, QWORD PTR 16[rax]
	cmp	rdx, rax
	jne	.L28
	movzx	edx, BYTE PTR -36[rbp]
	mov	rax, QWORD PTR -32[rbp]
	mov	ecx, edx
	mov	rdx, rax
	mov	esi, 0
	mov	edi, 0
	call	ensure_size
	test	eax, eax
	jne	.L29
.L28:
	cmp	DWORD PTR -4[rbp], 1
	jle	.L30
.L29:
	mov	eax, 1
	jmp	.L27
.L30:
	mov	eax, 0
.L27:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE9:
	.size	interpret, .-interpret
	.type	parse, @function
parse:
.LFB10:
	.cfi_startproc
	endbr64
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	sub	rsp, 48
	mov	QWORD PTR -24[rbp], rdi
	mov	QWORD PTR -32[rbp], rsi
	mov	eax, edx
	mov	BYTE PTR -36[rbp], al
	movsx	eax, BYTE PTR -36[rbp]
	sub	eax, 43
	cmp	eax, 50
	ja	.L34
	mov	eax, eax
	lea	rdx, 0[0+rax*4]
	lea	rax, .L36[rip]
	mov	eax, DWORD PTR [rdx+rax]
	cdqe
	lea	rdx, .L36[rip]
	add	rax, rdx
	notrack jmp	rax
	.section	.rodata
	.align 4
	.align 4
.L36:
	.long	.L43-.L36
	.long	.L42-.L36
	.long	.L41-.L36
	.long	.L40-.L36
	.long	.L34-.L36
	.long	.L34-.L36
	.long	.L34-.L36
	.long	.L34-.L36
	.long	.L34-.L36
	.long	.L34-.L36
	.long	.L34-.L36
	.long	.L34-.L36
	.long	.L34-.L36
	.long	.L34-.L36
	.long	.L34-.L36
	.long	.L34-.L36
	.long	.L34-.L36
	.long	.L39-.L36
	.long	.L34-.L36
	.long	.L38-.L36
	.long	.L34-.L36
	.long	.L34-.L36
	.long	.L34-.L36
	.long	.L34-.L36
	.long	.L34-.L36
	.long	.L34-.L36
	.long	.L34-.L36
	.long	.L34-.L36
	.long	.L34-.L36
	.long	.L34-.L36
	.long	.L34-.L36
	.long	.L34-.L36
	.long	.L34-.L36
	.long	.L34-.L36
	.long	.L34-.L36
	.long	.L34-.L36
	.long	.L34-.L36
	.long	.L34-.L36
	.long	.L34-.L36
	.long	.L34-.L36
	.long	.L34-.L36
	.long	.L34-.L36
	.long	.L34-.L36
	.long	.L34-.L36
	.long	.L34-.L36
	.long	.L34-.L36
	.long	.L34-.L36
	.long	.L34-.L36
	.long	.L37-.L36
	.long	.L34-.L36
	.long	.L35-.L36
	.text
.L42:
	mov	rax, QWORD PTR -24[rbp]
	mov	rdx, QWORD PTR [rax]
	mov	rax, QWORD PTR -24[rbp]
	mov	rax, QWORD PTR 8[rax]
	sal	rax, 3
	add	rax, rdx
	mov	DWORD PTR [rax], 1
	jmp	.L44
.L40:
	mov	rax, QWORD PTR -24[rbp]
	mov	rdx, QWORD PTR [rax]
	mov	rax, QWORD PTR -24[rbp]
	mov	rax, QWORD PTR 8[rax]
	sal	rax, 3
	add	rax, rdx
	mov	DWORD PTR [rax], 2
	jmp	.L44
.L43:
	mov	rax, QWORD PTR -24[rbp]
	mov	rdx, QWORD PTR [rax]
	mov	rax, QWORD PTR -24[rbp]
	mov	rax, QWORD PTR 8[rax]
	sal	rax, 3
	add	rax, rdx
	mov	DWORD PTR [rax], 3
	jmp	.L44
.L41:
	mov	rax, QWORD PTR -24[rbp]
	mov	rdx, QWORD PTR [rax]
	mov	rax, QWORD PTR -24[rbp]
	mov	rax, QWORD PTR 8[rax]
	sal	rax, 3
	add	rax, rdx
	mov	DWORD PTR [rax], 4
	jmp	.L44
.L38:
	mov	rax, QWORD PTR -24[rbp]
	mov	rdx, QWORD PTR [rax]
	mov	rax, QWORD PTR -24[rbp]
	mov	rax, QWORD PTR 8[rax]
	sal	rax, 3
	add	rax, rdx
	mov	DWORD PTR [rax], 6
	jmp	.L44
.L39:
	mov	rax, QWORD PTR -24[rbp]
	mov	rdx, QWORD PTR [rax]
	mov	rax, QWORD PTR -24[rbp]
	mov	rax, QWORD PTR 8[rax]
	sal	rax, 3
	add	rax, rdx
	mov	DWORD PTR [rax], 5
	jmp	.L44
.L37:
	mov	rax, QWORD PTR -24[rbp]
	mov	rdx, QWORD PTR [rax]
	mov	rax, QWORD PTR -24[rbp]
	mov	rax, QWORD PTR 8[rax]
	sal	rax, 3
	add	rax, rdx
	mov	DWORD PTR [rax], 7
	mov	rax, QWORD PTR -24[rbp]
	mov	rdi, QWORD PTR 8[rax]
	mov	rax, QWORD PTR -32[rbp]
	mov	rsi, QWORD PTR [rax]
	mov	rax, QWORD PTR -32[rbp]
	mov	rax, QWORD PTR 8[rax]
	lea	rcx, 1[rax]
	mov	rdx, QWORD PTR -32[rbp]
	mov	QWORD PTR 8[rdx], rcx
	sal	rax, 2
	add	rax, rsi
	mov	edx, edi
	mov	DWORD PTR [rax], edx
	jmp	.L44
.L35:
	mov	rax, QWORD PTR -24[rbp]
	mov	rdx, QWORD PTR [rax]
	mov	rax, QWORD PTR -24[rbp]
	mov	rax, QWORD PTR 8[rax]
	sal	rax, 3
	add	rax, rdx
	mov	DWORD PTR [rax], 8
	mov	rax, QWORD PTR -32[rbp]
	mov	rax, QWORD PTR 8[rax]
	test	rax, rax
	jne	.L45
	mov	rax, QWORD PTR -32[rbp]
	mov	rax, QWORD PTR 8[rax]
	lea	rdx, 1[rax]
	mov	rax, QWORD PTR -32[rbp]
	mov	QWORD PTR 8[rax], rdx
	mov	eax, 1
	jmp	.L46
.L45:
	mov	rax, QWORD PTR -32[rbp]
	mov	rdx, QWORD PTR [rax]
	mov	rax, QWORD PTR -32[rbp]
	mov	rax, QWORD PTR 8[rax]
	lea	rcx, -1[rax]
	mov	rax, QWORD PTR -32[rbp]
	mov	QWORD PTR 8[rax], rcx
	mov	rax, QWORD PTR -32[rbp]
	mov	rax, QWORD PTR 8[rax]
	sal	rax, 2
	add	rax, rdx
	mov	eax, DWORD PTR [rax]
	mov	eax, eax
	mov	QWORD PTR -8[rbp], rax
	mov	rax, QWORD PTR -24[rbp]
	mov	rdx, QWORD PTR [rax]
	mov	rax, QWORD PTR -24[rbp]
	mov	rax, QWORD PTR 8[rax]
	sal	rax, 3
	add	rax, rdx
	mov	rdx, QWORD PTR -8[rbp]
	mov	DWORD PTR 4[rax], edx
	mov	rax, QWORD PTR -24[rbp]
	mov	rcx, QWORD PTR 8[rax]
	mov	rax, QWORD PTR -24[rbp]
	mov	rax, QWORD PTR [rax]
	mov	rdx, QWORD PTR -8[rbp]
	sal	rdx, 3
	add	rax, rdx
	mov	edx, ecx
	mov	DWORD PTR 4[rax], edx
	jmp	.L44
.L34:
	mov	rax, QWORD PTR -24[rbp]
	mov	rax, QWORD PTR 8[rax]
	lea	rdx, -1[rax]
	mov	rax, QWORD PTR -24[rbp]
	mov	QWORD PTR 8[rax], rdx
.L44:
	mov	rax, QWORD PTR -24[rbp]
	mov	rax, QWORD PTR 8[rax]
	lea	rdx, 1[rax]
	mov	rax, QWORD PTR -24[rbp]
	mov	QWORD PTR 8[rax], rdx
	mov	rax, QWORD PTR -24[rbp]
	mov	rdx, QWORD PTR 8[rax]
	mov	rax, QWORD PTR -24[rbp]
	mov	rax, QWORD PTR 16[rax]
	cmp	rdx, rax
	jne	.L47
	mov	rax, QWORD PTR -24[rbp]
	mov	ecx, 0
	mov	edx, 0
	mov	esi, 0
	mov	rdi, rax
	call	ensure_size
	test	eax, eax
	je	.L47
	mov	eax, 1
	jmp	.L46
.L47:
	mov	rax, QWORD PTR -32[rbp]
	mov	rdx, QWORD PTR 8[rax]
	mov	rax, QWORD PTR -32[rbp]
	mov	rax, QWORD PTR 16[rax]
	cmp	rdx, rax
	jne	.L48
	mov	rax, QWORD PTR -32[rbp]
	mov	ecx, 0
	mov	edx, 0
	mov	rsi, rax
	mov	edi, 0
	call	ensure_size
	test	eax, eax
	je	.L48
	mov	eax, 1
	jmp	.L46
.L48:
	mov	eax, 0
.L46:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE10:
	.size	parse, .-parse
	.type	run, @function
run:
.LFB11:
	.cfi_startproc
	endbr64
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	sub	rsp, 560
	mov	QWORD PTR -536[rbp], rdi
	mov	QWORD PTR -544[rbp], rsi
	mov	eax, edx
	mov	BYTE PTR -548[rbp], al
	mov	rax, QWORD PTR fs:40
	mov	QWORD PTR -8[rbp], rax
	xor	eax, eax
	mov	rax, QWORD PTR stdout[rip]
	lea	rsi, -528[rbp]
	mov	ecx, 512
	mov	edx, 1
	mov	rdi, rax
	call	setvbuf@PLT
	cmp	BYTE PTR -548[rbp], 0
	je	.L51
	mov	rax, QWORD PTR -544[rbp]
	mov	rax, QWORD PTR 16[rax]
	sal	rax, 2
	shr	rax, 10
	mov	rdx, rax
	mov	rax, QWORD PTR FDBG_TEXT[rip]
	mov	rsi, rdx
	mov	rdi, rax
	mov	eax, 0
	call	printf@PLT
	jmp	.L51
.L53:
	movzx	edx, BYTE PTR -548[rbp]
	mov	rcx, QWORD PTR -544[rbp]
	mov	rax, QWORD PTR -536[rbp]
	mov	rsi, rcx
	mov	rdi, rax
	call	interpret
	cmp	eax, 1
	je	.L61
.L51:
	mov	rax, QWORD PTR -536[rbp]
	mov	rdx, QWORD PTR [rax]
	mov	rax, QWORD PTR -536[rbp]
	mov	rax, QWORD PTR 8[rax]
	sal	rax, 3
	add	rax, rdx
	mov	eax, DWORD PTR [rax]
	test	eax, eax
	je	.L52
	mov	rax, QWORD PTR -536[rbp]
	mov	rdx, QWORD PTR 8[rax]
	mov	rax, QWORD PTR -536[rbp]
	mov	rax, QWORD PTR 16[rax]
	cmp	rdx, rax
	jnb	.L52
	mov	rax, QWORD PTR -544[rbp]
	mov	rdx, QWORD PTR 8[rax]
	mov	rax, QWORD PTR -544[rbp]
	mov	rax, QWORD PTR 16[rax]
	cmp	rdx, rax
	jnb	.L52
	mov	rax, QWORD PTR -536[rbp]
	mov	rax, QWORD PTR 8[rax]
	mov	edx, 4294967295
	cmp	rdx, rax
	jb	.L52
	mov	rax, QWORD PTR -544[rbp]
	mov	rax, QWORD PTR 8[rax]
	mov	edx, 4294967295
	cmp	rdx, rax
	jnb	.L53
	jmp	.L52
.L61:
	nop
.L52:
	mov	rax, QWORD PTR -536[rbp]
	mov	rdx, QWORD PTR [rax]
	mov	rax, QWORD PTR -536[rbp]
	mov	rax, QWORD PTR 8[rax]
	sal	rax, 3
	add	rax, rdx
	mov	eax, DWORD PTR [rax]
	test	eax, eax
	jne	.L54
	mov	rax, QWORD PTR -536[rbp]
	mov	rdx, QWORD PTR 8[rax]
	mov	rax, QWORD PTR -536[rbp]
	mov	rax, QWORD PTR 16[rax]
	cmp	rdx, rax
	jnb	.L54
	mov	rax, QWORD PTR -544[rbp]
	mov	rdx, QWORD PTR 8[rax]
	mov	rax, QWORD PTR -544[rbp]
	mov	rax, QWORD PTR 16[rax]
	cmp	rdx, rax
	jnb	.L54
	mov	rax, QWORD PTR -536[rbp]
	mov	rax, QWORD PTR 8[rax]
	mov	edx, 4294967295
	cmp	rdx, rax
	jb	.L54
	mov	rax, QWORD PTR -544[rbp]
	mov	rax, QWORD PTR 8[rax]
	mov	edx, 4294967295
	cmp	rdx, rax
	jnb	.L55
.L54:
	mov	rax, QWORD PTR -536[rbp]
	mov	rax, QWORD PTR [rax]
	test	rax, rax
	je	.L56
	mov	rax, QWORD PTR -536[rbp]
	mov	rax, QWORD PTR [rax]
	mov	rdi, rax
	call	free@PLT
.L56:
	mov	rax, QWORD PTR -544[rbp]
	mov	rax, QWORD PTR [rax]
	test	rax, rax
	je	.L57
	mov	rax, QWORD PTR -544[rbp]
	mov	rax, QWORD PTR [rax]
	mov	rdi, rax
	call	free@PLT
.L57:
	mov	eax, 1
	jmp	.L59
.L55:
	mov	rax, QWORD PTR -536[rbp]
	mov	rax, QWORD PTR [rax]
	mov	rdi, rax
	call	free@PLT
	mov	rax, QWORD PTR -544[rbp]
	mov	rax, QWORD PTR [rax]
	mov	rdi, rax
	call	free@PLT
	mov	eax, 0
.L59:
	mov	rdx, QWORD PTR -8[rbp]
	sub	rdx, QWORD PTR fs:40
	je	.L60
	call	__stack_chk_fail@PLT
.L60:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE11:
	.size	run, .-run
	.type	cook, @function
cook:
.LFB12:
	.cfi_startproc
	endbr64
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	sub	rsp, 48
	mov	QWORD PTR -24[rbp], rdi
	mov	QWORD PTR -32[rbp], rsi
	mov	QWORD PTR -40[rbp], rdx
	jmp	.L63
.L65:
	movsx	edx, BYTE PTR -1[rbp]
	mov	rcx, QWORD PTR -40[rbp]
	mov	rax, QWORD PTR -32[rbp]
	mov	rsi, rcx
	mov	rdi, rax
	call	parse
	cmp	eax, 1
	je	.L71
.L63:
	mov	rax, QWORD PTR -24[rbp]
	mov	rdi, rax
	call	fgetc@PLT
	mov	BYTE PTR -1[rbp], al
	cmp	BYTE PTR -1[rbp], -1
	je	.L64
	mov	rax, QWORD PTR -32[rbp]
	mov	rdx, QWORD PTR 8[rax]
	mov	rax, QWORD PTR -32[rbp]
	mov	rax, QWORD PTR 16[rax]
	cmp	rdx, rax
	jnb	.L64
	mov	rax, QWORD PTR -40[rbp]
	mov	rdx, QWORD PTR 8[rax]
	mov	rax, QWORD PTR -40[rbp]
	mov	rax, QWORD PTR 16[rax]
	cmp	rdx, rax
	jnb	.L64
	mov	rax, QWORD PTR -32[rbp]
	mov	rax, QWORD PTR 8[rax]
	mov	edx, 4294967295
	cmp	rdx, rax
	jb	.L64
	mov	rax, QWORD PTR -40[rbp]
	mov	rax, QWORD PTR 8[rax]
	mov	edx, 4294967295
	cmp	rdx, rax
	jnb	.L65
	jmp	.L64
.L71:
	nop
.L64:
	cmp	BYTE PTR -1[rbp], -1
	jne	.L66
	mov	rax, QWORD PTR -32[rbp]
	mov	rdx, QWORD PTR 8[rax]
	mov	rax, QWORD PTR -32[rbp]
	mov	rax, QWORD PTR 16[rax]
	cmp	rdx, rax
	jnb	.L66
	mov	rax, QWORD PTR -40[rbp]
	mov	rdx, QWORD PTR 8[rax]
	mov	rax, QWORD PTR -40[rbp]
	mov	rax, QWORD PTR 16[rax]
	cmp	rdx, rax
	jnb	.L66
	mov	rax, QWORD PTR -32[rbp]
	mov	rax, QWORD PTR 8[rax]
	mov	edx, 4294967295
	cmp	rdx, rax
	jb	.L66
	mov	rax, QWORD PTR -40[rbp]
	mov	rax, QWORD PTR 8[rax]
	mov	edx, 4294967295
	cmp	rdx, rax
	jb	.L66
	mov	rax, QWORD PTR -40[rbp]
	mov	rax, QWORD PTR 8[rax]
	test	rax, rax
	je	.L67
.L66:
	mov	rax, QWORD PTR -32[rbp]
	mov	rax, QWORD PTR [rax]
	test	rax, rax
	je	.L68
	mov	rax, QWORD PTR -32[rbp]
	mov	rax, QWORD PTR [rax]
	mov	rdi, rax
	call	free@PLT
.L68:
	mov	rax, QWORD PTR -40[rbp]
	mov	rax, QWORD PTR [rax]
	test	rax, rax
	je	.L69
	mov	rax, QWORD PTR -40[rbp]
	mov	rax, QWORD PTR [rax]
	mov	rdi, rax
	call	free@PLT
.L69:
	mov	eax, 1
	jmp	.L70
.L67:
	mov	rax, QWORD PTR -32[rbp]
	mov	rdx, QWORD PTR [rax]
	mov	rax, QWORD PTR -32[rbp]
	mov	rax, QWORD PTR 8[rax]
	sal	rax, 3
	add	rax, rdx
	mov	DWORD PTR [rax], 0
	mov	rax, QWORD PTR -32[rbp]
	mov	QWORD PTR 8[rax], 0
	mov	eax, 0
.L70:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE12:
	.size	cook, .-cook
	.type	init, @function
init:
.LFB13:
	.cfi_startproc
	endbr64
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	sub	rsp, 32
	mov	QWORD PTR -8[rbp], rdi
	mov	QWORD PTR -16[rbp], rsi
	mov	QWORD PTR -24[rbp], rdx
	mov	rax, QWORD PTR -24[rbp]
	mov	QWORD PTR 8[rax], 0
	mov	rax, QWORD PTR -24[rbp]
	mov	rdx, QWORD PTR 8[rax]
	mov	rax, QWORD PTR -16[rbp]
	mov	QWORD PTR 8[rax], rdx
	mov	rax, QWORD PTR -16[rbp]
	mov	rdx, QWORD PTR 8[rax]
	mov	rax, QWORD PTR -8[rbp]
	mov	QWORD PTR 8[rax], rdx
	mov	rax, QWORD PTR -24[rbp]
	mov	QWORD PTR 16[rax], 256
	mov	rax, QWORD PTR -24[rbp]
	mov	rdx, QWORD PTR 16[rax]
	mov	rax, QWORD PTR -16[rbp]
	mov	QWORD PTR 16[rax], rdx
	mov	rax, QWORD PTR -16[rbp]
	mov	rdx, QWORD PTR 16[rax]
	mov	rax, QWORD PTR -8[rbp]
	mov	QWORD PTR 16[rax], rdx
	mov	rax, QWORD PTR -8[rbp]
	mov	rax, QWORD PTR 16[rax]
	sal	rax, 3
	mov	rdi, rax
	call	malloc@PLT
	mov	rdx, rax
	mov	rax, QWORD PTR -8[rbp]
	mov	QWORD PTR [rax], rdx
	mov	rax, QWORD PTR -16[rbp]
	mov	rax, QWORD PTR 16[rax]
	sal	rax, 2
	mov	rdi, rax
	call	malloc@PLT
	mov	rdx, rax
	mov	rax, QWORD PTR -16[rbp]
	mov	QWORD PTR [rax], rdx
	mov	rax, QWORD PTR -24[rbp]
	mov	rax, QWORD PTR 16[rax]
	mov	esi, 4
	mov	rdi, rax
	call	calloc@PLT
	mov	rdx, rax
	mov	rax, QWORD PTR -24[rbp]
	mov	QWORD PTR [rax], rdx
	cmp	QWORD PTR -8[rbp], 0
	je	.L73
	cmp	QWORD PTR -16[rbp], 0
	je	.L73
	cmp	QWORD PTR -24[rbp], 0
	jne	.L78
.L73:
	cmp	QWORD PTR -8[rbp], 0
	je	.L75
	mov	rax, QWORD PTR -8[rbp]
	mov	rdi, rax
	call	free@PLT
.L75:
	cmp	QWORD PTR -16[rbp], 0
	je	.L76
	mov	rax, QWORD PTR -16[rbp]
	mov	rdi, rax
	call	free@PLT
.L76:
	cmp	QWORD PTR -24[rbp], 0
	je	.L77
	mov	rax, QWORD PTR -24[rbp]
	mov	rdi, rax
	call	free@PLT
.L77:
	mov	edi, 1
	call	exit@PLT
.L78:
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE13:
	.size	init, .-init
	.section	.rodata
.LC5:
	.string	"r"
.LC6:
	.string	"-d"
	.text
	.globl	main
	.type	main, @function
main:
.LFB14:
	.cfi_startproc
	endbr64
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	add	rsp, -128
	mov	DWORD PTR -116[rbp], edi
	mov	QWORD PTR -128[rbp], rsi
	mov	rax, QWORD PTR fs:40
	mov	QWORD PTR -8[rbp], rax
	xor	eax, eax
	mov	DWORD PTR -108[rbp], 1
	mov	BYTE PTR -109[rbp], 0
	mov	rax, QWORD PTR -128[rbp]
	add	rax, 8
	mov	rax, QWORD PTR [rax]
	lea	rdx, .LC5[rip]
	mov	rsi, rdx
	mov	rdi, rax
	call	fopen@PLT
	mov	QWORD PTR -104[rbp], rax
	cmp	DWORD PTR -116[rbp], 1
	jle	.L80
	cmp	QWORD PTR -104[rbp], 0
	jne	.L81
.L80:
	mov	rax, QWORD PTR -128[rbp]
	mov	rax, QWORD PTR [rax]
	mov	rdi, rax
	call	die_usage
.L81:
	mov	rax, QWORD PTR -128[rbp]
	add	rax, 8
	mov	rax, QWORD PTR [rax]
	mov	rdi, rax
	call	is_brainfuck
	test	eax, eax
	je	.L82
	mov	rax, QWORD PTR -104[rbp]
	mov	rdi, rax
	call	fclose@PLT
	mov	rax, QWORD PTR -128[rbp]
	mov	rax, QWORD PTR [rax]
	mov	rdi, rax
	call	die_usage
.L82:
	cmp	DWORD PTR -116[rbp], 3
	jne	.L83
	mov	rax, QWORD PTR -128[rbp]
	add	rax, 16
	mov	rax, QWORD PTR [rax]
	mov	edx, 2
	lea	rcx, .LC6[rip]
	mov	rsi, rcx
	mov	rdi, rax
	call	strncmp@PLT
	test	eax, eax
	jne	.L83
	mov	BYTE PTR -109[rbp], 1
.L83:
	lea	rdx, -32[rbp]
	lea	rcx, -64[rbp]
	lea	rax, -96[rbp]
	mov	rsi, rcx
	mov	rdi, rax
	call	init
	lea	rdx, -64[rbp]
	lea	rcx, -96[rbp]
	mov	rax, QWORD PTR -104[rbp]
	mov	rsi, rcx
	mov	rdi, rax
	call	cook
	mov	DWORD PTR -108[rbp], eax
	mov	rax, QWORD PTR -104[rbp]
	mov	rdi, rax
	call	fclose@PLT
	cmp	DWORD PTR -108[rbp], 0
	jne	.L84
	movzx	edx, BYTE PTR -109[rbp]
	lea	rcx, -32[rbp]
	lea	rax, -96[rbp]
	mov	rsi, rcx
	mov	rdi, rax
	call	run
	mov	DWORD PTR -108[rbp], eax
.L84:
	mov	eax, DWORD PTR -108[rbp]
	mov	rdx, QWORD PTR -8[rbp]
	sub	rdx, QWORD PTR fs:40
	je	.L86
	call	__stack_chk_fail@PLT
.L86:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE14:
	.size	main, .-main
	.ident	"GCC: (Ubuntu 13.3.0-6ubuntu2~24.04.1) 13.3.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	1f - 0f
	.long	4f - 1f
	.long	5
0:
	.string	"GNU"
1:
	.align 8
	.long	0xc0000002
	.long	3f - 2f
2:
	.long	0x3
3:
	.align 8
4:
