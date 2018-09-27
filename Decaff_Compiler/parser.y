%{
	#include<stdio.h>
	int yylex();
	void yyerror(char *s)
	{
		fprintf(stderr, "error: %s\n", s);
	}
%}

%start expr
%token ID
%token DECIMAL
%token HEXADECIMAL
%token TRUE_INP
%token FALSE_INP
%token ALPHA
%token CALLOUT

%left OROR
%left ANDAND
%left EE NE
%left '<' '>' LE GE
%left '!'
%left '+' '-'
%left '*' '/' '%'
%left '(' ')' '[' ']'

%%

expr:	location
	|	method_call
	|	literal
	|	expr bin_op expr
	|	'-' expr
	|	'!' expr
	|	'(' expr ')'
	;

location:	ID
		|	ID '[' expr ']'
		;


method_call:	method_name '(' method_arguments ')'
			|	CALLOUT '(' str_lit ')'
			|	CALLOUT '(' str_lit ',' callout_arguments ')'
			;

method_name:	ID
			;

method_arguments:	expr
				|	str_lit
				;

callout_arguments:	expr
				|	str_lit
				;

literal:	int_lit
		|	char_lit
		|	bool_lit
		;

int_lit:	DECIMAL
		|	HEXADECIMAL
		;

char_lit:	ALPHA
		;

str_lit:	char_lit
		|	ALPHA str_lit
		;

bin_op:		arith_op
		|	rel_op
		|	eq_op
		|	cond_op
		;

arith_op:	'+'
		|	'-'
		|	'*'
		|	'/'
		|	'%'
		;

rel_op:		'<'
		|	'>'
		|	LE
		|	GE

eq_op:		EE
		|	NE

cond_op:	ANDAND
		|	OROR

bool_lit:	TRUE_INP
		|	FALSE_INP


%%

int main(int argc, char **argv)
{
	while(yyparse());
	printf("Parsing Over\n");
}

