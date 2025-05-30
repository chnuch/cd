%{
#include "y.tab.h"
%}

NOUN        "Tarkeshwari"|"Dog"|"Asha"|"Mayuri"|"Monali"|"Pratiksha"|"Car"
VERB        "Play"|"Run"|"Sing"|"Act"|"Answer"|"Approve"|"Arrange"|"Drink"|"Eat"|"Edit"|"Enter"|"Sneeze"|"Solve"|"Study"|"Teach"|"Write"
PREPOSITION "In"|"On"|"Below"|"Above"|"Beside"
ADJECTIVE   "Good"|"Bad"|"Big"|"small"|"Tall"|"Short"|"ugly"|"Beautiful"|"Adorable"
PRONOUN     "He"|"She"|"It"|"They"|"Them"
DET         "a"|"an"|"the"
CONJ        ([aA][nN][dD])|([oO][rR])|([bB][uU][tT])

%%
{NOUN}        { return NOUN; }
{VERB}        { return VERB; }
{PREPOSITION} { return Preposition; }
{ADJECTIVE}   { return ADJECTIVE; }
{PRONOUN}     { return PRONOUN; }
{DET}         { return DET; }
{CONJ}        { return CONJ; }
"."           { return yytext[0]; }
.|\n          { /* ignore everything else */ }
%%

int yywrap() {
    return 1;
}

command:yacc -d third.y
lex third.y
gcc lex.yy.c y.tab.c -o third
./third
