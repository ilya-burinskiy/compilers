.PHONY: clean

calculator: lexer.o calculator.o
	gcc $^ -o $@

calculator.o: src/calculator.c inc/lexer.h
	gcc -c -I inc src/calculator.c

lexer.o: src/lexer.c inc/lexer.h
	gcc -c -I inc src/lexer.c

src/lexer.c: src/lexer.l inc/lexer.h
	flex --outfile=src/lexer.c src/lexer.l

clean:
	rm -f *.o
