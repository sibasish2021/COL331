#include "types.h"
#include "x86.h"
#include "defs.h"
#include "date.h"
#include "param.h"
#include "memlayout.h"
#include "mmu.h"
#include "proc.h"
#include "spinlock.h"

int
sys_fork(void)
{
  return fork();
}

int
sys_exit(void)
{
  exit();
  return 0;  // not reached
}

int
sys_wait(void)
{
  return wait();
}

int
sys_kill(void)
{
  int pid;

  if(argint(0, &pid) < 0)
    return -1;
  return kill(pid);
}

int
sys_getpid(void)
{
  return myproc()->pid;
}

int
sys_sbrk(void)
{
  int addr;
  int n;

  if(argint(0, &n) < 0)
    return -1;
  addr = myproc()->sz;
  if(growproc(n) < 0)
    return -1;
  return addr;
}

int
sys_sleep(void)
{
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
    return -1;
  acquire(&tickslock);
  ticks0 = ticks;
  while(ticks - ticks0 < n){
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
  return 0;
}

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
  uint xticks;

  acquire(&tickslock);
  xticks = ticks;
  release(&tickslock);
  return xticks;
}


// code for scheduling policy
int sys_sched_policy(void){
  int id;
  int pnum;
  argint(0,&id);
  argint(1,&pnum);
  int a;
  a=sched_policy(id,pnum);
  if(a==0) return 0;
  // exit();
  kill(id);
  return -22;
}

int sys_exec_time(void){
  int id;
  int exec_tim;
  argint(0,&id);
  argint(1,&exec_tim);
  int a;
  a=exec_time(id,exec_tim);
  if(a==0) return 0;
  return -22;
}

int sys_deadline(void){
  int id;
  int deadlin;
  argint(0,&id);
  argint(1,&deadlin);
  int a;
  a=deadline(id,deadlin);
  if(a==0) return 0;
  return -22;
}

int sys_rate(void){
  int id;
  int rat;
  argint(0,&id);
  argint(1,&rat);
  int a;
  a=rate(id,rat);
  if(a==0) return 0;
  return -22;
}


int sys_random(void){
  int rand_no;
  rand_no=random();
  cprintf("%d",rand_no);
  return 0;
}
