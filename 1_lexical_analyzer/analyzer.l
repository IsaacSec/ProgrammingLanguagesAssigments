/* This is the declaration section */
%{
    #include <string.h>
    #include "general_queue.h"

    char * RESERVED_WORD = "Reserved Word";
    char * COMMENT = "Comment";
    char * ASSIGMENT_OPERATION = "Assigment Operation";
    char * PUNCTUATION_TOKEN = "Punctuation Token";
    char * RELATIONAL_TOKEN = "Relational Token";
    char * ARITHMETIC_AND_LOGIC = "Arithmetic/Logic Operator";
    char * NUMBER = "Number";
    char * ID = "Identificator";

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
    int commts;

    int nlines;
    //int nline; //\n          { nline++;}

    queue * token_queue;

    void printToken (node * tokenNode) {
        token * t = (token*) tokenNode->data;
        printf("[%s]->%s\n",t->type, t->value);
    }

    char * getSubstring(const char * src, int length) {
        char * cpy = (char*) malloc(length + 1);
        strncpy(cpy, src, length+1);
        return cpy;
    }

    void reFound(int * acum, char * key) {
        (*acum)++; 
        token * t = createToken(key, getSubstring(yytext,yyleng)); 
        enqueue(token_queue, t);
    }
%}

/* This is the rule definition */
%%
"int"|"float"                   { reFound(&reword, RESERVED_WORD); }
"if"|"then"|"else"|"while"      { reFound(&reword, RESERVED_WORD); }
"read"|"write"                  { reFound(&reword, RESERVED_WORD); }
"/*"((\*+[^/*])|([^*]))*\**"*/" { reFound(&commts, COMMENT); }
":="                            { reFound(&assop, ASSIGMENT_OPERATION); }
","|";"|"("|")"|"{"|"}"         { reFound(&puntok, PUNCTUATION_TOKEN);puntok++; }
"<"|"="|"<="|">="|"!="          { reFound(&reltok, RELATIONAL_TOKEN);reltok++; }
"+"|"-"|"*"|"/"                 { reFound(&arloop, ARITHMETIC_AND_LOGIC);arloop++; }
[1-9][0-9]*|0(c|C)[0-7]+|0(x|X)[0-9A-Fa-f]+|[+-]?[0-9]*"."[0-9]+([eE][-+]?[0-9]+)?  { reFound(&numbers, NUMBER); }
[A-Za-z_][A-Za-z0-9_]*          { reFound(&ids, ID); }
"\n"                            { nlines++; }
%%

/* This is the main program */

int main(void) {

    token_queue = createQueue(); 

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
    printf("[Comments] %d\n",commts);

    printf("\n\n");
    printQueue(token_queue, printToken);

    return 0;
}