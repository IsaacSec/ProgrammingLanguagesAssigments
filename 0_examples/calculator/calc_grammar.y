%{
    #include <string.h>
    #include <stdio.h>

    /* Function definitions */
    void yyerror (char *string);
%}

 /* NAME is used for identifier tokens */
 /* NUMBER is used or real numbers */


%token NUMBER
%token NAME

%%
statement_list: statement '\n'       { printf ("No errors in the line\n");}
    ;

statement:  NAME '=' expression
    |   expression
    ;

expression: expression '+' term
    |   expression '-' term
    |   term
    ;

term: term '*' factor
    | term '/' factor
    | factor
    ;

factor:  '(' expression ')'
    |   NUMBER
    |   NAME
    ;
%%

//#include "lex.yy.c"


/* Bison does NOT implement yyerror, so define it here */
void yyerror (char *string){
  printf ("%s",string);
}

/* Bison does NOT define the main entry point so define it here */
int main (){
  yyparse();
  return 0;
}
