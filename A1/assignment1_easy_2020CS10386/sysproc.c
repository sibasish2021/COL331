#include "types.h"
#include "x86.h"
#include "defs.h"
#include "date.h"
#include "param.h"
#include "memlayout.h"
#include "mmu.h"
#include "proc.h"
#include "spinlock.h"

extern enum toggle_state {TRACE_OFF,TRACE_ON} trace;
extern char* scnames[];
extern int numsc;
extern int sysCnts[];

struct frequency{
  char* sysname;
  int syscount;
};

char msgBuffer[NPROC][8000];
int pr[NPROC]={0};
int pw[NPROC]={0};

int
sys_fork(void)
{
  return fork();
}

int sys_add(void)
{
  int x,y;
  argint(0,&x);
  argint(1,&y);
  return x+y;
}
int min(int l1,int l2)
{
  if(l1<l2)
  return l1;
  else
  return l2;
}
int compare(char* c1,char* c2)
{
  // for(int i=0;i<1000;i++)
  // {
  //   for(int j=0;j<1000;j++)
  //   {
  //     for(int k=0;k<1000;k++);
  //   }
  // }
  int i=0;
  while(1==1)
  {
    if(c1[i]==0 && c2[i]==0)
    {
      return 0;
    }
    if(c1[i]==0)
    {
      return -1;
    }
    if(c2[i]==0)
    {
      return 1;
    }
    if(c1[i]<c2[i])
    {
      return -1;
    }
    if(c1[i]>c2[i])
    {
      return 1;
    }
    i++;
  }
}

int sys_print_count(void)
{
  int n=numsc;
  struct frequency f[n];
  for(int i=0;i<n;i++)
  {
    f[i].sysname=scnames[i];
    f[i].syscount=sysCnts[i];
  }
  for(int i=0;i<n;i++)
  {
    struct frequency temp,m;
    m=f[i];
    int c=i;
    for(int j=i+1;j<n;j++)
    {
      if(compare(f[j].sysname,m.sysname)<0)
      {
        m=f[j];
        c=j;
      }
    }
    temp=f[i];
    f[i]=f[c];
    f[c]=temp;
  }  
  // cprintf("Answer for comparision %s %s %s %s\n",f[0].sysname,f[1].sysname,f[2].sysname,f[3].sysname);
  // for(int i=0;i<1000;i++)
  // {
  //   for(int j=0;j<1000;j++)
  //   {
  //     for(int k=0;k<1000;k++);
  //   }
  // }
  for(int i=0;i<numsc;i++)
  {
    if(f[i].syscount>0 && compare(f[i].sysname,"sys_print_count")!=0)
      cprintf("%s %d\n",f[i].sysname,f[i].syscount);
  }
  return 0;
}

// for(int i=0;i<1000;i++)
  // {
  //   for(int j=0;j<1000;j++)
  //   {
  //     for(int k=0;k<1000;k++);
  //   }
  // }
int sys_toggle(void)
{
  if(trace==TRACE_ON)
  {
    trace=TRACE_OFF;
    // cprintf("Tggle is now set to trace off \n");
  }
  else if(trace==TRACE_OFF)
    {
      trace=TRACE_ON;
      // cprintf("Tggle is now set to trace on \n");
      int i=0;
      while(i!=numsc)
      {
        sysCnts[i]=0;
        i++;
      }
    }
  return 0;    
}
extern void proc_state(void);
// for(int i=0;i<1000;i++)
  // {
  //   for(int j=0;j<1000;j++)
  //   {
  //     for(int k=0;k<1000;k++);
  //   }
  // }
int sys_ps(void)
{
  proc_state();
  return 0;
}
// for(int i=0;i<1000;i++)
  // {
  //   for(int j=0;j<1000;j++)
  //   {
  //     for(int k=0;k<1000;k++);
  //   }
  // }


struct spinlock lock;
int sys_send(int sender_pid, int rec_pid, void *msg)
{
  char* m;
  while(argint(0,&sender_pid))
  return -1;
  while(argint(1,&rec_pid))
  return -1;
  while(argptr(2,&m,8))
  return -1;
  // cprintf("Hello");
  acquire(&lock);
  //locking to ensure safety of write read
  // for(int i=0;i<1000;i++)
  // {
  //   for(int j=0;j<1000;j++)
  //   {
  //     for(int k=0;k<1000;k++);
  //   }
  // }
  for(int i=0;i<8;i++)
  {
    msgBuffer[rec_pid][pw[rec_pid]]=*(m+i);
    pw[rec_pid]=(pw[rec_pid]+1)%8000;
  }
  // cprintf("Hello1");
  release(&lock);
  // cprintf("Message sent%d %d %d\n",rec_pid,pw[rec_pid],pr[rec_pid]);
  return 0;
}
int sys_send_multi(int sender_pid, int rec_pids[], void *msg)
{
  char* m;
  int* recp;
  if(argint(0,&sender_pid))
  return -1;
  if(argptr(1,(char**)&recp,64))
  return -1;
  if(argptr(2,&m,8))
  return -1;
  // cprintf("Hello");
  // for(int i=0;i<8;i++)
  // {
  //   cprintf("The ID of receiver is %d \n",recp[i]);
  // }
  acquire(&lock);
  for(int i=0;i<8;i++)
  {
    while(recp[i]<0){
      release(&lock);
      return 0;
    }
    for(int j=0;j<8;j++)
    {
      msgBuffer[recp[i]][pw[recp[i]]]=*(m+j);
      pw[recp[i]]=(pw[recp[i]]+1)%8000;
    }
  }
  release(&lock);
  return 0;
}
// for(int i=0;i<1000;i++)
  // {
  //   for(int j=0;j<1000;j++)
  //   {
  //     for(int k=0;k<1000;k++);
  //   }
  // }
int sys_recv(void *msg)
{
  
  char *m;
  if(argptr(0,&m,8)<0)
  return -1;
  // cprintf("Reached 1 %d\n",rec_pid);
  int rec_pid=myproc()->pid;
  // cprintf("Reached 1 %d\n",rec_pid);
  acquire(&lock);
  // cprintf("Reached 1 %d\n",rec_pid);
  while(pr[rec_pid]==pw[rec_pid])
  {
    release(&lock);
    return -1;
  }
  // cprintf("Reached 1 %d\n",rec_pid);
  for(int i=0;i<8;i++)
  {
    *(m+i)=msgBuffer[rec_pid][pr[rec_pid]];
    pr[rec_pid]=(pr[rec_pid]+1)%8000;
  }
  // cprintf("Reached 1 %d\n",rec_pid);
  release(&lock);
  // cprintf("Reached 1 %d\n",rec_pid);
  return 0;
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
