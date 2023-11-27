#include "types.h"
#include "stat.h"
#include "user.h"
#include "spinlock.h"

void print_variance(float xx)
{
 int beg=(int)(xx);
 int fin=(int)(xx*100)-beg*100;
 printf(1, "Variance of array for the file arr is %d.%d", beg, fin);
}

int
main(int argc, char *argv[])
{
	if(argc< 2){
		printf(1,"Need type and input filename\n");
		exit();
	}
	char *filename;
	filename=argv[2];
	int type = atoi(argv[1]);
	printf(1,"Type is %d and filename is %s\n",type, filename);

	int tot_sum = 0;	

	int size=1000;
	short arr[size];
	char c;
	int fd = open(filename, 0);
	for(int i=0; i<size; i++){
		read(fd, &c, 1);
		arr[i]=c-'0';
		read(fd, &c, 1);
	}	
  	close(fd);
  	// this is to supress warning
  	// printf(1,"first elem %d\n", arr[0]);
    // struct spinlock lock;
  	//----FILL THE CODE HERE for unicast sum
	int parentID=getpid();
	// int sum=0;
	int child[8];
	int pid,cnt=0;
	float svar=0.0;
	for(int i=0;i<8;i++)
	{
		pid=fork();
		if(pid==0)
		{
			break;
		}
		child[i]=pid;
		cnt++;
	}
	// printf(1,"useless%d\n",child[0]);
	if(pid!=0)
	{
		//Parent
		for(int i=0;i<8;i++)
		{
			int status=-1;
			int psum;
			while(status==-1)
			{
				status=recv(&psum);		
			}
			// printf(1,"Parent ID is %d\n",getpid());
			tot_sum=tot_sum+psum;
		}
		if(type==1)
		{
			float mean=1.0*tot_sum/1000;
			int child1[]={child[0],child[1],child[2],child[3],child[4],child[5],child[6],child[7]};
			send_multi(getpid(),child1,&mean);
			for(int i=0;i<8;i++)
			{
				int status=-1;
				float pvar;
				while(status==-1)
				{
					status=recv(&pvar);		
				}
				// printf(1,"pvar is %d\n",(int)pvar);
				svar=svar+pvar;
			}
		}
		for(int i=0;i<8;i++)
		{
			wait();
		}	
	}
	else
	{
		// printf(1,"Count is %d %d\n",cnt,getpid());
		int psum=0;
		for(int j=cnt*125;j<(cnt+1)*125;j++)
		{
			psum=psum+arr[j];
		}
		int status=-1;
		while(status==-1)
		{
			status=send(getpid(),parentID,&psum);
		}
		if(type==1)
		{
			float mean;
			status=-1;
			while(status==-1)
			{
				status=recv(&mean);
			}
			// printf(1,"Mean is %d\n",(int)mean);
			float pvar=0.0;
			for(int j=cnt*125;j<(cnt+1)*125;j++)
			{
				pvar=pvar+(mean-arr[j])*(mean-arr[j]);
			}
			status=-1;
			while(status==-1)
			{
				status=send(getpid(),parentID,&pvar);
			}
		}
		exit();
	}
    if(type==0){ //unicast sum
		printf(1,"Sum of array for file %s is %d\n", filename,tot_sum);
		exit();
	}
	if(type==1){ //unicast sum
		print_variance(svar/1000);
		exit();
	}
}
