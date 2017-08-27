analyzer.o: lex.yy.c
	gcc lex.yy.c -o analyzer.o
lex.yy.c: analyzer.l
	flex analyzer.l
clean:
	rm *.o lex*.c