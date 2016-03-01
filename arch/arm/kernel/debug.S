/*
 *  boot�׶δ�ӡ����ģ��
 */
#include <linux/linkage.h>
#include <asm/assembler.h>

		.text

/*
 * !!!!!!  ���漸�����Ժ����������ڵ���!!!!!!
 * ���ں˴�ӡ����������ʱ���ɵ����⼸������
 * ��Щ�������ƻ��Ĵ�������˿��ܻᵼ�¹��ܲ�������
 */

/*
 * ��ӡʮ���������ֵ����ڵ�����豸
 */

/*
 * ��û�п���MMUʱ��ʹ����������������ӡʮ����������
 */
ENTRY(debug_printhex8_nommu) /* ���8���ַ������� */
		mov	r1, #8
		b	printhex_nommu
ENDPROC(debug_printhex8_nommu)

ENTRY(debug_printhex4_nommu)
		mov	r1, #4
		b	printhex_nommu
ENDPROC(debug_printhex4_nommu)

ENTRY(debug_printhex2_nommu)
		mov	r1, #2
printhex_nommu:	adr	r2, debug_printhex_buf
		add	r3, r2, r1
		mov	r1, #0
		strb	r1, [r3]
1:		and	r1, r0, #15
		mov	r0, r0, lsr #4
		cmp	r1, #10
		addlt	r1, r1, #'0'
		addge	r1, r1, #'a' - 10
		strb	r1, [r3, #-1]!
		teq	r3, r2
		bne	1b
		mov	r0, r2
		b	debug_printstr_nommu
ENDPROC(debug_printhex2_nommu)

/*
 * ���Ѿ�����MMU��ʹ����������������ӡʮ����������
 */
ENTRY(debug_printhex8_mmu)
		mov	r1, #8
		b	printhex_mmu
ENDPROC(debug_printhex8_mmu)

ENTRY(debug_printhex4_mmu)
		mov	r1, #4
		b	printhex_mmu
ENDPROC(debug_printhex4_mmu)

ENTRY(debug_printhex2_mmu)
		mov	r1, #2
printhex_mmu:	adr	r2, debug_printhex_buf
		add	r3, r2, r1
		mov	r1, #0
		strb	r1, [r3]
1:		and	r1, r0, #15
		mov	r0, r0, lsr #4
		cmp	r1, #10
		addlt	r1, r1, #'0'
		addge	r1, r1, #'a' - 10
		strb	r1, [r3, #-1]!
		teq	r3, r2
		bne	1b
		mov	r0, r2
		b	debug_printstr_mmu
ENDPROC(debug_printhex2_mmu)

/* ��ӡʮ������ʱ��ʹ�õ���ʱ������ */
debug_printhex_buf:		.space 16

		.ltorg
