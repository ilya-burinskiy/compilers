.PHONY: clean

calculator: calculator.o parser.o lexer.o
	gcc $^ -o $@

calculator.o: src/calculator.c inc/lexer.h inc/tokens.h
	gcc -c -I inc src/calculator.c

parser.o: src/parser.c
	gcc -c -I inc src/parser.c

lexer.o: src/lexer.c inc/lexer.h inc/tokens.h
	gcc -c -I inc src/lexer.c

src/lexer.c: src/lexer.l inc/lexer.h inc/tokens.h
	flex --outfile=src/lexer.c src/lexer.l

inc/tokens.h src/parser.c: src/parser.y inc/lexer.h
	bison src/parser.y --defines=inc/tokens.h -o src/parser.c

clean:
	rm -f *.o
