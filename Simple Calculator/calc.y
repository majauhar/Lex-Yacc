%{
	#include <stdio.h>
	int yylex(void);
	void yyerror(char *);
	int yylex();
	int sym[26];
%}

%token INTEGER VARIABLE
%left '+' '-'
%left '*' '/' '%'

%%

program:
    program statement '\n'	/* does nothing */
	|
	;

statement:
    expr			        { printf("%d\n", $1); }
	| VARIABLE '=' expr	    { sym[$1] = $3; }
	;

expr:                   /* E -> id */
    INTEGER
	| VARIABLE		        { $$ = sym[$1]; }
                        /* E -> E + E */
    | expr '+' expr		    { $$ = $1 + $3; }
                        /* E -> E - E */
	| expr '-' expr		    { $$ = $1 - $3; }
                        /* E = E * E */
	| expr '*' expr		    { $$ = $1 * $3; }
                        /* E = E / E */
	| expr '/' expr		    { $$ = $1 / $3; }
    | expr '%' expr         { $$ = $1 % $3; }
	| '(' expr ')'		    { $$ = $2; }
	;

%%

void yyerror(char *s) {
	fprintf(stderr, "%s\n", s);
}
int main() {
	yyparse();
	return 0;
}
