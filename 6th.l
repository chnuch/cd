%{
# include<stdio.h>
# include<stdlib.h>
# include "y.tab.h"
%}

num ([0-9]+)(\.[0-9]+)?([eE][-+]?[0-9]+)?

%%
"sin"                     { return SIN; }
"cos"                     { return COS; }
"tan"                     { return TAN; }
[A-Za-z][A-Za-z0-9]*      { yylval.p = install_id(yytext); return id; }
{num}                     { yylval.v = atof(yytext); return NUM; }
[\n]                      { return yytext[0]; }
.                         { return yytext[0]; }
%%

int yywrap()
{
    return 1;
}
