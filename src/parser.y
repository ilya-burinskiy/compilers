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

stmt : stmt NEW_LINE stmt
     {
       Statement * stmt = (Statement *) malloc(sizeof(Statement));
       stmt->type = COMPOUND_STMT;
       stmt->u.compound.stmt1 = $1;
       stmt->u.compound.stmt2 = $3;
       $$ = stmt;
     }
     | assign { $$ = NULL; }
     | expr
     {
       Statement * stmt = (Statement *) malloc(sizeof(Statement));
       stmt->type = EXPRESSION_STMT;
       stmt->u.expr = $1;
       $$ = stmt;
     }
     | %empty { $$ = NULL; }
     ;
assign : IDENTIFIER ASSIGN expr
       ;
expr : expr LOR expr
     {
       Expression * expr = (Expression *) malloc(sizeof(Expression));
       expr->type = BINOP_EXPR;
       expr->u.binop_expr.left = $1;
       expr->u.binop_expr.binop = LOR_BINOP;
       expr->u.binop_expr.right = $3;
       $$ = expr;
     }
     | expr LXOR expr
     {
       Expression * expr = (Expression *) malloc(sizeof(Expression));
       expr->type = BINOP_EXPR;
       expr->u.binop_expr.left = $1;
       expr->u.binop_expr.binop = LXOR_BINOP;
       expr->u.binop_expr.right = $3;
       $$ = expr;
     }
     | expr LAND expr
     {
       Expression * expr = (Expression *) malloc(sizeof(Expression));
       expr->type = BINOP_EXPR;
       expr->u.binop_expr.left = $1;
       expr->u.binop_expr.binop = LAND_BINOP;
       expr->u.binop_expr.right = $3;
       $$ = expr;
     }
     | LNOT expr { $$ = NULL; }
     | call { $$ = NULL; }
     | TRUE
     {
       Expression * expr = (Expression *) malloc(sizeof(Expression));
       expr->type = TRUE_EXPR;
       $$ = expr;
     }
     | FALSE
     {
       Expression * expr = (Expression *) malloc(sizeof(Expression));
       expr->type = FALSE_EXPR;
       $$ = expr;
     }
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
