
/* only works in linux/unix system */
#define evutil_socket_t int

typedef struct _dec_server *DEC_SERVER;
typedef struct _dec_server_connection *DEC_CONNECTION;

/* struct defined in event2 */
struct event_base;
struct evconlistener;
struct bufferevent;

/* struct defined in glib.h */
struct GQueue;
struct GHashTable;
struct GString;

/* node information triggered by event */
struct _dec_server_connection{
  int32_t fd;

  struct bufferevent *bev;

  DEC_SERVER server;
};

struct _dec_server{

  /* event loop manager */
  struct event_base *base;
  
  /* for local msg */
  struct bufferevent *local_bev;
  evutil_socket_t local_rfd;
  evutil_socket_t local_wfd;

  /* incoming msg listener */
  struct evconlistener *net_listener;
  struct sockaddr_storage *net_addr;
  int32_t port;


  /* map from file description to connection*/
  struct GHashTable *fd2conn;

  /* for writing log */
  FILE *fp_log;
};
