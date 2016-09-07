	#include <iostream>
	#define pval(val) printf("%s[%s] ", val, yytext ); fflush(stdout)
	extern "C" int yylex();
	
DOT                "\."
BRACKET_OPEN       "("
BRACKET_CLOSE      ")"
COMMA              ","
NEWLINE            "\n"
TOADD              "+="
TOREMOVE           "-="
ADDIFNOTSET        "\*="
REPLACEREGEX       "~="
PLUS               "\+"
MINUS              "-"
MULTIPLY           "*"
DIVIDE             "/"
UNDERSCORE         "_"
BRACE_OPEN         "{"
BRACE_CLOSE        "}"
HASH               "#"
QUOTE              "\""
DOLLAR             "$"
DOUBLE_DOLLAR      {DOLLAR}{DOLLAR}
BANG               "!"
EQUAL              "="
SEMICOLON          ";"

INT           [[:digit:]]+
FLOAT         {INT}{DOT}{INT}


CHAR          [[:alnum:]_\-\.\$/\[\]\&<>*'@^?`%+]

STRING        {CHAR}+

STRING_IN     {QUOTE}[^\n]*{QUOTE}

FUNCNAME      {CHAR}+" "*{BRACKET_OPEN}
USER_FUNC     {DOUBLE_DOLLAR}{FUNCNAME}

COMMENT       {HASH}.*{NEWLINE}

ENV_VAR       {DOUBLE_DOLLAR}{BRACKET_OPEN}{CHAR}+{BRACKET_CLOSE}
QMAKE_VAR     {DOUBLE_DOLLAR}{BRACE_OPEN}?{CHAR}+{BRACE_CLOSE}?

SPACE         [" "\t]+
MULTILINE     "\\"[[:space:]]*
COND_AND      " "*":"" "*
COND_OR      " "*"|"" "*


%%

{NEWLINE}+        /*pval( "LINE_END");*/ printf( "\n" );

{USER_FUNC}       pval( "USER_FUNC_START" );
{FUNCNAME}        pval( "FUNC_START" );

{ENV_VAR}         pval( "ENV_VAR" );
{QMAKE_VAR}       pval( "QMAKE_VAR" );


{INT}             pval( "INT" );
{FLOAT}           pval( "FLOAT" );

{COMMENT}         pval( "COMMENT");
{STRING}          pval( "STRING" );
{SEMICOLON}       pval( "STRING" );
{STRING_IN}       pval( "STRING" );

{BANG}            pval( "NOT" );

{BRACKET_OPEN}    pval( "BRACKET_OPEN" );
{BRACKET_CLOSE}   pval( "BRACKET_CLOSE" );
{EQUAL}           pval( "EQUAL" );
{SPACE}           // pval("SPACE" );

{COND_AND}        pval( "COND_AND" );
{COND_OR}         pval( "COND_OR" );

{BRACE_OPEN}      pval( "BLOCK OPEN" );
{BRACE_CLOSE}     pval( "BLOCK CLOSE" );



{COMMA}           pval( "COMMA" );
{TOADD}           pval( "TOADD" );
{TOREMOVE}        pval( "TOREMOVE" );
{REPLACEREGEX}    pval( "REPLACEREGEX" );
{ADDIFNOTSET}     pval( "ADD_IF_NOT_SET" );
{MULTILINE}       // pval( "MULTILINE" );
{PLUS}            pval( "PLUS" );

[^{CHAR}\r]         fprintf(stderr, "\nERROR parse(%s)\n", yytext); exit(1);

%%



int main()
{
    yylex();
    return 0;
}

