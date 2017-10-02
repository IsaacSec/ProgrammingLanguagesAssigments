analyzer.o: lex.yy.c
	gcc lex.yy.c -o lexical.o -lfl -Wall
lex.yy.c: lexical.l
	flex lexical.l
run: lexical.o test01.c
	reset
	./lexical.o < test01.c
clean:
	rm *.o lex*.c
