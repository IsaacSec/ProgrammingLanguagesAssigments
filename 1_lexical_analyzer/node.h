#include <stdlib.h>
#include <stdio.h>

struct _node{
    void *data;
    struct _node *next;
}; 

typedef struct _node node;

node * createNode(void * data);
void deleteNode(node * todelete); 