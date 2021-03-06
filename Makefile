.PHONY: clean

bin/calculator: build/calculator.o build/parser.o build/lexer.o build/abstract_syntax.o \
								build/ast_printer.o
	gcc $^ -o $@

build/ast_printer.o: src/ast_printer.c inc/ast_printer.h
	gcc -c -g -I inc src/ast_printer.c -o build/ast_printer.o

build/abstract_syntax.o: src/abstract_syntax.c inc/abstract_syntax.h
	gcc -c -g -I inc src/abstract_syntax.c -o build/abstract_syntax.o

build/calculator.o: src/calculator.c inc/lexer.h inc/parser.h inc/abstract_syntax.h \
										inc/ast_printer.h
	gcc -c -g -I inc src/calculator.c -o build/calculator.o

build/parser.o: src/parser.c inc/lexer.h inc/abstract_syntax.h
	gcc -c -g -I inc src/parser.c -o build/parser.o

build/lexer.o: src/lexer.c inc/lexer.h inc/tokens.h inc/abstract_syntax.h
	gcc -c -g -I inc src/lexer.c -o build/lexer.o

src/lexer.c: src/lexer.l
	flex --outfile=src/lexer.c src/lexer.l

inc/tokens.h src/parser.c: src/parser.y
	bison src/parser.y --defines=inc/tokens.h -o src/parser.c

clean:
	rm -f build/*.o
