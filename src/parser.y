%{
#include <stdio.h>
#include <stdlib.h>
#include "lexer.h"
#include "abstract_syntax.h"

void yyerror(Statement ** root, const char * msg) {
  fprintf(stderr, "In line %d: %s\n", yyget_lineno(), msg);
}
%}

%code requires {
  #include "abstract_syntax.h"
}

%union { Statement * stmt; }
%parse-param { Statement ** root }

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

%start prog
%%
prog : stmt

stmt : stmt NEW_LINE stmt
     | assign
     | expr
     | %empty
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
     | ERROR { yyerror(root, "syntax error"); exit(EXIT_FAILURE); }
     | LPARENT expr RPARENT
     ;
call : IDENTIFIER LPARENT optparams RPARENT
     ;
optparams : params
          | %empty
          ;
params : params COMMA param
       | param
       ;
param : expr
      ;
%%
