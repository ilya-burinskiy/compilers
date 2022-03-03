%{
#include <stdio.h>
#include <stdlib.h>
#include "lexer.h"

int yyget_lineno(void);

void yyerror(const char * msg) {
  fprintf(stderr, "In line %d: %s\n", yyget_lineno(), msg);
}
%}

%token FALSE
%token TRUE
%token IDENTIFIER
%token LPARENT
%token RPARENT
%token COMMA
%token ASSIGN
%token LOR
%token LAND
%token LXOR
%token LNOT
%token ERROR
%token NEW_LINE

%left LOR LXOR
%left LAND
%precedence LNOT

%%
stmts : stmts stmt NEW_LINE
      | /* empty */
      ;
stmt : assign
     | expr
     ;
assign : IDENTIFIER ASSIGN expr
       ;
expr : expr LOR expr
     | expr LXOR expr
     | expr LAND expr
     | LNOT expr
     | call
     | TRUE
     | FALSE
     | IDENTIFIER
     | ERROR { yyerror("syntax error"); exit(EXIT_FAILURE); }
     | LPARENT expr RPARENT
     ;
call : IDENTIFIER LPARENT optparams RPARENT
     ;
optparams : params
          | /* empty */
params : params COMMA param
       | param
       ;
param : expr
      ;
%%
