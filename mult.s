	.file	"mult.c"
	.text
	.p2align 4
	.globl	simpleMult
	.type	simpleMult, @function
simpleMult:
.LFB0:
	.cfi_startproc
	mulss	%xmm1, %xmm0
	ret
	.cfi_endproc
.LFE0:
	.size	simpleMult, .-simpleMult
	.ident	"GCC: (GNU) 11.3.0"
	.section	.note.GNU-stack,"",@progbits
