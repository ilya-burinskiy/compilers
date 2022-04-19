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

%type <stmt> stmt

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
/* For preserving reduce derivation in case stmt NEW_LINE stmt • NEW_LINE
Reduce derivation
  stmt
  ↳ 2: stmt                      NEW_LINE stmt
        ↳ 2: stmt NEW_LINE stmt •          ↳ 2: ε */
%left NEW_LINE
%precedence LNOT

%start prog
%%
prog : stmt { *root = $1; }

stmt : stmt NEW_LINE stmt
     {
       Statement * stmt = (Statement *) malloc(sizeof(Statement));
       stmt->type = COMPOUND_STMT;
       stmt->u.compound.stmt1 = $1;
       stmt->u.compound.stmt2 = $3;
       $$ = stmt;
     }
     | assign { $$ = NULL; }
     | expr { $$ = NULL; }
     | %empty { $$ = NULL; }
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
