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
%token END

%left LOR LXOR
%%
statements : statements statement '\n'
           | statements '\n'
           | /* empty */

statement : IDENTIFIER ASSIGN expr
          | expr
expr : expr LOR expr
     | expr LXOR expr
     | expr LAND expr
     | neg
     | call
     | TRUE
     | FALSE
     | IDENTIFIER

neg : LNOT LPARENT expr RPARENT
call : IDENTIFIER LPARENT optparams RPARENT
optparams : params | /* empty */
params : params COMMA param | param
param : expr
%%
