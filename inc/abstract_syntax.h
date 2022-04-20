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
typedef struct Expression {
  enum { BINOP_EXPR, TRUE_EXPR, FALSE_EXPR } type;
  union {
    struct { struct Expression * left; enum BinOp binop; struct Expression * right; } binop_expr;
  } u;
} Expression;

Statement * construct_compound_stmt(Statement * stmt1, Statement * stmt2);
Statement * construct_expression_stmt(Expression * expr);
