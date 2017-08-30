#include "general_queue.h"

queue * createQueue() {
    queue * q = (queue *) malloc(sizeof(queue*));
    q->size = 0;
    q->head = NULL;
    q->tail = NULL;
}

void deleteQueue (queue * q) {
    while(q->head != NULL) {
        node * temp = q->head;
        q->head = q->head->next;
        free(temp);
    }
    free(q);
}

queue * enqueue (queue * q, void * data) {
    if (q == NULL) return NULL;
    node * n = (node *) malloc(sizeof(node*));
    n->data = data;

    if (q->head == NULL) {
        q->head = n;
        q->tail = n;
    } else if (q->tail == NULL) {
        q->head->next = n;
        q->tail = n;
    } else {
        node * temp = q->tail;
        temp->next = n;
        q->tail = n;
    }

    q->size++;
    return q;
}

node * dequeue (queue * q) {
    if (q == NULL) return NULL;

    node * tail = q->tail;
    node * current = q->head;
    node * prev = NULL;

    while (current != tail && current != NULL) {
        if (current->next == tail) {
            current->next = NULL;
            q->tail = current;
            return tail;
        }
        q->size--;
        current = current->next;
    }

    return NULL;
}

void printQueue (queue * q, void (*f) (node*)) {
    node * temp = q->head;
    printf("HEAD-> ");
    f(q->head);
    printf("TAIL-> ");
    f(q->tail);

    while(temp != NULL) {
        f(temp);
        temp = temp->next;
    }
}

// Special print
void printString (node * n){
    char * token_val = (char * ) n;
    printf("%s\n",token_val);
}

/*
int main() {
    char * one = "One";
    char * two = "Two";
    char * three = "Three";
    char * four = "Four";

    queue * q = createQueue();
    enqueue(q, one);
    enqueue(q, two);
    enqueue(q, three);
    enqueue(q, four);

    printf("Enqueue finished\n");
    printQueue(q, printString);
    deleteQueue(q);
    return EXIT_SUCCESS;
}
*/