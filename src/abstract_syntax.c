#include <stdlib.h>
#include "abstract_syntax.h"

Statement * construct_compound_stmt(Statement * stmt1, Statement * stmt2) {
  Statement * stmt = (Statement *) malloc(sizeof(Statement));
  stmt->type = COMPOUND_STMT;
  stmt->u.compound.stmt1 = stmt1;
  stmt->u.compound.stmt2 = stmt2;

  return stmt;
}

Statement * construct_expression_stmt(Expression * expr) {
  Statement * stmt = (Statement *) malloc(sizeof(Statement));
  stmt->type = EXPRESSION_STMT;
  stmt->u.expr = expr;

  return stmt;
}

Expression * construct_binop_expr(Expression * expr1, BinOp binop, Expression * expr2) {
  Expression * expr = (Expression *) malloc(sizeof(Expression));
  expr->type = BINOP_EXPR;
  expr->u.binop_expr.left = expr1;
  expr->u.binop_expr.binop = binop;
  expr->u.binop_expr.right = expr2;

  return expr;
}

Expression * construct_unop_expr(UnOp unop, Expression * left) {
  Expression * expr = (Expression *) malloc(sizeof(Expression));
  expr->type = UNOP_EXPR;
  expr->u.unop_expr.op = unop;
  expr->u.unop_expr.left = left;

  return expr;
}

Expression * construct_true_expr() {
  Expression * expr = (Expression *) malloc(sizeof(Expression));
  expr->type = TRUE_EXPR;

  return expr;
}

Expression * construct_false_expr() {
  Expression * expr = (Expression *) malloc(sizeof(Expression));
  expr->type = FALSE_EXPR;

  return expr;
}
