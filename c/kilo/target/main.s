	.file	"main.c"
	.intel_syntax noprefix
	.text
	.globl	erow
	.bss
	.align 16
	.type	erow, @object
	.size	erow, 16
erow:
	.zero	16
	.globl	E
	.align 32
	.type	E, @object
	.size	E, 96
E:
	.zero	96
	.section	.rodata
.LC0:
	.string	"\033[2J"
.LC1:
	.string	"\033[H"
	.text
	.globl	die
	.type	die, @function
die:
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
	mov	edx, 4
	lea	rax, .LC0[rip]
	mov	rsi, rax
	mov	edi, 1
	call	write@PLT
	mov	edx, 3
	lea	rax, .LC1[rip]
	mov	rsi, rax
	mov	edi, 1
	call	write@PLT
	mov	rax, QWORD PTR -8[rbp]
	mov	rdi, rax
	call	perror@PLT
	mov	edi, 1
	call	exit@PLT
	.cfi_endproc
.LFE6:
	.size	die, .-die
	.section	.rodata
.LC2:
	.string	"tcsetattr"
	.text
	.globl	disableRawMode
	.type	disableRawMode, @function
disableRawMode:
.LFB7:
	.cfi_startproc
	endbr64
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	lea	rax, E[rip+32]
	mov	rdx, rax
	mov	esi, 2
	mov	edi, 0
	call	tcsetattr@PLT
	cmp	eax, -1
	jne	.L4
	lea	rax, .LC2[rip]
	mov	rdi, rax
	call	die
.L4:
	nop
	pop	rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE7:
	.size	disableRawMode, .-disableRawMode
	.section	.rodata
.LC3:
	.string	"tcgetattr"
	.text
	.globl	enableRawMode
	.type	enableRawMode, @function
enableRawMode:
.LFB8:
	.cfi_startproc
	endbr64
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	sub	rsp, 80
	mov	rax, QWORD PTR fs:40
	mov	QWORD PTR -8[rbp], rax
	xor	eax, eax
	lea	rax, E[rip+32]
	mov	rsi, rax
	mov	edi, 0
	call	tcgetattr@PLT
	cmp	eax, -1
	jne	.L6
	lea	rax, .LC3[rip]
	mov	rdi, rax
	call	die
.L6:
	lea	rax, disableRawMode[rip]
	mov	rdi, rax
	call	atexit@PLT
	mov	rax, QWORD PTR E[rip+32]
	mov	rdx, QWORD PTR E[rip+40]
	mov	QWORD PTR -80[rbp], rax
	mov	QWORD PTR -72[rbp], rdx
	mov	rax, QWORD PTR E[rip+48]
	mov	rdx, QWORD PTR E[rip+56]
	mov	QWORD PTR -64[rbp], rax
	mov	QWORD PTR -56[rbp], rdx
	mov	rax, QWORD PTR E[rip+64]
	mov	rdx, QWORD PTR E[rip+72]
	mov	QWORD PTR -48[rbp], rax
	mov	QWORD PTR -40[rbp], rdx
	mov	rax, QWORD PTR E[rip+76]
	mov	rdx, QWORD PTR E[rip+84]
	mov	QWORD PTR -36[rbp], rax
	mov	QWORD PTR -28[rbp], rdx
	mov	eax, DWORD PTR -80[rbp]
	and	eax, -1331
	mov	DWORD PTR -80[rbp], eax
	mov	eax, DWORD PTR -76[rbp]
	and	eax, -2
	mov	DWORD PTR -76[rbp], eax
	mov	eax, DWORD PTR -72[rbp]
	or	eax, -49
	mov	DWORD PTR -72[rbp], eax
	mov	eax, DWORD PTR -68[rbp]
	and	eax, -32780
	mov	DWORD PTR -68[rbp], eax
	mov	BYTE PTR -57[rbp], 0
	mov	BYTE PTR -58[rbp], 1
	lea	rax, -80[rbp]
	mov	rdx, rax
	mov	esi, 2
	mov	edi, 0
	call	tcsetattr@PLT
	cmp	eax, -1
	jne	.L9
	lea	rax, .LC2[rip]
	mov	rdi, rax
	call	die
.L9:
	nop
	mov	rax, QWORD PTR -8[rbp]
	sub	rax, QWORD PTR fs:40
	je	.L8
	call	__stack_chk_fail@PLT
.L8:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE8:
	.size	enableRawMode, .-enableRawMode
	.section	.rodata
.LC4:
	.string	"read"
	.text
	.globl	editorReadKey
	.type	editorReadKey, @function
editorReadKey:
.LFB9:
	.cfi_startproc
	endbr64
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	sub	rsp, 32
	mov	rax, QWORD PTR fs:40
	mov	QWORD PTR -8[rbp], rax
	xor	eax, eax
	jmp	.L11
.L13:
	cmp	DWORD PTR -16[rbp], -1
	jne	.L11
	call	__errno_location@PLT
	mov	eax, DWORD PTR [rax]
	cmp	eax, 11
	je	.L11
	lea	rax, .LC4[rip]
	mov	rdi, rax
	call	die
.L11:
	lea	rax, -17[rbp]
	mov	edx, 1
	mov	rsi, rax
	mov	edi, 0
	call	read@PLT
	mov	DWORD PTR -16[rbp], eax
	cmp	DWORD PTR -16[rbp], 1
	jne	.L13
	movzx	eax, BYTE PTR -17[rbp]
	cmp	al, 27
	jne	.L14
	lea	rax, -11[rbp]
	mov	edx, 1
	mov	rsi, rax
	mov	edi, 0
	call	read@PLT
	cmp	rax, 1
	je	.L15
	mov	eax, 27
	jmp	.L41
.L15:
	lea	rax, -11[rbp]
	add	rax, 1
	mov	edx, 1
	mov	rsi, rax
	mov	edi, 0
	call	read@PLT
	cmp	rax, 1
	je	.L17
	mov	eax, 27
	jmp	.L41
.L17:
	movzx	eax, BYTE PTR -11[rbp]
	cmp	al, 91
	jne	.L18
	movzx	eax, BYTE PTR -10[rbp]
	cmp	al, 47
	jle	.L19
	movzx	eax, BYTE PTR -10[rbp]
	cmp	al, 57
	jg	.L19
	lea	rax, -11[rbp]
	add	rax, 2
	mov	edx, 1
	mov	rsi, rax
	mov	edi, 0
	call	read@PLT
	cmp	rax, 1
	je	.L20
	mov	eax, 27
	jmp	.L41
.L20:
	movzx	eax, BYTE PTR -9[rbp]
	cmp	al, 126
	jne	.L43
	movzx	eax, BYTE PTR -10[rbp]
	movsx	eax, al
	sub	eax, 49
	cmp	eax, 7
	ja	.L43
	mov	eax, eax
	lea	rdx, 0[0+rax*4]
	lea	rax, .L23[rip]
	mov	eax, DWORD PTR [rdx+rax]
	cdqe
	lea	rdx, .L23[rip]
	add	rax, rdx
	notrack jmp	rax
	.section	.rodata
	.align 4
	.align 4
.L23:
	.long	.L29-.L23
	.long	.L43-.L23
	.long	.L28-.L23
	.long	.L27-.L23
	.long	.L26-.L23
	.long	.L25-.L23
	.long	.L24-.L23
	.long	.L22-.L23
	.text
.L29:
	mov	eax, 1005
	jmp	.L41
.L28:
	mov	eax, 1004
	jmp	.L41
.L27:
	mov	eax, 1006
	jmp	.L41
.L26:
	mov	eax, 1007
	jmp	.L41
.L25:
	mov	eax, 1008
	jmp	.L41
.L24:
	mov	eax, 1005
	jmp	.L41
.L22:
	mov	eax, 1006
	jmp	.L41
.L19:
	movzx	eax, BYTE PTR -10[rbp]
	movsx	eax, al
	sub	eax, 65
	cmp	eax, 7
	ja	.L38
	mov	eax, eax
	lea	rdx, 0[0+rax*4]
	lea	rax, .L32[rip]
	mov	eax, DWORD PTR [rdx+rax]
	cdqe
	lea	rdx, .L32[rip]
	add	rax, rdx
	notrack jmp	rax
	.section	.rodata
	.align 4
	.align 4
.L32:
	.long	.L37-.L32
	.long	.L36-.L32
	.long	.L35-.L32
	.long	.L34-.L32
	.long	.L38-.L32
	.long	.L33-.L32
	.long	.L38-.L32
	.long	.L31-.L32
	.text
.L37:
	mov	eax, 1002
	jmp	.L41
.L36:
	mov	eax, 1003
	jmp	.L41
.L35:
	mov	eax, 1001
	jmp	.L41
.L34:
	mov	eax, 1000
	jmp	.L41
.L31:
	mov	eax, 1005
	jmp	.L41
.L33:
	mov	eax, 1006
	jmp	.L41
.L18:
	movzx	eax, BYTE PTR -11[rbp]
	cmp	al, 79
	jne	.L38
	movzx	eax, BYTE PTR -10[rbp]
	movsx	eax, al
	cmp	eax, 70
	je	.L39
	cmp	eax, 72
	jne	.L38
	mov	eax, 1005
	jmp	.L41
.L39:
	mov	eax, 1006
	jmp	.L41
.L43:
	nop
.L38:
	mov	eax, 27
	jmp	.L41
.L14:
	movzx	eax, BYTE PTR -17[rbp]
	movsx	eax, al
.L41:
	mov	rdx, QWORD PTR -8[rbp]
	sub	rdx, QWORD PTR fs:40
	je	.L42
	call	__stack_chk_fail@PLT
.L42:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE9:
	.size	editorReadKey, .-editorReadKey
	.globl	getWindowSize
	.type	getWindowSize, @function
getWindowSize:
.LFB10:
	.cfi_startproc
	endbr64
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	sub	rsp, 32
	mov	QWORD PTR -24[rbp], rdi
	mov	QWORD PTR -32[rbp], rsi
	mov	rax, QWORD PTR fs:40
	mov	QWORD PTR -8[rbp], rax
	xor	eax, eax
	lea	rax, -16[rbp]
	mov	rdx, rax
	mov	esi, 21523
	mov	edi, 1
	mov	eax, 0
	call	ioctl@PLT
	cmp	eax, -1
	je	.L45
	movzx	eax, WORD PTR -14[rbp]
	test	ax, ax
	jne	.L46
.L45:
	mov	eax, -1
	jmp	.L48
.L46:
	movzx	eax, WORD PTR -14[rbp]
	movzx	edx, ax
	mov	rax, QWORD PTR -32[rbp]
	mov	DWORD PTR [rax], edx
	movzx	eax, WORD PTR -16[rbp]
	movzx	edx, ax
	mov	rax, QWORD PTR -24[rbp]
	mov	DWORD PTR [rax], edx
	mov	eax, 0
.L48:
	mov	rdx, QWORD PTR -8[rbp]
	sub	rdx, QWORD PTR fs:40
	je	.L49
	call	__stack_chk_fail@PLT
.L49:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE10:
	.size	getWindowSize, .-getWindowSize
	.globl	editorAppendRow
	.type	editorAppendRow, @function
editorAppendRow:
.LFB11:
	.cfi_startproc
	endbr64
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	push	rbx
	sub	rsp, 40
	.cfi_offset 3, -24
	mov	QWORD PTR -40[rbp], rdi
	mov	QWORD PTR -48[rbp], rsi
	mov	eax, DWORD PTR E[rip+20]
	add	eax, 1
	cdqe
	sal	rax, 4
	mov	rdx, rax
	mov	rax, QWORD PTR E[rip+24]
	mov	rsi, rdx
	mov	rdi, rax
	call	realloc@PLT
	mov	QWORD PTR E[rip+24], rax
	mov	eax, DWORD PTR E[rip+20]
	mov	DWORD PTR -20[rbp], eax
	mov	rax, QWORD PTR E[rip+24]
	mov	edx, DWORD PTR -20[rbp]
	movsx	rdx, edx
	sal	rdx, 4
	add	rax, rdx
	mov	rdx, QWORD PTR -48[rbp]
	mov	DWORD PTR [rax], edx
	mov	rax, QWORD PTR -48[rbp]
	add	rax, 1
	mov	rdx, QWORD PTR E[rip+24]
	mov	ecx, DWORD PTR -20[rbp]
	movsx	rcx, ecx
	sal	rcx, 4
	lea	rbx, [rdx+rcx]
	mov	rdi, rax
	call	malloc@PLT
	mov	QWORD PTR 8[rbx], rax
	mov	rax, QWORD PTR E[rip+24]
	mov	edx, DWORD PTR -20[rbp]
	movsx	rdx, edx
	sal	rdx, 4
	add	rax, rdx
	mov	rax, QWORD PTR 8[rax]
	mov	rdx, QWORD PTR -48[rbp]
	mov	rcx, QWORD PTR -40[rbp]
	mov	rsi, rcx
	mov	rdi, rax
	call	memcpy@PLT
	mov	rax, QWORD PTR E[rip+24]
	mov	edx, DWORD PTR -20[rbp]
	movsx	rdx, edx
	sal	rdx, 4
	add	rax, rdx
	mov	rdx, QWORD PTR 8[rax]
	mov	rax, QWORD PTR -48[rbp]
	add	rax, rdx
	mov	BYTE PTR [rax], 0
	mov	eax, DWORD PTR E[rip+20]
	add	eax, 1
	mov	DWORD PTR E[rip+20], eax
	nop
	mov	rbx, QWORD PTR -8[rbp]
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE11:
	.size	editorAppendRow, .-editorAppendRow
	.section	.rodata
.LC5:
	.string	"r"
.LC6:
	.string	"fopen"
	.text
	.globl	editorOpen
	.type	editorOpen, @function
editorOpen:
.LFB12:
	.cfi_startproc
	endbr64
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	sub	rsp, 64
	mov	QWORD PTR -56[rbp], rdi
	mov	rax, QWORD PTR fs:40
	mov	QWORD PTR -8[rbp], rax
	xor	eax, eax
	mov	rax, QWORD PTR -56[rbp]
	lea	rdx, .LC5[rip]
	mov	rsi, rdx
	mov	rdi, rax
	call	fopen@PLT
	mov	QWORD PTR -16[rbp], rax
	cmp	QWORD PTR -16[rbp], 0
	jne	.L52
	lea	rax, .LC6[rip]
	mov	rdi, rax
	call	die
.L52:
	mov	QWORD PTR -40[rbp], 0
	mov	QWORD PTR -32[rbp], 0
	jmp	.L53
.L56:
	sub	QWORD PTR -24[rbp], 1
.L54:
	cmp	QWORD PTR -24[rbp], 0
	jle	.L55
	mov	rax, QWORD PTR -40[rbp]
	mov	rdx, QWORD PTR -24[rbp]
	sub	rdx, 1
	add	rax, rdx
	movzx	eax, BYTE PTR [rax]
	cmp	al, 10
	je	.L56
	mov	rax, QWORD PTR -40[rbp]
	mov	rdx, QWORD PTR -24[rbp]
	sub	rdx, 1
	add	rax, rdx
	movzx	eax, BYTE PTR [rax]
	cmp	al, 13
	je	.L56
.L55:
	mov	rdx, QWORD PTR -24[rbp]
	mov	rax, QWORD PTR -40[rbp]
	mov	rsi, rdx
	mov	rdi, rax
	call	editorAppendRow
.L53:
	mov	rdx, QWORD PTR -16[rbp]
	lea	rcx, -32[rbp]
	lea	rax, -40[rbp]
	mov	rsi, rcx
	mov	rdi, rax
	call	getline@PLT
	mov	QWORD PTR -24[rbp], rax
	cmp	QWORD PTR -24[rbp], -1
	jne	.L54
	mov	rax, QWORD PTR -40[rbp]
	mov	rdi, rax
	call	free@PLT
	mov	rax, QWORD PTR -16[rbp]
	mov	rdi, rax
	call	fclose@PLT
	nop
	mov	rax, QWORD PTR -8[rbp]
	sub	rax, QWORD PTR fs:40
	je	.L58
	call	__stack_chk_fail@PLT
.L58:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE12:
	.size	editorOpen, .-editorOpen
	.globl	abAppend
	.type	abAppend, @function
abAppend:
.LFB13:
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
	mov	DWORD PTR -36[rbp], edx
	mov	rax, QWORD PTR -24[rbp]
	mov	edx, DWORD PTR 8[rax]
	mov	eax, DWORD PTR -36[rbp]
	add	eax, edx
	movsx	rdx, eax
	mov	rax, QWORD PTR -24[rbp]
	mov	rax, QWORD PTR [rax]
	mov	rsi, rdx
	mov	rdi, rax
	call	realloc@PLT
	mov	QWORD PTR -8[rbp], rax
	cmp	QWORD PTR -8[rbp], 0
	je	.L62
	mov	eax, DWORD PTR -36[rbp]
	movsx	rdx, eax
	mov	rax, QWORD PTR -24[rbp]
	mov	eax, DWORD PTR 8[rax]
	movsx	rcx, eax
	mov	rax, QWORD PTR -8[rbp]
	add	rcx, rax
	mov	rax, QWORD PTR -32[rbp]
	mov	rsi, rax
	mov	rdi, rcx
	call	memcpy@PLT
	mov	rax, QWORD PTR -24[rbp]
	mov	rdx, QWORD PTR -8[rbp]
	mov	QWORD PTR [rax], rdx
	mov	rax, QWORD PTR -24[rbp]
	mov	edx, DWORD PTR 8[rax]
	mov	eax, DWORD PTR -36[rbp]
	add	edx, eax
	mov	rax, QWORD PTR -24[rbp]
	mov	DWORD PTR 8[rax], edx
	jmp	.L59
.L62:
	nop
.L59:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE13:
	.size	abAppend, .-abAppend
	.globl	abFree
	.type	abFree, @function
abFree:
.LFB14:
	.cfi_startproc
	endbr64
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	sub	rsp, 16
	mov	QWORD PTR -8[rbp], rdi
	mov	rax, QWORD PTR -8[rbp]
	mov	rax, QWORD PTR [rax]
	mov	rdi, rax
	call	free@PLT
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE14:
	.size	abFree, .-abFree
	.globl	editorScroll
	.type	editorScroll, @function
editorScroll:
.LFB15:
	.cfi_startproc
	endbr64
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	mov	edx, DWORD PTR E[rip+4]
	mov	eax, DWORD PTR E[rip+8]
	cmp	edx, eax
	jge	.L65
	mov	eax, DWORD PTR E[rip+4]
	mov	DWORD PTR E[rip+8], eax
.L65:
	mov	edx, DWORD PTR E[rip+4]
	mov	ecx, DWORD PTR E[rip+8]
	mov	eax, DWORD PTR E[rip+12]
	add	eax, ecx
	cmp	edx, eax
	jl	.L67
	mov	edx, DWORD PTR E[rip+4]
	mov	eax, DWORD PTR E[rip+12]
	sub	edx, eax
	lea	eax, 1[rdx]
	mov	DWORD PTR E[rip+8], eax
.L67:
	nop
	pop	rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE15:
	.size	editorScroll, .-editorScroll
	.section	.rodata
.LC7:
	.string	"0.0.1"
.LC8:
	.string	"Kilo editor -- version %s"
.LC9:
	.string	"~"
.LC10:
	.string	" "
.LC11:
	.string	"\033[K"
.LC12:
	.string	"\r\n"
	.text
	.globl	editorDrawRows
	.type	editorDrawRows, @function
editorDrawRows:
.LFB16:
	.cfi_startproc
	endbr64
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	sub	rsp, 144
	mov	QWORD PTR -136[rbp], rdi
	mov	rax, QWORD PTR fs:40
	mov	QWORD PTR -8[rbp], rax
	xor	eax, eax
	mov	DWORD PTR -116[rbp], 0
	jmp	.L69
.L80:
	mov	edx, DWORD PTR E[rip+8]
	mov	eax, DWORD PTR -116[rbp]
	add	eax, edx
	mov	DWORD PTR -100[rbp], eax
	mov	eax, DWORD PTR E[rip+20]
	cmp	DWORD PTR -100[rbp], eax
	jl	.L70
	mov	eax, DWORD PTR E[rip+20]
	test	eax, eax
	jne	.L71
	mov	eax, DWORD PTR E[rip+12]
	movsx	rdx, eax
	imul	rdx, rdx, 1431655766
	mov	rcx, rdx
	shr	rcx, 32
	cdq
	mov	eax, ecx
	sub	eax, edx
	cmp	DWORD PTR -116[rbp], eax
	jne	.L71
	lea	rax, -96[rbp]
	lea	rdx, .LC7[rip]
	mov	rcx, rdx
	lea	rdx, .LC8[rip]
	mov	esi, 80
	mov	rdi, rax
	mov	eax, 0
	call	snprintf@PLT
	mov	DWORD PTR -112[rbp], eax
	mov	eax, DWORD PTR E[rip+16]
	cmp	DWORD PTR -112[rbp], eax
	jle	.L72
	mov	eax, DWORD PTR E[rip+16]
	mov	DWORD PTR -112[rbp], eax
.L72:
	mov	eax, DWORD PTR E[rip+16]
	sub	eax, DWORD PTR -112[rbp]
	mov	edx, eax
	shr	edx, 31
	add	eax, edx
	sar	eax
	mov	DWORD PTR -108[rbp], eax
	cmp	DWORD PTR -108[rbp], 0
	je	.L74
	mov	rax, QWORD PTR -136[rbp]
	mov	edx, 1
	lea	rcx, .LC9[rip]
	mov	rsi, rcx
	mov	rdi, rax
	call	abAppend
	sub	DWORD PTR -108[rbp], 1
	jmp	.L74
.L75:
	mov	rax, QWORD PTR -136[rbp]
	mov	edx, 1
	lea	rcx, .LC10[rip]
	mov	rsi, rcx
	mov	rdi, rax
	call	abAppend
.L74:
	mov	eax, DWORD PTR -108[rbp]
	lea	edx, -1[rax]
	mov	DWORD PTR -108[rbp], edx
	test	eax, eax
	jne	.L75
	mov	edx, DWORD PTR -112[rbp]
	lea	rcx, -96[rbp]
	mov	rax, QWORD PTR -136[rbp]
	mov	rsi, rcx
	mov	rdi, rax
	call	abAppend
	jmp	.L77
.L71:
	mov	rax, QWORD PTR -136[rbp]
	mov	edx, 1
	lea	rcx, .LC9[rip]
	mov	rsi, rcx
	mov	rdi, rax
	call	abAppend
	jmp	.L77
.L70:
	mov	rax, QWORD PTR E[rip+24]
	mov	edx, DWORD PTR -100[rbp]
	movsx	rdx, edx
	sal	rdx, 4
	add	rax, rdx
	mov	eax, DWORD PTR [rax]
	mov	DWORD PTR -104[rbp], eax
	mov	eax, DWORD PTR E[rip+16]
	cmp	DWORD PTR -104[rbp], eax
	jle	.L78
	mov	eax, DWORD PTR E[rip+16]
	mov	DWORD PTR -104[rbp], eax
.L78:
	mov	rax, QWORD PTR E[rip+24]
	mov	edx, DWORD PTR -100[rbp]
	movsx	rdx, edx
	sal	rdx, 4
	add	rax, rdx
	mov	rcx, QWORD PTR 8[rax]
	mov	edx, DWORD PTR -104[rbp]
	mov	rax, QWORD PTR -136[rbp]
	mov	rsi, rcx
	mov	rdi, rax
	call	abAppend
.L77:
	mov	rax, QWORD PTR -136[rbp]
	mov	edx, 3
	lea	rcx, .LC11[rip]
	mov	rsi, rcx
	mov	rdi, rax
	call	abAppend
	mov	eax, DWORD PTR E[rip+12]
	sub	eax, 1
	cmp	DWORD PTR -116[rbp], eax
	jge	.L79
	mov	rax, QWORD PTR -136[rbp]
	mov	edx, 2
	lea	rcx, .LC12[rip]
	mov	rsi, rcx
	mov	rdi, rax
	call	abAppend
.L79:
	add	DWORD PTR -116[rbp], 1
.L69:
	mov	eax, DWORD PTR E[rip+12]
	cmp	DWORD PTR -116[rbp], eax
	jl	.L80
	nop
	mov	rax, QWORD PTR -8[rbp]
	sub	rax, QWORD PTR fs:40
	je	.L81
	call	__stack_chk_fail@PLT
.L81:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE16:
	.size	editorDrawRows, .-editorDrawRows
	.section	.rodata
.LC13:
	.string	"\033[?25l"
.LC14:
	.string	"\033[%d;%dH"
.LC15:
	.string	"\033[?25h"
	.text
	.globl	editorRefreshScreen
	.type	editorRefreshScreen, @function
editorRefreshScreen:
.LFB17:
	.cfi_startproc
	endbr64
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	sub	rsp, 64
	mov	rax, QWORD PTR fs:40
	mov	QWORD PTR -8[rbp], rax
	xor	eax, eax
	call	editorScroll
	mov	QWORD PTR -64[rbp], 0
	mov	DWORD PTR -56[rbp], 0
	lea	rax, -64[rbp]
	mov	edx, 6
	lea	rcx, .LC13[rip]
	mov	rsi, rcx
	mov	rdi, rax
	call	abAppend
	lea	rax, -64[rbp]
	mov	edx, 3
	lea	rcx, .LC1[rip]
	mov	rsi, rcx
	mov	rdi, rax
	call	abAppend
	lea	rax, -64[rbp]
	mov	rdi, rax
	call	editorDrawRows
	mov	eax, DWORD PTR E[rip]
	lea	ecx, 1[rax]
	mov	edx, DWORD PTR E[rip+4]
	mov	eax, DWORD PTR E[rip+8]
	sub	edx, eax
	add	edx, 1
	lea	rax, -48[rbp]
	mov	r8d, ecx
	mov	ecx, edx
	lea	rdx, .LC14[rip]
	mov	esi, 32
	mov	rdi, rax
	mov	eax, 0
	call	snprintf@PLT
	lea	rax, -48[rbp]
	mov	rdi, rax
	call	strlen@PLT
	mov	edx, eax
	lea	rcx, -48[rbp]
	lea	rax, -64[rbp]
	mov	rsi, rcx
	mov	rdi, rax
	call	abAppend
	lea	rax, -64[rbp]
	mov	edx, 6
	lea	rcx, .LC15[rip]
	mov	rsi, rcx
	mov	rdi, rax
	call	abAppend
	mov	eax, DWORD PTR -56[rbp]
	movsx	rdx, eax
	mov	rax, QWORD PTR -64[rbp]
	mov	rsi, rax
	mov	edi, 1
	call	write@PLT
	lea	rax, -64[rbp]
	mov	rdi, rax
	call	abFree
	nop
	mov	rax, QWORD PTR -8[rbp]
	sub	rax, QWORD PTR fs:40
	je	.L83
	call	__stack_chk_fail@PLT
.L83:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE17:
	.size	editorRefreshScreen, .-editorRefreshScreen
	.globl	editorMoveCursor
	.type	editorMoveCursor, @function
editorMoveCursor:
.LFB18:
	.cfi_startproc
	endbr64
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	mov	DWORD PTR -4[rbp], edi
	cmp	DWORD PTR -4[rbp], 1003
	je	.L85
	cmp	DWORD PTR -4[rbp], 1003
	jg	.L94
	cmp	DWORD PTR -4[rbp], 1002
	je	.L87
	cmp	DWORD PTR -4[rbp], 1002
	jg	.L94
	cmp	DWORD PTR -4[rbp], 1000
	je	.L88
	cmp	DWORD PTR -4[rbp], 1001
	je	.L89
	jmp	.L94
.L88:
	mov	eax, DWORD PTR E[rip]
	test	eax, eax
	je	.L95
	mov	eax, DWORD PTR E[rip]
	sub	eax, 1
	mov	DWORD PTR E[rip], eax
	jmp	.L95
.L89:
	mov	edx, DWORD PTR E[rip]
	mov	eax, DWORD PTR E[rip+16]
	sub	eax, 1
	cmp	edx, eax
	je	.L96
	mov	eax, DWORD PTR E[rip]
	add	eax, 1
	mov	DWORD PTR E[rip], eax
	jmp	.L96
.L87:
	mov	eax, DWORD PTR E[rip+4]
	test	eax, eax
	je	.L97
	mov	eax, DWORD PTR E[rip+4]
	sub	eax, 1
	mov	DWORD PTR E[rip+4], eax
	jmp	.L97
.L85:
	mov	edx, DWORD PTR E[rip+4]
	mov	eax, DWORD PTR E[rip+20]
	cmp	edx, eax
	jge	.L98
	mov	eax, DWORD PTR E[rip+4]
	add	eax, 1
	mov	DWORD PTR E[rip+4], eax
	jmp	.L98
.L95:
	nop
	jmp	.L94
.L96:
	nop
	jmp	.L94
.L97:
	nop
	jmp	.L94
.L98:
	nop
.L94:
	nop
	pop	rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE18:
	.size	editorMoveCursor, .-editorMoveCursor
	.globl	editorProcessKeypress
	.type	editorProcessKeypress, @function
editorProcessKeypress:
.LFB19:
	.cfi_startproc
	endbr64
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	sub	rsp, 16
	call	editorReadKey
	mov	DWORD PTR -4[rbp], eax
	cmp	DWORD PTR -4[rbp], 1008
	jg	.L111
	cmp	DWORD PTR -4[rbp], 1007
	jge	.L101
	cmp	DWORD PTR -4[rbp], 1006
	je	.L102
	cmp	DWORD PTR -4[rbp], 1006
	jg	.L111
	cmp	DWORD PTR -4[rbp], 1005
	je	.L103
	cmp	DWORD PTR -4[rbp], 1005
	jg	.L111
	cmp	DWORD PTR -4[rbp], 17
	je	.L104
	cmp	DWORD PTR -4[rbp], 17
	jl	.L111
	mov	eax, DWORD PTR -4[rbp]
	sub	eax, 1000
	cmp	eax, 3
	ja	.L111
	jmp	.L110
.L104:
	mov	edx, 4
	lea	rax, .LC0[rip]
	mov	rsi, rax
	mov	edi, 1
	call	write@PLT
	mov	edx, 3
	lea	rax, .LC1[rip]
	mov	rsi, rax
	mov	edi, 1
	call	write@PLT
	mov	edi, 0
	call	exit@PLT
.L103:
	mov	DWORD PTR E[rip], 0
	jmp	.L100
.L102:
	mov	eax, DWORD PTR E[rip+16]
	sub	eax, 1
	mov	DWORD PTR E[rip], eax
	jmp	.L100
.L101:
	mov	eax, DWORD PTR E[rip+12]
	mov	DWORD PTR -8[rbp], eax
	jmp	.L106
.L109:
	cmp	DWORD PTR -4[rbp], 1007
	jne	.L107
	mov	eax, 1002
	jmp	.L108
.L107:
	mov	eax, 1003
.L108:
	mov	edi, eax
	call	editorMoveCursor
.L106:
	mov	eax, DWORD PTR -8[rbp]
	lea	edx, -1[rax]
	mov	DWORD PTR -8[rbp], edx
	test	eax, eax
	jne	.L109
	jmp	.L100
.L110:
	mov	eax, DWORD PTR -4[rbp]
	mov	edi, eax
	call	editorMoveCursor
	nop
.L100:
.L111:
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE19:
	.size	editorProcessKeypress, .-editorProcessKeypress
	.section	.rodata
.LC16:
	.string	"getWindowSize"
	.text
	.globl	initEditor
	.type	initEditor, @function
initEditor:
.LFB20:
	.cfi_startproc
	endbr64
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	mov	DWORD PTR E[rip], 0
	mov	DWORD PTR E[rip+4], 0
	mov	DWORD PTR E[rip+8], 0
	mov	DWORD PTR E[rip+20], 0
	mov	QWORD PTR E[rip+24], 0
	lea	rax, E[rip+16]
	mov	rsi, rax
	lea	rax, E[rip+12]
	mov	rdi, rax
	call	getWindowSize
	cmp	eax, -1
	jne	.L114
	lea	rax, .LC16[rip]
	mov	rdi, rax
	call	die
.L114:
	nop
	pop	rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE20:
	.size	initEditor, .-initEditor
	.globl	main
	.type	main, @function
main:
.LFB21:
	.cfi_startproc
	endbr64
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	sub	rsp, 16
	mov	DWORD PTR -4[rbp], edi
	mov	QWORD PTR -16[rbp], rsi
	call	enableRawMode
	call	initEditor
	cmp	DWORD PTR -4[rbp], 1
	jle	.L117
	mov	rax, QWORD PTR -16[rbp]
	add	rax, 8
	mov	rax, QWORD PTR [rax]
	mov	rdi, rax
	call	editorOpen
.L117:
	call	editorRefreshScreen
	call	editorProcessKeypress
	nop
	jmp	.L117
	.cfi_endproc
.LFE21:
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
