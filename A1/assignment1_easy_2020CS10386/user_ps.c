#include "types.h"
#include "stat.h"
#include "user.h"

int main()
{
    int a=ps();
    if(a==0)
    {
        printf(1,"System mcall successfull \n");
    }
    exit();
}