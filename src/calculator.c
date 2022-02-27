#include <stdio.h>
#include <stdlib.h>
#include "tokens.h"
#include "lexer.h"

void scan_routine();

int main(int argc, char ** argv) {
  int token = 0;

  if (argc >= 2) {
    FILE * fp = fopen(argv[1], "r");
    if (!fp) {
      perror("Can not open file");
      exit(EXIT_FAILURE);
    } else {
      yy_switch_to_buffer(yy_create_buffer(fp, YY_BUF_SIZE));
      scan_routine();
      fclose(fp);
    }
  } else {
    scan_routine();
  }
  return 0;
}

void scan_routine() {
  int token = 0;
  do {
    token = yylex();
    printf("Token id: %d\n", token);
  } while (token != END);
}
