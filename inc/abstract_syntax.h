#pragma once

typedef enum StatementType {
  COMPOUND_STMT, EXPRESSION_STMT, ASSIGN_STMT
} StatementType;

typedef enum BinOp {
  LOR_BINOP = (int) ASSIGN_STMT + 1,
  LXOR_BINOP, LAND_BINOP
} BinOp;

typedef enum UnOp {
  LNOT_UNOP = (int) LAND_BINOP + 1
} UnOp;

typedef enum ExpressionType {
  BINOP_EXPR = (int) LNOT_UNOP + 1,
  UNOP_EXPR, ID_EXPR, TRUE_EXPR, FALSE_EXPR,
  CALL_EXPR
} ExpressionType;

typedef enum ParamType {
  COMPOUND_PARAM = (int) CALL_EXPR + 1, SIMPLE_PARAM
} ParamType;

struct Expression;

typedef struct Statement {
  StatementType type;
  union {
    struct { struct Statement * stmt1, * stmt2; } compound;
    struct { char * id; struct Expression * expr; } assign;
    struct Expression * expr;
  } u;
} Statement;

struct Param;

typedef struct Expression {
  ExpressionType type;
  union {
    struct { struct Expression * left; BinOp binop; struct Expression * right; } binop_expr;
    struct { enum UnOp op; struct Expression * left; } unop_expr;
    struct { char * id; struct Param * params; } call_expr;
    char * id;
  } u;
} Expression;

typedef struct Param {
  ParamType type;
  union {
    struct { struct Param * param1, * param2; } compound_parm;
    Expression * expr;
  } u;
} Param;

Statement * construct_compound_stmt(Statement * stmt1, Statement * stmt2);
Statement * construct_expression_stmt(Expression * expr);
Statement * construct_assign_stmt(char * id, Expression * expr);

Expression * construct_binop_expr(Expression * expr1, BinOp binop, Expression * expr2);
Expression * construct_unop_expr(UnOp unop, Expression * expr);
Expression * construct_id_expr(char * str);
Expression * construct_call_expr(char * id, Param * params);
Expression * construct_true_expr();
Expression * construct_false_expr();

Param * construct_compound_param(Param * param1, Param * param2);
Param * construct_simple_param(Expression * expr);
