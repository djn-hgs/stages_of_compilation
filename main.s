	.file	"main.c"
	.text
	.p2align 4
	.globl	simpleMult
	.type	simpleMult, @function
simpleMult:
.LFB23:
	.cfi_startproc
	mulss	%xmm1, %xmm0
	ret
	.cfi_endproc
.LFE23:
	.size	simpleMult, .-simpleMult
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC4:
	.string	"%f times %f is %f\n"
	.section	.text.startup,"ax",@progbits
	.p2align 4
	.globl	main
	.type	main, @function
main:
.LFB24:
	.cfi_startproc
	subq	$8, %rsp
	.cfi_def_cfa_offset 16
	movss	.LC0(%rip), %xmm1
	movss	.LC1(%rip), %xmm0
	call	simpleMult@PLT
	pxor	%xmm2, %xmm2
	movl	$1, %edi
	movsd	.LC2(%rip), %xmm1
	cvtss2sd	%xmm0, %xmm2
	leaq	.LC4(%rip), %rsi
	movl	$3, %eax
	movsd	.LC3(%rip), %xmm0
	call	__printf_chk@PLT
	xorl	%eax, %eax
	addq	$8, %rsp
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE24:
	.size	main, .-main
	.section	.rodata.cst4,"aM",@progbits,4
	.align 4
.LC0:
	.long	1090519040
	.align 4
.LC1:
	.long	1088421888
	.section	.rodata.cst8,"aM",@progbits,8
	.align 8
.LC2:
	.long	0
	.long	1075838976
	.align 8
.LC3:
	.long	0
	.long	1075576832
	.ident	"GCC: (GNU) 11.3.0"
	.section	.note.GNU-stack,"",@progbits
