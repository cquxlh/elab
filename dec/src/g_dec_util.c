#include "g_dec_internal.h"


void util_message_packet_create(char **buf,
				int32_t type,
				char *data,
				int32_t size){

  int32_t len=COM_HEADER_SIZE+size;
  
  *buf = (char*)malloc(len);
  assert(*buf);
  
  memcpy(*buf,    &type, 4);
  memcpy(*buf+8,  &size, 4);
  memcpy(*buf+12, data, size);
}

int util_mkdir_with_path(char *path){
  return g_mkdir_with_parents(path, 0755);
}

int util_fetch_single_file(char **task_file,
			   char *path){
  
  GDir *dir=g_dir_open(path, 0, NULL);
  
  if(!dir)
    return G_ERROR;

  *task_file = g_dir_read_name(dir);
  g_dir_close(dir);

  
  if(!*task_file)
    return G_ERROR;

  return G_OK;
}

int util_load_file(char **data, 
		   int32_t *size,
		   char *full_file_path){

  FILE *fp = NULL;

  fp = fopen(full_file_path, "r+");
  if(!fp)
    return G_ERROR;

  fseek(fp, 0, SEEK_END);
  *size = ftell(fp);
  fseek(fp,0,SEEK_SET);

  *data = (char*)malloc(*size);
  if(*size != read(fp, *data, *size)){
    free(*data);
    fclose(fp);
    *data = NULL;
    return G_ERROR;
  }
  
  fclose(fp);
  return G_OK;
}
