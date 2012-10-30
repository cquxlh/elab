#include "g_dec_internal.h"
#include "g_dec_serv.h"



DEC_SERVER_CONNECTION dec_server_connection_init(struct bufferevent *bev,
						 int32_t fd,
						 DEC_SERVER server){
  DEC_SERVER_CONNECTION conn=NULL;

  conn=(DEC_SERVER_CONNECTION)malloc(sizeof(struct _dec_server_connection));
  if (!conn)
    return NULL;

  conn->fd=fd;
  conn->server=server;
  conn->bev=bev;
  conn->heartbeat=time(0);
  
  conn->app_name=g_string_new("");
  if(!conn->app_name){
    free(conn);
    return NULL;
  }
  return conn;
}

void dec_server_connection_free(DEC_SERVER_CONNECTION conn){

  bufferevent_disable(conn->bev, EV_READ|EV_WRITE);
  bufferevent_free(conn->bev);
  g_string_free(conn->app_name, TRUE);
  free(conn);
}

void dec_server_worker_add_by_fd(DEC_SERVER server,
				 int32_t fd,
				 DEC_SERVER_CONNECTION conn){
  g_hash_table_insert(server->fd2worker, (void*)&fd, (void*)conn);
}

void dec_server_worker_remove_by_fd(DEC_SERVER server,
				    DEC_SERVER_CONNECTION conn){
    g_hash_table_remove(server->fd2worker, &conn->fd);
    dec_server_connection_free(conn);
}

static void dec_server_net_event_callback(struct bufferevent *bev, 
					  short what, 
					  void *p){
  DEC_SERVER server=(DEC_SERVER)p;
  DEC_SERVER_CONNECTION conn=NULL;
  int fd;

  fd = bufferevent_getfd(bev);
  printf("Got an event in net server: %s\n",
	 evutil_socket_error_to_string(EVUTIL_SOCKET_ERROR()));
  
  if (what & (BEV_EVENT_EOF|BEV_EVENT_ERROR)) {
    if (what & BEV_EVENT_ERROR) {
      if (errno)
	perror("connection error");
    }
    conn=g_hash_table_lookup(server->fd2worker, &fd);
    if(conn)
      dec_server_worker_remove_by_fd(server, conn);
  }
}

static void dec_server_net_message_read_callback(struct bufferevent *bev,
						  void *p){
  DEC_SERVER server=(DEC_SERVER)p;
  struct evbuffer *src=NULL;
  size_t len=0;
  int32_t size=0, type=0;
  unsigned char *src_buffer=NULL, head[12]={0};
  

  src=bufferevent_get_input(bev);
  len=evbuffer_get_length(src);

  while(len>=COM_HEADER_SIZE){

    /* read the package header */
    if(COM_HEADER_SIZE!=bufferevent_read(bev, head, COM_HEADER_SIZE))
      return;

    type=*(int32_t*)head;
   
    /* skip 4 bytes' padding */
    size=*(int32_t*)((char*)head+2*sizeof(int32_t));
   
    printf("recv net message from fd:%d, ", bufferevent_getfd(bev));
    printf("total size:%d, command type:%d, data size:%d\n", (int)len, (int)type, (int)size);
    if(size > (int32_t)len)
      return;

    
    if(size > 0){
      /* read the command body */
      src_buffer=(unsigned char*)malloc((size+1)*sizeof(char));
      memset(src_buffer, 0, size+1);
      if (size!=(int32_t)bufferevent_read(bev, src_buffer, size*sizeof(char))){
	free(src_buffer);
	return;
      }
    }

    /* process the command */
    if(dec_server_net_message_process(server, bev, type, src_buffer, size) != G_OK){
       free(src_buffer);
       return;
    }
    
    free(src_buffer);
  
    src = bufferevent_get_input(bev);
    len = evbuffer_get_length(src);
  }
}



int dec_server_net_message_process(DEC_SERVER server,
				    struct bufferevent *bev,
				    int32_t type,
				    void *data,
				    int32_t size){
  DEC_SERVER_CONNECTION conn=NULL;
  int32_t fd=-1;
  char *buf=NULL;


  fd = bufferevent_getfd(bev);

  switch(type){
  case COM_W_REGISTER:

    /* create a new connection and add to worker table */
    conn=dec_server_connection_init(bev, fd, server);
    assert(conn);
    dec_server_worker_add_by_fd(server, fd, conn);

    /* get application name */
    g_string_append_len(conn->app_name, (char*)data, size);
    printf("----COM_W_REGISTRE---\napp_name:%s\n\n", conn->app_name->str);

    /* send back a confirm information */
    message_packet_create((char**)&buf, (int32_t)COM_S_OK, (char*)NULL, (int32_t)0);
    bufferevent_write(bev, buf, COM_HEADER_SIZE);
    //free(buffer);
    break;
  default:
    return G_ERROR;
  }
  
  return G_OK;
}



static void dec_server_accept_incoming_request_callback(struct evconnlistener *listener, 
							evutil_socket_t fd,
							struct sockaddr *addr, 
							int slen, 
							void *p){
  DEC_SERVER server=(DEC_SERVER)p;
  struct bufferevent *bev=NULL;
  
 

  bev=bufferevent_socket_new(server->base, 
			     fd,
			     BEV_OPT_CLOSE_ON_FREE|BEV_OPT_DEFER_CALLBACKS|LEV_OPT_THREADSAFE);

  assert(bev);

  bufferevent_setcb(bev, 
		    dec_server_net_message_read_callback,
		    NULL, 
		    dec_server_net_event_callback,
		    server);
  
  bufferevent_enable(bev, EV_READ|EV_WRITE);

  printf("----CONNECTING----\nconnection fd:%d\n\n", fd);
}


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
  if(evutil_socketpair(AF_UNIX, SOCK_STREAM, 0, fds)!=0)
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
  server->port = atoi(port);
  server->net_listener=evconnlistener_new_bind(server->base, 
					       dec_server_accept_incoming_request_callback,
					       server,
					       LEV_OPT_CLOSE_ON_FREE|LEV_OPT_CLOSE_ON_EXEC|LEV_OPT_REUSEABLE|LEV_OPT_THREADSAFE,
					       -1,
					       (const struct sockaddr*)server->net_addr, 
					       addr_len);

  server->fd2worker = g_hash_table_new(g_int_hash, g_int_equal);
  if(!server->fd2worker)
    return NULL;


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
