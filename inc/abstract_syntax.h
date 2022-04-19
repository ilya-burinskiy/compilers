#pragma once

struct Statement {
  enum { COMPOUND_STMT } type;
  union {
    struct { struct Statement * stmt1, * stmt2; } compound;
  } u;
};

enum BinOp { LOR_BINOP, LXOR_BINOP, LAND_BINOP };
struct Expression {
  enum { BINOP_EXPR } type;
  union {
    struct { struct Expression * left; enum BinOp binop; struct Expression * right; } binop_expr;
  } u;
};

typedef enum BinOp BinOp;
typedef struct Expression Expression;
typedef struct Statement Statement;
