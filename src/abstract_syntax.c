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
