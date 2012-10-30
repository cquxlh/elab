#include <stdio.h>
#include <stdlib.h>
#include "dec.h"

int main(){
  DEC_WORKER worker=NULL;

  worker = g_dec_worker_init("127.0.0.1", "9000", "app1");
  if(!worker){
    printf("dec worker init error\n");
    return 1;
  }
  g_dec_worker_start(worker);
  
  return 0;
}
