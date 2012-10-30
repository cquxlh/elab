
DEC_WORKER g_dec_worker_init(char *serv_ip,
			     char *serv_port,
			     char *app_name);

void g_dec_worker_start(DEC_WORKER server);

void g_dec_worker_free(DEC_WORKER server);
