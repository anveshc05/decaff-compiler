all: parser.y scanner.l
		bison -d parser.y
		flex scanner.l
		gcc -o parser parser.tab.c lex.yy.c -lfl

clean: 
	rm ./lex.yy.c ./parser.tab.c ./parser.tab.h ./parser