%{
#include <stdio.h>
#include "y.tab.h"
%}

L [A-Za-z]
D [0-9]
id {L}({L}|{D})*

%%
"if"        { return IF; }
"else"      { return ELSE; }
"for"       { return FOR; }
"do"        { return DO; }
"while"     { return WHILE; }
"switch"    { return SWITCH; }
"case"      { return CASE; }
"break"     { return BREAK; }
"default"   { return DEFAULT; }
"true"      { return TRUE; }
"false"     { return FALSE; }
"++"        { return INC; }
"--"        { return DEC; }
"||"        { return OR; }
"&&"        { return AND; }
"!"         { return NOT; }
"=="|"<="|">="|"!="|"<"|">" { return relop; }

[0-9]+      { return NUM; }
{id}        { return id; }

[-/;=+*,(){}] { return yytext[0]; }

[ \t\n]     ;   // Ignore whitespace
.           { printf("Unknown character: %s\n", yytext); }

%%
int yywrap() { return 1; }
