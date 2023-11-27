#include "types.h"
#include "stat.h"
#include "user.h"

int main(int argc,char *argv[])
{
    printf(1,"Result is %d\n",add(atoi(argv[1]),atoi(argv[2])));
    exit();
}