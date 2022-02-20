%option noyywrap

%{
#include <stdio.h>
#define YY_DECL int scan_tokens()
%}

letter [A-Za-z]
digit [0-9]
id ({letter}|_)({letter}|{digit}|_)*
separator [ \t\n]

%%
{id} { printf("IDENTIFIER, \"%s\"\n", yytext); }
{separator}+
%%
