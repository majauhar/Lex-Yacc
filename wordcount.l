%{
	int nchar, nword, nline;
%}

%%
\n		{ nline++; nchar++; }
[^ \t\n]+	{ nword++, nchar += yyleng; }
.		{ nchar++; }
%%

int main() {
	yylex();
	printf("No of character: %d\tNo of words: %d\tNo of lines: %d\n", nchar, nword, nline);
	return 0;
}

int yywrap() {
	return 1;
}
