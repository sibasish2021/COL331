#include "types.h"
#include "stat.h"
#include "user.h"

int main()
{
    int a=toggle();
    if(a==0)
    {
        printf(1,"Toggle successfull");
    }
    a=toggle();
    exit();
}