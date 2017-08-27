run: analyzer.o test01.c
	./analyzer.o < test01.c
analyzer.o: lex.yy.c
	gcc lex.yy.c -o analyzer.o -lfl
lex.yy.c: analyzer.l
	flex analyzer.l
clean:
	rm *.o lex*.c