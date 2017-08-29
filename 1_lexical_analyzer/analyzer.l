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
    int puntok;
    int reltok;
    int assop;
    int arloop;
    int numbers;
    int ids;

    int nlines;
    //int nline; //\n          { nline++;}

    
%}

/* This is the rule definition */
%%
"int"|"float"                   { reword++; }
"if"|"then"|"else"|"while"      { reword++; }
"read"|"write"                  { reword++; }
":="                            { assop++;  }
","|";"|"("|")"|"{"|"}"         { puntok++; }
"<"|"="|"<="|">="|"!="          { reltok++; }
"+"|"-"|"*"|"/"                 { arloop++; }
[1-9][0-9]*|0(c|C)[0-7]+|0(x|X)[0-9A-Fa-f]+|[+-]?[0-9]*"."[0-9]+([eE][-+]?[0-9]+)?  { numbers++; }
[A-Za-z_][A-Za-z0-9_]*          { ids++;    }
"\n"                            { nlines++; }
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
    printf("-------------------------\n\n");
    printf("[Reserved Words] %d\n",reword);
    printf("[Punctuation Tokens] %d\n",puntok);
    printf("[Relational tokens] %d\n",reltok);
    printf("[Arithmetic and Logic Operations] %d\n",arloop);
    printf("[Assigment Operation] %d\n",assop);
    printf("[Numbers] %d\n",numbers);
    printf("[Identifiers] %d\n",ids);
    
    return 0;
}