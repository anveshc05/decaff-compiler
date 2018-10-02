%{
	#include "parser.tab.h"
	int lineno=0;
%}

digit [0-9]
alpha [a-zA-Z]
str \"({alpha}|{digit}|%)*\"
id_reg {alpha}({alpha}|{digit})*
dec ^[0-9]*(\.[0-9]+)?$
hex 0x(digit|[A-Fa-f])+ 

%%
"(" 				{printf("("); return '(';}
")" 				{printf(")"); return ')';}
"[" 				{printf("["); return '[';}
"]" 				{printf("]"); return ']';}
"{" 				{printf("{"); return '{';}
"}" 				{printf("}"); return '}';}
"+" 				{printf("+"); return '+';}
"-" 				{printf("-"); return '-';}
"*" 				{printf("*"); return '*';}
";"					{printf(";"); return ';';}
"/" 				{printf("/"); return '/';}
"%" 				{printf("%%"); return '%';}
\n					{printf("\n"); ++lineno;}
"||" 				{printf("||"); return OROR;}
"&&" 				{printf("&&"); return ANDAND;}
"!" 				{printf("!"); return '!';}
"==" 				{printf("=="); return EE;}
"!=" 				{printf("!="); return NE;}
">=" 				{printf(">="); return GE;}
"<=" 				{printf("<="); return LE;}
">" 				{printf(">"); return '>';}
"<" 				{printf("<"); return '<';}
"+="				{printf("+="); return PE;}
"-="				{printf("-="); return ME;}
"="					{printf("="); return EQ;}
"," 				{printf(","); return ',';}
"'"					{printf("'"); return SIC;}
"class"				{printf("class"); return CLASS;}
"Program"			{printf("Program"); return PROGRAM;}
"int"				{printf("int"); return INT;}
"boolean"			{printf("boolean"); return BOOLEAN;}
"void"				{printf("void"); return VOID;}
"if"				{printf("if"); return IF;}
"else"				{printf("else"); return ELSE;}
"for"				{printf("for"); return FOR;}
"return"			{printf("return"); return RETURN;}
"break"				{printf("break"); return BREAK;}
"continue"			{printf("continue"); return CONTINUE;}
"callout" 			{printf("CALLOUT"); return CALLOUT;}
"true" 				{printf("true"); return TRUE_INP;}
"false" 			{printf("false"); return FALSE_INP;}
{str}				{printf("str"); return STR;}
{dec}				{printf("dec"); return DECIMAL;}
{hex}				{printf("hex"); return HEXADECIMAL;}
{id_reg}			{printf("ID"); return ID;}
.					{ printf("Line No %d: Unrecognized Character\n", lineno);}
%%