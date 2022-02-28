#include <stdio.h>
#include <stdlib.h>
#include "tokens.h"
#include "lexer.h"

int main(int argc, char ** argv) {
  int token = 0;

  if (argc >= 2) {
    FILE * fp = fopen(argv[1], "r");
    if (!fp) {
      perror("Can not open file");
      exit(EXIT_FAILURE);
    } else {
      yy_switch_to_buffer(yy_create_buffer(fp, YY_BUF_SIZE));
      fclose(fp);
    }
  } else {
  }
  return 0;
}
