#include "node.h"

node * createNode(void * data) {
    node *n = (node *) malloc(sizeof(node));
    n->data = data;

    return n;
}