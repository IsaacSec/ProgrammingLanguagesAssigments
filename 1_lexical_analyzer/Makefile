analyzer.o: lex.yy.c
	clang lex.yy.c node.c general_queue.c token.c error.c -o analyzer.o -lfl -Wall
lex.yy.c: analyzer.l
	flex analyzer.l
run: analyzer.o test01.c
	reset
	./analyzer.o < test01.c
clean:
	rm *.o lex*.c