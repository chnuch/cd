%{
#include <stdio.h>
#include "y.tab.h"
struct symtab *install_id(char *s);
%}

l     [A-Za-z]
d     [0-9]
id    {l}({l}|{d})*
num   {d}+(\.{d}+)?

%%
{id}              { yylval.p = install_id(yytext); return id; }
{num}             { strcpy(yylval.v, yytext); return num; }
[-+*/^=;]         { return yytext[0]; }
.|\n              { }
%%

int yywrap()
{
    return 1;
}
