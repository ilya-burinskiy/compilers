#include "lexer.h"

int main(int argc, char ** argv) {
  if (argc >= 2) {
    scan_file(argv[1]);
  } else {
    scan_tokens();
  }
  return 0;
}
