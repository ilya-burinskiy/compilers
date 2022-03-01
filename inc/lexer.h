#pragma once
#include <stdio.h>

#ifndef YY_TYPEDEF_YY_BUFFER_STATE
#define YY_TYPEDEF_YY_BUFFER_STATE
typedef struct yy_buffer_state * YY_BUFFER_STATE;
#endif

#ifndef YY_BUF_SIZE
#define YY_BUF_SIZE 16384
#endif

YY_BUFFER_STATE yy_create_buffer(FILE * file, int size);
void yy_switch_to_buffer(YY_BUFFER_STATE new_buffer);

int yylex(void);
