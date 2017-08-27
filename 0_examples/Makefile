word.o: lex.yy.c
	gcc lex.yy.c -o word.o -lfl
lex.yy.c: word_counter.l
	flex word_counter.l
run: word.o test.txt
	./word.o < test.txt
clean:
	rm *.o *.c