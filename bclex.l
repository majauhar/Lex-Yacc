/*
	Content: Lexical Analyser for a Basic Calculator
	Author: Mohd Ali Jauhar (17COB119) 
*/
letter	[A-Za-z]
digits	[0-9]+
%{
	#include <stdio.h>
	#include <stdlib.h>
	void yyerror() {
		printf("Input does not match to any acceptable token!\n");
		exit(0);
	}

	void print_variable(char *yytext,int yyleng) {
		printf("Variable Token: <");
		for (int i = 0; i < yyleng; i++) {
			printf("%c", *(yytext+i));
		}
		printf(">\n");
	}

	void print_num(char *yytext, int yyleng) {
		int flag = 0;
		printf("Number Token: <");
		for (int i = 0; i < yyleng; i++) {	
			if(*(yytext+i) == '.') {
				printf("%.3f>\n", atof(yytext));
				flag = 1;
				break;
			}
		}
		if(flag == 0) {
			printf("%d>\n", atoi(yytext));
		}
	}

	void print_operator(char *yytext) {
		printf("Character Token: <%c>\n", *yytext);
	}
		
		
%}

%%
{letter}+				{ print_variable(yytext, yyleng); }  /* printf("Token generated of variable type: "); ECHO; printf("\n"); }*/
{digits}(.{digits})?			{ print_num(yytext, yyleng); /*printf("Token generated of a number value: %.4f\n", atof(yytext));*/ }
[-+()=/*^%]				{ print_operator(yytext); /*printf("Token generated of operator type: %c\n", *yytext);*/ }
[ \n\t]					;
.					{ yyerror(); }

%%

int yywrap() {
	printf("Bye!\n");
	return 1;
}

int main(){
	printf("Welcome to the lexical analyser for a basic calculator\nIt accepts variables of any length consisting only of lowercase and uppercase Latin Alphabets.\nIt accepts floating point numbers and integers.\nThe supported operators are: +, -, =, /, *, %%, ^, (, )\nAnything else is not accepted, and the program will abort on such inputs\n");
	yylex();
	return 0;
}
