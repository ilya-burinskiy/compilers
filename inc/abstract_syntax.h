#pragma once

struct Statement {
  enum { COMPOUND_STMT } type;
  union {
    struct { struct Statement * stmt1, * stmt2; } compound;
  } u;
};

typedef struct Statement Statement;
