#include "node.h"

struct _queue{
    int size;
    node * head;
    node * tail;
};

typedef struct _queue queue;

queue * createQueue();
void deleteQueue (queue * q);

queue * enqueue (queue * q, void * data);
node * dequeue (queue * q);
void printQueue (queue * q, void (*f) (node*));