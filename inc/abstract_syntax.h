#pragma once

typedef struct Statements {
  struct Statements * stmts;
  struct Statement * stmt;
} Statements;

typedef struct Statement {
  int lineno; /* temporary value */
} Statement;
