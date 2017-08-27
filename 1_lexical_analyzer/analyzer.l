/* This is the declaration section */
%{
    /*  --- Variable meaning ---
    *   reword:  Reserved words
    *   puntok:  Punctuation Tokens
    *   reltok:  Relational Tokens
    *   arloop:  Arithmetic and Logic Operations
    *   assop:   Assigment Operation
    *   numbers: Numbers
    *   ids:     Identifiers
    *   commts:  Comments
    *   nlines:  Line Jump    
    */
    int reword;
    //int nline; //\n          { nline++;}
%}

/* This is the rule definition */
%%
"int"|"float"                   { reword++; }
"if"|"then"|"else"|"while"      { reword++; }
"read"|"write"                  { reword++; }
%%

/* This is the main program */

int main(void) {
    printf("\n");
    printf("\t +--------------------------------------+\n");
    printf("\t | Lexical analyzer by Martin and Isaac |\n");
    printf("\t +--------------------------------------+\n\n");

    printf("Text that could't fit on any Regular Expression.\n");
    printf("------------------------------------------------\n\n");
    
    yylex(); /* Defined by flex */
    
    printf("\n\nLexical analyzer results.\n");
    printf("-----------------------------\n\n");
    printf("[Reserved Words] %d\n",reword);
    return 0;
}