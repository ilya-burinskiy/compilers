%option noyywrap
%option yylineno

%s consumed_non_new_line_char

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
{id} { yylval.id = strdup(yytext); return IDENTIFIER; }
{lparent} { return LPARENT; }
{rparent} { return RPARENT; }
{comma} { return COMMA; }
{assign} { return ASSIGN; }
{or} { return LOR; }
{and} { return LAND; }
{xor} { return LXOR; }
{not} { return LNOT; }
{error_symbol}+ { return ERROR; }
[^\n] { BEGIN(consumed_non_new_line_char); }

<consumed_non_new_line_char>{new_line} { BEGIN(INITIAL); return NEW_LINE; }
{separator}+
