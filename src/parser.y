%{
#include <stdio.h>
#include "lexer.h"

void yyerror(const char * msg) {
  fprintf(stderr, "%s\n", msg);
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
     | ERROR
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