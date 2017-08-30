#include "token.h"

token * createToken(char * type, char * val) {
    token * tok = (token*) malloc(sizeof(token*));
    tok->type = type;
    tok->value = val;
    return tok;
}