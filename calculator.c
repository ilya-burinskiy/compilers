#include <stdio.h>

int scan_tokens();

int main(int argc, char ** argv) {
  if (argc >= 2) {
    extern FILE * yyin;
    yyin = fopen(argv[1], "r");
  }
  scan_tokens();
  return 0;
}
