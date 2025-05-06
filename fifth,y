#include <stdio.h>
%}

%token Int Char Float Bool String IntV CharV FloatV BoolV StringV Id Am Const

%%
S1: S1 S
| S
;
S: Int Iv';' { printf("int declaration accepted"); }
| Char Cc';' { printf("char declaration accepted"); }
| Float Ff';' { printf("float declaration accepted"); }
| Bool Bb';' { printf("bool declaration accepted."); }
;
Iv: IdM
| Iv ',' Id
| Id '=' IntV
| Iv ',' Id '=' IntV
;
Cc: IdM
| Cc ',' Id
| Id '=' CharV
| Cc ',' Id '=' CharV
;
Ff: IdM
| Ff ',' Id
| Id '=' FloatV
| Ff ',' Id '=' FloatV
;
Bb: IdM
| Bb ',' Id
| Id '=' BoolV
| Bb ',' Id '=' BoolV
;
Ss: IdM
| Ss ',' Id
| Id '=' StringV
| Ss ',' Id '=' StringV
;
IdM: Id
;
%%
void yyerror(char*s) {
printf("%s", s);
}
int main() {
yyparse();
return 0;
}


command:yacc -d five.y
lex five.l
gcc lex.yy.c y.tab.c -o five
./five
