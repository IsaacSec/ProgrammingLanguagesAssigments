analyzer.o: lex.yy.c queue.o
	gcc lex.yy.c -o analyzer.o queue.o -lfl
lex.yy.c: analyzer.l
	flex analyzer.l
queue.o: node.o
	gcc -c general_queue.c -o queue.o	
node.o: node.h node.c
	gcc -c node.c -o node.o
run: analyzer.o test01.c
	reset
	./analyzer.o < test01.c
clean:
	rm *.o lex*.c