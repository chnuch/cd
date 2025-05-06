%{
#include <stdio.h>
#include <string.h>

struct symtab {
    char *name;
};

struct symtab sym[10], *k;
struct symtab *install_id(char *s);
void disp();
%}

L      [a-zA-Z]
D      [0-9]
id     {L}({L}|{D})*
num    {D}+(\.{D}+)?([eE][-+]?{D}+)?
bop    [-+*/=]
uop    "++"|"--"
relop  "<"|"<="|">"|">="|"!="|"=="
lop    "&&"|"||"
bitlop [&|!]
kew    "if"|"else"|"while"|"do"|"for"|"int"|"char"|"float"
pun    [,;'"\[\]\{\}\)\(]
comment "/\*"(.|\n)*"\*/"|"//"(.)*
ws     [ \t\n]+
st     \"(.)*\"

%%

{ws}         { /* ignore whitespace */ }
{kew}        { printf("keyword = %s\n", yytext); }
{id}         { k = install_id(yytext); printf("identifier = %s\n", yytext); }
{num}        { printf("constant = %s\n", yytext); }
{bop}        { printf("binary op = %s\n", yytext); }
{uop}        { printf("unary op = %s\n", yytext); }
{relop}      { printf("relational op = %s\n", yytext); }
{lop}        { printf("logical op = %s\n", yytext); }
{pun}        { printf("punct = %s\n", yytext); }
{bitlop}     { printf("bitwise logical op = %s\n", yytext); }
{comment}    { printf("comment = %s\n", yytext); }
{st}         { printf("string = %s\n", yytext); }

%%

int main() {
    yylex();   // Start lexing input
    disp();    // Display symbol table after lexing
    return 0;
}

// Function to install identifiers in the symbol table
struct symtab *install_id(char *s) {
    struct symtab *p;
    printf("in symbol table\n");
    for (p = &sym[0]; p < &sym[10]; p++) {
        if (p->name && !strcmp(s, p->name))
            return p;
        if (!p->name) {
            p->name = strdup(s);  // Add the identifier to the table
            return p;
        }
    }
    return NULL;  // Return NULL if the table is full
}

// Function to display the symbol table
void disp() {
    printf("\n--- Symbol Table ---\n");
    for (int i = 0; i < 10; i++) {
        if (sym[i].name) {
            printf("name = %s\n", sym[i].name);
        }
    }
}

// Function required by Lex, to signal the end of input
int yywrap() {
    return 1;  // End of input
}

command:lex second.l
gcc lex.yy.c -o second
./second
