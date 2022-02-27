#pragma once
#include <stdio.h>

struct yy_buffer_state;
#define YY_TYPEDEF_YY_BUFFER_STATE
typedef struct yy_buffer_state * YY_BUFFER_STATE;

#define YY_BUF_SIZE 16384

YY_BUFFER_STATE yy_create_buffer(FILE * file, int size);
void yy_switch_to_buffer(YY_BUFFER_STATE new_buffer);

#define YY_DECL int scan_token()
int scan_token();
