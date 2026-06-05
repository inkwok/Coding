#include <pthread.h>
#include <stdio.h>

void*
foo(void* arg)
{
    
}

int
main(void)
{
  pthread_t thread1;
  pthread_create(&thread1, NULL, foo, NULL);
}
