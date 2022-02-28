#include <stdio.h>
#include <stdlib.h>
#include "lexer.h"

int yyparse(void);

int main(int argc, char ** argv) {
  if (argc >= 2) {
    FILE * fp = fopen(argv[1], "r");
    if (!fp) {
      perror("Can not open file");
      exit(EXIT_FAILURE);
    } else {
      yy_switch_to_buffer(yy_create_buffer(fp, YY_BUF_SIZE));
      yyparse();
      fclose(fp);
    }
  } else {
    yyparse();
  }
  return 0;
}
