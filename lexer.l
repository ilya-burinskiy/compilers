%option noyywrap

%{
#include <stdio.h>
#define YY_DECL int scan_tokens()
%}

letter [A-Za-z]
digit [0-9]
id ({letter}|_)({letter}|{digit}|_)*
separator [ \t\n]
lparent \(
rparent \)
comma ,
assign =

%%
{id} { printf("IDENTIFIER, \"%s\"\n", yytext); }
{lparent} { printf("LPARENT, \"%s\"\n", yytext); }
{rparent} { printf("RPARENT, \"%s\"\n", yytext); }
{comma} { printf("COMMA, \"%s\"\n", yytext); }
{assign} { printf("ASSIGN, \"%s\"\n", yytext); }

{separator}+
%%
