%{
#include "y.tab.h"
%}

letter      [a-zA-Z]
num         [0-9]+
float       {num}+\.{num}+
bools       "true"|"false"
identifier  {letter}({letter}|{num})*

%%
"int"             { return Int; }
"char"            { return Char; }
"float"           { return Float; }
"bool"            { return Bool; }
{num}             { return IntV; }
{float}           { return FloatV; }
{bools}           { return BoolV; }
{identifier}      { return Id; }
"'"(.)"'"         { return CharV; }
[,;=]             { return yytext[0]; }
%%
int yywrap() {
    return 1;
}
