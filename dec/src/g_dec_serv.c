#include "g_dec_internal.h"
#include "dec.h"

DEC_SERVER g_dec_server_init(char* port){
  evutil_socket_t fds[2];
  int32_t addr_len=0;

  DEC_SERVER server= (struct _dec_server*)malloc(sizeof(struct _dec_server));
  if(!server)
    return NULL;

  server->base=event_base_new();
  if(!server->base)
    return NULL;

  /* set local event */
  if(evutil_socketpair(AF_INET, SOCK_STREAM, 0, fds)!=0)
    return NULL;
  
  server->local_rfd=fds[0];
  server->local_wfd=fds[1];

  server->local_bev=bufferevent_socket_new(server->base, 
					   server->local_rfd,
					   BEV_OPT_CLOSE_ON_FREE|BEV_OPT_DEFER_CALLBACKS);

  if(!server->local_bev)
    return NULL;

  bufferevent_setcb(server->local_bev, 
		    NULL,
		    NULL, 
		    NULL,
		    server);

  bufferevent_enable(server->local_bev, EV_READ|EV_WRITE);

  /* set incoming net event */
  server->net_addr=malloc(sizeof(struct sockaddr_storage));
  if(!server->net_addr)
    return NULL;


  addr_len=sizeof(struct sockaddr_storage);
  if(evutil_parse_sockaddr_port(port,
				 (struct sockaddr*)server->net_addr, &addr_len)<0){
    int32_t p = atoi(port);
    struct sockaddr_in *sin = (struct sockaddr_in*)server->net_addr;
    sin->sin_port = htons(p);
    sin->sin_addr.s_addr = INADDR_ANY;
    sin->sin_family = AF_INET;
    addr_len = sizeof(struct sockaddr_in);
  }

  server->net_listener=evconnlistener_new_bind(server->base, 
					       NULL,
					       server,
					       LEV_OPT_CLOSE_ON_FREE|LEV_OPT_CLOSE_ON_EXEC|LEV_OPT_REUSEABLE|LEV_OPT_THREADSAFE,
					       -1,
					       (const struct sockaddr*)server->net_addr, 
					       addr_len);

  return server;
}


void g_dec_server_start(DEC_SERVER server){
  event_base_dispatch(server->base);
}


void g_dec_server_free(DEC_SERVER server){

  evconnlistener_free(server->net_listener);
  
  event_base_free(server->base);  

  free(server->net_addr);  
  free(server);
}
