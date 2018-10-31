all: parser.yy scanner.l
		bison -d parser.yy
		flex scanner.l
		g++ -g lex.yy.c parser.tab.cc -lfl -o parser

clean: 
	rm lex.yy.c parser.tab.cc parser.tab.hh parser