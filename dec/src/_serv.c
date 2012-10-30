#include <stdio.h>
#include <stdlib.h>

#include "dec.h"

int main(){

    DEC_SERVER server=NULL;

    server = g_dec_server_init("9000");
    if(!server){
	printf("dec server init error\n");
	return 1;
    }

    g_dec_server_start(server);
    return 0;
}
