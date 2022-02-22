%option noyywrap

%{
#include <stdio.h>
#include <stdlib.h>

#define YY_DECL int scan_tokens()
%}

id [[:alpha:]_][[:alnum:]_]*
separator [\r\n\t\f\v ]
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
{false} { printf("FALSE, \"%s\"\n", yytext); }
{true} { printf("TRUE, \"%s\"\n", yytext); }
{id} { printf("IDENTIFIER, \"%s\"\n", yytext); }
{lparent} { printf("LPARENT, \"%s\"\n", yytext); }
{rparent} { printf("RPARENT, \"%s\"\n", yytext); }
{comma} { printf("COMMA, \"%s\"\n", yytext); }
{assign} { printf("ASSIGN, \"%s\"\n", yytext); }
{or} { printf("LOR, \"%s\"\n", yytext); }
{and} { printf("LAND, \"%s\"\n", yytext); }
{xor} { printf("LXOR, \"%s\"\n", yytext); }
{not} { printf("LNOT, \"%s\"\n", yytext); }
{error_symbol}+ { printf("ERROR, \"%s\"\n", yytext); }

{separator}+
%%

void scan_file(const char * fname);

int main(int argc, char ** argv) {
  if (argc >= 2) {
    scan_file(argv[1]);
  } else {
    scan_tokens();
  }
  return 0;
}

void scan_file(const char * fname) {
  FILE * fp = fopen(fname, "r");
  if (!fp) {
    perror("Can not open the file");
    exit(1);
  } else {
    yy_switch_to_buffer(yy_create_buffer(fp, YY_BUF_SIZE));
    scan_tokens();
    fclose(fp);
  }
}
