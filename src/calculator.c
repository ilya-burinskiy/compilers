#include <stdio.h>
#include <stdlib.h>
#include "lexer.h"
#include "parser.h"
#include "abstract_syntax.h"
#include "ast_printer.h"

int main(int argc, char ** argv) {
  Statement * root = NULL;

  if (argc >= 2) {
    FILE * fp = fopen(argv[1], "r");
    if (!fp) {
      perror("Can not open file");
      exit(EXIT_FAILURE);
    } else {
      yy_switch_to_buffer(yy_create_buffer(fp, YY_BUF_SIZE));
      yyparse(&root);
      fclose(fp);
    }
  } else {
    yyparse(&root);
  }

  if (root != NULL) {
    print_ast(root, root->type);
  }
  return 0;
}
