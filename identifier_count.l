letters		[A-Za-z]
digits		[0-9]

%{
	int count=0;
%}
%%
{letters}({letters}|{digits})*	count++;
%%

int main() {
	yylex();
	printf("Total number of identifiers is: %d\n", count);
	return 0;
}
	/* defining yywrap() is idiomatic in the sense that its just here to not break the code */
	/* Actually yylex() needs it to wrap up the program */
int yywrap() {
	return 1;
}
