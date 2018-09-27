%{
	#include "parser.tab.h"
	int lineno=0;
%}

digit [0-9]
alpha [a-zA-Z]
id_reg {alpha}({alpha}|{digit})*
dec ^[0-9]*(\.[0-9]+)?$
hex 0x(digit|[A-Fa-f])+ 

%%
"(" 				{return '(';}
")" 				{return ')';}
"[" 				{return '[';}
"]" 				{return ']';}
"+" 				{return '+';}
"-" 				{return '-';}
"*" 				{return '*';}
"/" 				{return '/';}
"%" 				{return '%';}
\n					{++lineno;}
"||" 				{return OROR;}
"&&" 				{return ANDAND;}
"!" 				{return '!';}
"==" 				{return EE;}
"!=" 				{return NE;}
">=" 				{return GE;}
"<=" 				{return LE;}
">" 				{return '>';}
"<" 				{return '<';}
"," 				{return ',';}
"callout" 			{return CALLOUT;}
"true" 				{return TRUE_INP;}
"false" 			{return FALSE_INP;}
{hex}				{return HEXADECIMAL;}
{dec}				{return DECIMAL;}
{id_reg}			{return ID;}
.					{ printf("Line No %d: Unrecognized Character\n", lineno);}

%%