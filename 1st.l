%{
#include<stdio.h>
int lc=0, tc=0, sc=0, wc=0, cc=0;
%}

%%

[^ \t\n]+   { cc += yyleng; wc++; }
[ ]         { cc++; sc++; }
[\t]        { cc++; tc++; }
\n          { cc++; lc++; }

%%

int main()
{
    printf("Enter your input (Press Ctrl+D or Ctrl+Z then Enter to stop):\n");
    yylex(); // reads from stdin
    return 0;
}

int yywrap()
{
    printf("\n--- Statistics ---\n");
    printf("No. of lines = %d\n", lc);
    printf("No. of tabs = %d\n", tc);
    printf("No. of characters = %d\n", cc);
    printf("No. of spaces = %d\n", sc);
    printf("No. of words = %d\n", wc);
    return 1;
}
 
command:lex first.l
gcc lex.yy.c -o first
./first
