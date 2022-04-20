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

%union { Statement * stmt; Expression * expr; }
%parse-param { Statement ** root }

%type <stmt> stmt
%type <expr> expr

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

stmt : stmt NEW_LINE stmt { $$ = construct_compound_stmt($1, $3); }
     | assign { $$ = NULL; }
     | expr { $$ = construct_expression_stmt($1); }
     | %empty { $$ = NULL; }
     ;
assign : IDENTIFIER ASSIGN expr
       ;
expr : expr LOR expr { $$ = construct_binop_expr($1, LOR_BINOP, $3); }
     | expr LXOR expr { $$ = construct_binop_expr($1, LXOR_BINOP, $3); }
     | expr LAND expr { $$ = construct_binop_expr($1, LAND_BINOP, $3); }
     | LNOT expr { $$ = NULL; }
     | call { $$ = NULL; }
     | TRUE { $$ = construct_true_expr(); }
     | FALSE { $$ = construct_false_expr(); }
     | IDENTIFIER { $$ = NULL; }
     | ERROR { yyerror(root, "syntax error"); exit(EXIT_FAILURE); }
     | LPARENT expr RPARENT { $$ = $2; }
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
