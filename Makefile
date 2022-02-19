calculator: lexer.o calculator.o
	gcc lexer.o calculator.o -o calculator

calculator.o: calculator.c
	gcc -c calculator.c

lexer.o: lexer.c
	gcc -c lexer.c

lexer.c: lexer.l
	flex --outfile=lexer.c lexer.l
