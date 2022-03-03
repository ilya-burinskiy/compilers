%option noyywrap
%option yylineno

%{
#include <stdio.h>
#include <stdlib.h>
#include "tokens.h"
%}

id [[:alpha:]_][[:alnum:]_]*
separator [\r\t\f\v ]
new_line \n
lparent \(
rparent \)
comma ,
assign =
or \|\|
and &&
xor \^
not !
error_symbol [^[:alpha:]_\(\),=\|\^!&\r\n\t\f\v ]
true T
false F

%%
{false} { return FALSE; }
{true} { return TRUE; }
{id} { return IDENTIFIER; }
{lparent} { return LPARENT; }
{rparent} { return RPARENT; }
{comma} { return COMMA; }
{assign} { return ASSIGN; }
{or} { return LOR; }
{and} { return LAND; }
{xor} { return LXOR; }
{not} { return LNOT; }
{error_symbol}+ { return ERROR; }

{new_line} { return NEW_LINE; }
{separator}+
