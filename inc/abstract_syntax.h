#pragma once

struct Expression;

typedef struct Statement {
  enum { COMPOUND_STMT, EXPRESSION_STMT } type;
  union {
    struct { struct Statement * stmt1, * stmt2; } compound;
    struct Expression * expr;
  } u;
} Statement;

typedef enum BinOp { LOR_BINOP, LXOR_BINOP, LAND_BINOP } BinOp;
typedef enum UnOp { LNOT_UNOP } UnOp;

typedef struct Expression {
  enum { BINOP_EXPR, UNOP_EXPR, ID_EXPR, TRUE_EXPR, FALSE_EXPR } type;
  union {
    struct { struct Expression * left; enum BinOp binop; struct Expression * right; } binop_expr;
    struct { enum UnOp op; struct Expression * left; } unop_expr;
    char * id;
  } u;
} Expression;

typedef struct Param {
  enum { COMPOUND_PARAM, SIMPLE_PARAM } type;
  union {
    struct { struct Param * param1, * param2; } compound_parm;
    Expression * expr;
  } u;
} Param;

Statement * construct_compound_stmt(Statement * stmt1, Statement * stmt2);
Statement * construct_expression_stmt(Expression * expr);

Expression * construct_binop_expr(Expression * expr1, BinOp binop, Expression * expr2);
Expression * construct_unop_expr(UnOp unop, Expression * expr);
Expression * construct_id_expr(char * str);
Expression * construct_true_expr();
Expression * construct_false_expr();

Param * construct_compound_param(Param * param1, Param * param2);
Param * construct_simple_param(Expression * expr);
