#pragma once

enum Token {
  // reserve 0 for end of input
  FALSE = 1,
  TRUE,
  IDENTIFIER,
  LPARENT,
  RPARENT,
  COMMA,
  ASSIGN,
  LOR,
  LAND,
  LXOR,
  LNOT,
  ERROR
};
