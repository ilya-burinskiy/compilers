.PHONY: clean

vpath %.c src
vpath %.l src

calculator: lexer.o
	gcc $^ -o $@

lexer.o: lexer.c
	gcc -c $<

lexer.c: lexer.l
	flex --outfile=$*.c $*.l

clean:
	rm -f *.o
