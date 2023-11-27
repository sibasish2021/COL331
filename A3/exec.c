#include "types.h"
#include "param.h"
#include "memlayout.h"
#include "mmu.h"
#include "proc.h"
#include "defs.h"
#include "x86.h"
#include "elf.h"

int
randomrange(int low, int high)
{
  if (high < low) {
    int tmp = low;
    low = high;
    high = tmp;
  }
  int range = high - low + 1;
  int rnd=random() % (range) + low;
  while(rnd%2==0)
  {
    rnd=random() % (range) + low;
  }
  return rnd;
}



int
exec(char *path, char **argv)
{
  char *s, *last;
  int i, off;
  uint argc, sz, sp, ustack[3+MAXARG+1];
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pde_t *pgdir, *oldpgdir;
  struct proc *curproc = myproc();

  begin_op();

  //Reading ASLR flag from file
  int aslr = 0;
  char c[2] = {0};
  // if ((ip = namei("aslr_flag")) == 0) 
  // {
  //   cprintf("unable to open aslr_flag file, default to no randomize\n");
  // } 
  // else 
  // {
  //   ilock(ip);
  //   if (readi(ip,&c[0], 0, sizeof(char)) != sizeof(char)) 
  //   {
  //     cprintf("unable to read aslr flag, default to no randomize\n");
  //   } 
  //   // else 
  //   // {
  //   //   aslr = (c[0] == '1')? 1 : 0;
  //   // }
  //   iunlockput(ip);
  // }
  ip = namei("aslr_flag");
  ilock(ip);
  readi(ip,&c[0], 0, sizeof(char));
  iunlockput(ip);
  if(c[0]-'1'==0)
  {
    aslr=1;
  }
  // cprintf("aslr defined is %d\n",aslr);

  if((ip = namei(path)) == 0){
    end_op();
    cprintf("exec: fail\n");
    return -1;
  }
  ilock(ip);
  pgdir = 0;
  
  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) != sizeof(elf))
    goto bad;
  if(elf.magic != ELF_MAGIC)
    goto bad;

  if((pgdir = setupkvm()) == 0)
    goto bad;

  // Load program into memory.
  uint random_lookahead = 0;
  if(aslr==1)
  {
    random_lookahead=(uint)randomrange(500,4000);
  }
  // cprintf("the random no generated is,%d\n",random_lookahead);
  sz=0;
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph))
  {
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
      goto bad;
    if(ph.type != ELF_PROG_LOAD)
      continue;
    if(ph.memsz < ph.filesz)
      goto bad;
    if(ph.vaddr + ph.memsz < ph.vaddr)
      goto bad;
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz+random_lookahead)) == 0)  //add offset
      goto bad;
    if(ph.vaddr % PGSIZE != 0)
      goto bad;
    if(loaduvm(pgdir, (char*)(ph.vaddr+random_lookahead), ip, ph.off, ph.filesz) < 0)  //add offset
      goto bad;
  }
  iunlockput(ip);
  end_op();
  ip = 0;

  // Allocate two pages at the next page boundary.
  // Make the first inaccessible.  Use the second as the user stack.
  sz = PGROUNDUP(sz);
  uint rr=0;
  if(aslr==1)
    rr=randomrange(0,10);

  if((sz = allocuvm(pgdir, sz, sz + (2+rr)*PGSIZE)) == 0)
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
    if(argc >= MAXARG)
      goto bad;
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
      goto bad;
    ustack[3+argc] = sp;
  }
  ustack[3+argc] = 0;

  ustack[0] = 0xffffffff;  // fake return PC
  ustack[1] = argc;
  ustack[2] = sp - (argc+1)*4;  // argv pointer

  sp -= (3+argc+1) * 4;
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
    goto bad;

  // Save program name for debugging.
  for(last=s=path; *s; s++)
    if(*s == '/')
      last = s+1;
  safestrcpy(curproc->name, last, sizeof(curproc->name));

  // Commit to the user image.
  oldpgdir = curproc->pgdir;
  curproc->pgdir = pgdir;
  curproc->sz = sz;
  curproc->tf->eip = elf.entry+random_lookahead;  // main
  curproc->tf->esp = sp;
  switchuvm(curproc);
  freevm(oldpgdir);
  return 0;

 bad:
  if(pgdir)
    freevm(pgdir);
  if(ip){
    iunlockput(ip);
    end_op();
  }
  return -1;
}
