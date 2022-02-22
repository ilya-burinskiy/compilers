calculator: lexer.o
	gcc lexer.o -o calculator

lexer.o: lexer.c
	gcc -c lexer.c

lexer.c: lexer.l
	flex --outfile=lexer.c lexer.l
