%{
	#include<stdio.h>
	int yylex();
	void yyerror(char *s)
	{
		fprintf(stderr, "error: %s\n", s);
	}
%}

%start program
%token CLASS
%token PROGRAM
%token ID
%token DECIMAL
%token HEXADECIMAL
%token TRUE_INP
%token FALSE_INP
%token ALPHA
%token CALLOUT
%token SIC
%token STR
%token INT
%token BOOLEAN
%token VOID
%token IF
%token ELSE
%token FOR
%token RETURN
%token BREAK
%token CONTINUE

%left ','
%right '=' PE ME
%left OROR
%left ANDAND
%left EE NE
%left '<' '>' LE GE
%left '!'
%left '+' '-'
%left '*' '/' '%'
%left '(' ')' '[' ']'

%%

program:	CLASS PROGRAM '{' /* empty */'}'
		|	CLASS PROGRAM '{' fields '}'
		;

fields:		field_declaration
		|	field_declaration fields
		|	method_declaration
		|	method_declaration fields

field_declaration:	type vars ';'
				;

vars:	var
	|	var ',' vars
	;

var:	ID
	|	ID '[' int_lit ']'
	;

method_declaration:	type ID '(' /* empty */ ')' block 
				|	type ID  '(' method_declaration_args ')' block
				|	VOID ID '(' ')' block
				|	VOID ID  '(' method_declaration_args ')' block
				;

method_declaration_args:	type ID
					|		method_declaration_args ',' type ID
					;


block:	'{' block_declarations '}'
	;

block_declarations:	/* empty */
				|	variable_decl block_declarations
				|	statement block_declarations
				;

variable_decl:	type variables ';'
			;

variables:	ID
		|	ID ',' variables
		;

statement:	location assign_op expr ';'
		|	method_call ';'
		|	IF '(' expr ')' block 
		|	IF '(' expr ')' block ELSE block
		|	FOR ID '=' expr ',' expr block
		|	RETURN ';'
		|	RETURN expr ';'
		|	BREAK ';'
		|	CONTINUE ';'
		|	block
		;

assign_op:	'='
		|	PE
		|	ME
		;

type:	INT
	| BOOLEAN
	;

expr:	location
	|	literal
	|	method_call
	|	expr bin_op expr
	|	'-' expr
	|	'!' expr
	|	'(' expr ')'
	;

location:	ID
		|	ID '[' expr ']'
		;


method_call:	ID '(' method_arguments ')'
			|	CALLOUT '(' str_lit ')'
			|	CALLOUT '(' str_lit ',' callout_arguments ')'
			;

method_arguments:	common_arg
				|	common_arg ',' method_arguments
				;

callout_arguments:	common_arg
				|	common_arg ',' callout_arguments
				;

common_arg:		expr
		|		str_lit
		;

literal:	int_lit
		|	char_lit
		|	bool_lit
		;

int_lit:	DECIMAL
		|	HEXADECIMAL
		;

char_lit:	SIC ALPHA SIC
		;

str_lit:	STR
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

