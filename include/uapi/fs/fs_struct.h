#ifndef _LINUX_FS_STRUCT_H
#define _LINUX_FS_STRUCT_H

#include <dim-sum/rwlock_types.h>

struct dentry;
struct vfsmount;

/**
 * ���̵�fs�ֶ�ָ������ݡ�
 */
struct fs_struct {
	/**
	 * ����fs�ṹ�Ľ��̸�����
	 */
	atomic_t count;
	/**
	 * �����ýṹ�Ķ�д����
	 */
	rwlock_t lock;
	/**
	 * �����ļ������ļ�Ȩ��ʱʹ�õ�λ���롣
	 */
	int umask;
	/**
	 * root			��Ŀ¼��Ŀ¼�
	 * pwd			��ǰ����Ŀ¼��Ŀ¼�
	 */
	struct inode * root, * pwd;
#if 0
	/**
	 * rootmnt		��Ŀ¼����װ���ļ�ϵͳ����
	 * pwdmnt		��ǰ����Ŀ¼����װ���ļ�ϵͳ����
	 */
	struct vfsmount * rootmnt, * pwdmnt;
#endif
};

#define INIT_FS {				\
	.count		= ATOMIC_INIT(1),	\
	.lock		= RW_LOCK_UNLOCKED,	\
	.umask		= 0022, \
}

extern void exit_fs(struct task_struct *);
extern void set_fs_altroot(void);
extern void set_fs_root(struct fs_struct *, struct vfsmount *, struct dentry *);
extern void set_fs_pwd(struct fs_struct *, struct vfsmount *, struct dentry *);
extern struct fs_struct *copy_fs_struct(struct fs_struct *);
extern void put_fs_struct(struct fs_struct *);

#endif /* _LINUX_FS_STRUCT_H */
