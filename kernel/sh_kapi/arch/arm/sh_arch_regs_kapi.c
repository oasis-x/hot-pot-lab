

/**********************************************************
 *                       Includers                        *
 **********************************************************/
#include <dim-sum/sched.h>
#include <asm/ptrace.h>

#include <sh_arch_regs_kapi.h>

/**********************************************************
 *                         Macro                          *
 **********************************************************/

/**********************************************************
 *                  Extern Declareation                   *
 **********************************************************/

/**********************************************************
 *                    Global Variables                    *
 **********************************************************/

/**********************************************************
 *                    Static Variables                    *
 **********************************************************/

/**********************************************************
 *                       Implements                       *
 **********************************************************/

static inline unsigned long get_user_reg(struct task_struct *task, int offset)
{
	return task->uregs->uregs[offset];
}

unsigned long sh_arch_ker_get_ureg(struct task_struct *task, long off)
{
	if (off & 3 || off >= sizeof(struct pt_regs))
	{
		return 0;
	}

	return get_user_reg(task, off >> 2);
}
