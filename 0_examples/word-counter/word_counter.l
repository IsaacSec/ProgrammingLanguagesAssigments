/* This is the declaration section */
%{
    int nchar, nword, nline;
%}

/* This is the rule definition */
%%
\n          { nline++; nchar++; }
[^ \t\n]+   { nword++; nchar += yyleng; }
.           { nchar++; }
%%

/* This is the main program */

int main(void) {
    yylex(); /* Defined by flex */
    printf("%d\t%d\t%d\n", nchar, nword, nline);
    return 0;
}