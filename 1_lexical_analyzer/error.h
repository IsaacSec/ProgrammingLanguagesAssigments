#include <stdlib.h>
#include <stdio.h>

struct _error{
    char * symbol;
    int line;
};

typedef struct _error error;

error * createError (char * symbol, int line);