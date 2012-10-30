#include "g_dec_internal.h"
#include "g_dec_worker.h"



static void dec_worker_net_message_read_callback(struct bufferevent *bev,
						 void *p){
  DEC_WORKER server=(DEC_WORKER)p;

}


DEC_WORKER g_dec_worker_init(char *serv_ip,
			     char *serv_port,
			     char *app_name){
  evutil_socket_t fds[2];
  struct sockaddr_in sin;
  char *buf=NULL;

  DEC_WORKER worker= (struct _dec_worker*)malloc(sizeof(struct _dec_worker));
  if(!worker)
    return NULL;
  
  
  worker->base=event_base_new();
  if(!worker->base)
    return NULL;

  /* set local event */
  if(evutil_socketpair(AF_UNIX, SOCK_STREAM, 0, fds)!=0)
    return NULL;
  
  worker->local_rfd=fds[0];
  worker->local_wfd=fds[1];

  worker->local_bev=bufferevent_socket_new(worker->base, 
					   worker->local_rfd,
					   BEV_OPT_CLOSE_ON_FREE|BEV_OPT_DEFER_CALLBACKS);

  if(!worker->local_bev)
    return NULL;


  bufferevent_setcb(worker->local_bev, 
		    dec_worker_net_message_read_callback,
		    NULL, 
		    NULL,
		    worker);

  bufferevent_enable(worker->local_bev, EV_READ|EV_WRITE);

 
  message_packet_create((char**)&buf, COM_W_REGISTER, app_name, strlen(app_name));
  /* set server connection */
  memset(&sin, 0, sizeof(sin));
  if((sin.sin_port=htons(atoi(serv_port))) == 0)
    return NULL;

  if((sin.sin_addr.s_addr=inet_addr(serv_ip)) == 0xffffffff)
    return NULL;

  
  
  if((worker->fd=socket(AF_INET, SOCK_STREAM, 0)) < 0)
    return NULL;

  if(evutil_make_socket_nonblocking(worker->fd) < 0)
    return NULL;

  if(connect(worker->fd,
	     (struct sockaddr*)&sin,
	     sizeof(sin)) < 0){
    /* connection can be retried later */
    if(errno != EINTR && errno != EINPROGRESS)
      return NULL;
  }
  
  //write(worker->fd, buf, COM_HEADER_SIZE+strlen(app_name));

  worker->bev=bufferevent_socket_new(worker->base,
				     worker->fd,
				     BEV_OPT_CLOSE_ON_FREE|BEV_OPT_DEFER_CALLBACKS);

  if(!worker->bev)
    return NULL;

  bufferevent_setcb(worker->bev,
		    NULL,
		    NULL,
		    NULL,
		    worker);

  bufferevent_enable(worker->bev, EV_READ|EV_WRITE);
  
  
  worker->app_name = g_string_new("");
  if(!worker->app_name)
    return NULL;
  
  g_string_append_len(worker->app_name, app_name, strlen(app_name));
  
  /* send register message */
  
  printf("%p\n", buf);
  bufferevent_write(worker->bev, buf, COM_HEADER_SIZE+strlen(app_name));
  // return NULL;
  
  //free(buf);
  return worker;
}


void g_dec_worker_start(DEC_WORKER worker){
  event_base_dispatch(worker->base);
}
