#ifndef G_DEC_INTERNAL_H
#define G_DEC_INTERNAL_H

#ifdef __cplusplus
extern "C" {
#endif

#include <glib.h>
#include <stdio.h>
#include <stdlib.h>
#include <event2/bufferevent.h>
#include <event2/buffer.h>
#include <event2/listener.h>
#include <event2/util.h>

/* message header info */
#define W_REGISTER 0
#define R_REGISTER 1
#define W_BEAT 2
#define R_BEAT 3

#define S_OK 4
#define S_ERROR 5
#define W_OK 6
#define W_ERROR 7
#define R_OK 8
#define R_ERROR 9


#ifdef __cplusplus
}
#endif

#endif
