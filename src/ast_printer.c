#include "ast_printer.h"
#include "abstract_syntax.h"
#include "stdio.h"
#include "stdlib.h"

static void print_helper(const void * root, int type, int indent);

static void print_compound_stmt(const Statement * stmt, int indent);
static void print_expression_stmt(const Statement * stmt, int indent);
static void print_assign_stmt(const Statement * stmt, int indent);

static void print_binop_expr(const Expression * expr, int indent);
static void print_unop_expr(const Expression * expr, int indent);
static void print_id_expr(const Expression * expr, int indent);
static void print_true_expr(const Expression * expr, int indent);
static void print_false_expr(const Expression * expr, int indent);
static void print_call_expr(const Expression * expr, int indent);

static void print_compound_param(const Param * param, int indent);
static void print_simple_param(const Param * param, int indent);

void print_ast(const void * root, int type) {
  print_helper(root, type, 0);
}

static void print_helper(const void * root, int type, int indent) {
  switch (type) {
    case COMPOUND_STMT: { const Statement * stmt = root; print_compound_stmt(stmt, 0); } break;
    case EXPRESSION_STMT: { const Statement * stmt = root; print_expression_stmt(stmt, 0); } break;
    case ASSIGN_STMT: { const Statement * stmt = root; print_assign_stmt(stmt, 0); } break; 

    case BINOP_EXPR: { const Expression * expr = root; print_binop_expr(expr, indent); } break;
    case UNOP_EXPR: { const Expression * expr = root; print_unop_expr(expr, indent); } break;
    case ID_EXPR: { const Expression * expr = root; print_id_expr(expr, indent); } break;
    case TRUE_EXPR: { const Expression * expr = root; print_true_expr(expr, indent); } break;
    case FALSE_EXPR: { const Expression * expr = root; print_false_expr(expr, indent); } break;
    case CALL_EXPR: { const Expression * expr = root; print_call_expr(expr, indent); } break;

    case COMPOUND_PARAM: { const Param * params = root; print_compound_param(params, indent); } break;
    case SIMPLE_PARAM: { const Param * param = root; print_simple_param(param, indent); } break;
  }
}

// All statement are printed with zero indentation
static void print_compound_stmt(const Statement * stmt, int indent) {
  const Statement * stmt1 = stmt->u.compound.stmt1;
  const Statement * stmt2 = stmt->u.compound.stmt2;
  
  if (stmt1 != NULL) {
    print_helper(stmt1, stmt1->type, indent);
  }
  if (stmt2 != NULL) {
    print_helper(stmt2, stmt2->type, indent);
  }
}

static void print_expression_stmt(const Statement * stmt, int indent) {
  const Expression * expr = stmt->u.expr;
  print_helper(expr, expr->type, indent);
}

/*
  ASSIGN_STMT:
    ID: "..."
    EXPR
*/
static void print_assign_stmt(const Statement * stmt, int indent) {
  const char * id = stmt->u.assign.id;
  const Expression * expr = stmt->u.assign.expr;

  int child_node_indent = 2;
  int id_str_indent = child_node_indent + 2; // 2 is length of ID

  printf("ASSIGN_STMT:\n");
  printf("%*s: \"%s\"\n", id_str_indent, "ID", id);
  print_helper(expr, expr->type, child_node_indent);
}

/*
  (indent)BINOP_EXPR:
  (indent + 2)OP:
  (indent + 4)EXPR1
  (indent + 4)EXPR2
*/
static void print_binop_expr(const Expression * expr, int indent) {
  const Expression * left = expr->u.binop_expr.left;
  const Expression * right = expr->u.binop_expr.right;

  int child_node_indent = indent + 2;
  int binop_expr_str_indent = indent + 10;
  int single_expr_indent = child_node_indent + 2;

  int op_indent = 0;
  char * op_str = "";
  switch (expr->u.binop_expr.binop) {
    case LOR_BINOP: { op_indent = child_node_indent + 3; op_str = "LOR"; } break;
    case LXOR_BINOP: { op_indent = child_node_indent + 4; op_str = "LXOR"; } break;
    case LAND_BINOP: { op_indent = child_node_indent + 4; op_str = "LAND"; } break;
  }

  printf("%*s:\n", binop_expr_str_indent, "BINOP_EXPR");
  printf("%*s:\n", op_indent, op_str);
  print_helper(left, left->type, single_expr_indent);
  print_helper(right, right->type, single_expr_indent);
}

/*
  (indent)UNOP_EXPR:
  (indent + 2)OP:
  (indent + 4)EXPR
*/
static void print_unop_expr(const Expression * expr, int indent) {
  const Expression * left = expr->u.unop_expr.left;

  int child_node_indent = indent + 2;
  int unop_expr_str_indent = indent + 9;
  int op_indent = child_node_indent + 4;
  int single_expr_indent = child_node_indent + 2;

  printf("%*s:\n", unop_expr_str_indent, "UNOP_EXPR");
  printf("%*s:\n", op_indent, "LNOT");
  print_helper(left, left->type, single_expr_indent);
}

static void print_id_expr(const Expression * expr, int indent) {
  const char * id = expr->u.id;
  int id_str_indent = indent + 2;

  printf("%*s: \"%s\"\n", id_str_indent, "ID", id);
}

static void print_true_expr(const Expression * expr, int indent) {
  int true_str_indent = indent + 4;
  printf("%*s\n", true_str_indent, "TRUE");
}

static void print_false_expr(const Expression * expr, int indent) {
  int false_str_indent = indent + 5;
  printf("%*s\n", false_str_indent, "FALSE");
}

/*
  (indent)CALL_EXPR:
  (indent + 2)ID: "..."
  (indent + 2)PARAMS:
  (indent + 4)PARAM:
*/
static void print_call_expr(const Expression * expr, int indent) {
  const char * id = expr->u.call_expr.id;
  const Param * params = expr->u.call_expr.params;

  int child_node_indent = indent + 2;
  int call_expr_str_indent = indent + 9;
  int id_str_indent = child_node_indent + 2;
  int params_str_indent = child_node_indent + 6;
  int single_param_indent = child_node_indent + 2;

  printf("%*s:\n", call_expr_str_indent, "CALL_EXPR");
  printf("%*s: \"%s\"\n", id_str_indent, "ID", id);
  printf("%*s:\n", params_str_indent, "PARAMS");
  print_helper(params, params->type, single_param_indent);
}

static void print_compound_param(const Param * params, int indent) {
  const Param * param1 = params->u.compound_parm.param1;
  const Param * param2 = params->u.compound_parm.param2;

  if (param1 != NULL) {
    print_helper(param1, param1->type, indent);
  }
  if (param2 != NULL) {
    print_helper(param2, param2->type, indent);
  }
}

static void print_simple_param(const Param * param, int indent) {
  const Expression * expr = param->u.expr;
  print_helper(expr, expr->type, indent);
}
