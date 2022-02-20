%option noyywrap

%{
#define YY_DECL int scan_tokens()
%}

separator [ \t\n]

%%
{separator}+
%%
