/* This is the declaration section */
%{
    #include <string.h>

    char * RESERVED_WORD = "Reserved Word";
    char * COMMENT = "Comment";
    char * ASSIGMENT_OPERATION = "Assigment Operation";
    char * PUNCTUATION_TOKEN = "Punctuation Token";
    char * RELATIONAL_TOKEN = "Relational Token";
    char * ARITHMETIC_AND_LOGIC = "Arithmetic/Logic Operator";
    char * NUMBER = "Number";
    char * ID = "Identifier";

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
    int errorlex;
    //int nline; //\n          { nline++;}

    /* Gets the string of the regular expression found by flex */ 
    char * getSubstring(const char * src, int length) {
        char * cpy = (char*) malloc(length + 1);
        strncpy(cpy, src, length+1);
        return cpy;
    }

    /* Everytime a regular expression is found, this function is executed */
    /* acum - counter of tokens */
    /* key - type of token found */
    void reFound(int * acum, char * key) {
        (*acum)++; 
        char * value = getSubstring(yytext, yyleng);
        char * type = key;
        if (type == COMMENT) return;
        printf("[ %s ] ---> %s\n",value,type);
    }

    /* Everytime an error is found, this function is executed */
    void errorFound () {
        errorlex++;
        char * symbol = getSubstring(yytext,yyleng);
        int line = nlines + 1; /* The counter starts in 0, so we added 1 */
        printf("Symbol '%s' not recognized at line: %d\n",symbol,line);
    }

    /* Counts the number of '\n' in a comment */
    int findLineJumps(char * string){
        int length = strlen(string);
        int lines = 0;
        for (int i=0; i<length; i++) {
            if (*string == '\n'){
                lines++;
            }
            string++;
        }
        return lines;
    }
%}

/* This is the rule definition */
%%
\n                              { nlines++; }
"int"|"float"                   { reFound(&reword, RESERVED_WORD); }
"if"|"then"|"else"|"while"      { reFound(&reword, RESERVED_WORD); }
"read"|"write"                  { reFound(&reword, RESERVED_WORD); }
"/*"((\*+[^/*])|([^*]))*\**"*/" { reFound(&commts, COMMENT); nlines += findLineJumps(getSubstring(yytext,yyleng)); }
":="                            { reFound(&assop, ASSIGMENT_OPERATION); }
","|";"|"("|")"|"{"|"}"         { reFound(&puntok, PUNCTUATION_TOKEN); }
"<"|"="|"<="|">="|"!="          { reFound(&reltok, RELATIONAL_TOKEN); }
"+"|"-"|"*"|"/"                 { reFound(&arloop, ARITHMETIC_AND_LOGIC); }
[1-9][0-9]*|0(c|C)[0-7]+|0(x|X)[0-9A-Fa-f]+|[+-]?[0-9]*"."[0-9]+([eE][-+]?[0-9]+)?  { reFound(&numbers, NUMBER); }
[-+]?[0-9]*                     { reFound(&numbers, NUMBER); }                     
[A-Za-z_][A-Za-z0-9_]*          { reFound(&ids, ID); }
[^ ]                            { errorFound(); }
" "                             { /* Delete any white space */}
%%

/* This is the main program */

int main(void) {

    printf("\n");
    printf("\t +--------------------------------------+\n");
    printf("\t | Lexical analyzer by Martin and Isaac |\n");
    printf("\t +--------------------------------------+\n\n");

    printf("Track of tokens | value | type |\n");
    printf("--------------------------------\n\n");
    
    yylex(); /* Defined by flex */
    

    printf("\n\nLexical analyzer results.\n");
    printf("-------------------------\n\n");
    printf("[%3d ] [Reserved Words]\n",reword);
    printf("[%3d ] [Punctuation Tokens]\n",puntok);
    printf("[%3d ] [Relational tokens]\n",reltok);
    printf("[%3d ] [Arithmetic and Logic Operations]\n",arloop);
    printf("[%3d ] [Assigment Operation]\n",assop);
    printf("[%3d ] [Numbers]\n",numbers);
    printf("[%3d ] [Identifiers]\n",ids);
    printf("[%3d ] [Comments]\n",commts);

    return 0;
}