#include "error.h"

error * createError (char * symbol, int line) {
    error * er = (error*) malloc(sizeof(error*));
    er->symbol = symbol;
    er->line = line;
    return er;
}