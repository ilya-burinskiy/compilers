#include <stdio.h>
#include <stdlib.h>
#include "lexer.h"

void scan_file(const char * fname);

int main(int argc, char ** argv) {
  if (argc >= 2) {
    scan_file(argv[1]);
  } else {
    scan_tokens();
  }
  return 0;
}

void scan_file(const char * fname) {
  FILE * fp = fopen(fname, "r");
  if (!fp) {
    perror("Can not open the file");
    exit(1);
  } else {
    yy_switch_to_buffer(yy_create_buffer(fp, YY_BUF_SIZE));
    scan_tokens();
    fclose(fp);
  }
}
