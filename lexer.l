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
or \|\|

%{
// Regular expression for a state machine for real number
// from Compilers: Principles, Techniques, and Tools
// (Second Edition, Diagram 3.16 on page 183)
%}
real_number {digit}+(\.{digit}+(E[+-]?{digit}+)?)?

%%
{id} { printf("IDENTIFIER, \"%s\"\n", yytext); }
{lparent} { printf("LPARENT, \"%s\"\n", yytext); }
{rparent} { printf("RPARENT, \"%s\"\n", yytext); }
{comma} { printf("COMMA, \"%s\"\n", yytext); }
{assign} { printf("ASSIGN, \"%s\"\n", yytext); }
{real_number} { printf("ERROR, \"%s\"\n", yytext); }
{or} { printf("LOR, \"%s\"\n", yytext); }

{separator}+
%%
