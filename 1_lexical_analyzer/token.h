#include <stdlib.h>
#include <stdio.h>

struct _token{
    char * type;
    char * value;
};

typedef struct _token token;

token * createToken (char * type, char * val);
//void printToken (void * tokenNode);