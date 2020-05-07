%{
#include <stdio.h>
#include <stdlib.h>

extern FILE *fp;

%}

%token INT FLOAT CHAR DOUBLE VOID
%token FOR WHILE 
%token SWITCH CASE BREAK 
%token IF ELSE PRINTF SCANF 
%token NUM ID
%token INCLUDE
%token DOT

%right '='
%left AND OR
%left '<' '>' LE GE EQ NE LT GT INC DEC
%left PERCENT AMPERSEND
%%

start:	Function 
	| Declaration
	;

/* Declaration block */
Declaration: Type Assignment ';' 
	| Assignment ';'  	
	| FunctionCall ';' 	
	| ArrayUsage ';'	
	| Type ArrayUsage ';'   
	| error	
	;

/* Assignment block */
Assignment: ID '=' Assignment
	| ID '=' FunctionCall
	| ID '=' ArrayUsage
	| ArrayUsage '=' Assignment
	| ID ',' Assignment
	| NUM ',' Assignment
	| ID '+' Assignment
	| ID '-' Assignment
	| ID '*' Assignment
	| ID '/' Assignment	
	| NUM '+' Assignment
	| NUM '-' Assignment
	| NUM '*' Assignment
	| NUM '/' Assignment
	| INC Assignment
	| Assignment INC
	| DEC Assignment
	| Assignment DEC
	| '\'' Assignment '\''	
	| '(' Assignment ')'
	| '-' '(' Assignment ')'
	| '{' Assignment '}'
	| '-' NUM
	| '-' ID
	|   NUM
	|   ID
	;

/* Function Call Block */
FunctionCall : ID'('')'
	| ID'('Assignment')'
	;

/* Array Usage */
ArrayUsage : ID'['Assignment']'
	| ID'['Assignment']''['Assignment']'
	;

/* Function block */
Function: Type ID '(' ArgListOpt ')' CompoundStmt 
	;
ArgListOpt: ArgList
	|
	;
ArgList:  ArgList ',' Arg
	| Arg
	;
Arg:	Type ID
	;
CompoundStmt:	'{' StmtList '}'
	;
StmtList:	StmtList Stmt
	|
	;
Stmt:	WhileStmt
	| 	Declaration
	| 	ForStmt
	| 	IfStmt
	| 	PrintFunc
	|	ScanFunc
	|	SwitchFunc
	|	CaseStmt
	|	BreakFunc	
	;

/* Type Identifier block */
Type:	INT 
	| 	FLOAT
	| 	CHAR
	| 	DOUBLE
	| 	VOID 
	;

/* While Blocks */ 
WhileStmt: WHILE '(' Expr ')' Stmt  
	| WHILE '(' Expr ')' CompoundStmt 
	;

/* For Block */
ForStmt: FOR '(' Type Expr ';' Expr ';' Expr ')' '{' StmtList  '}'
       | FOR '(' Expr ';' Expr ';' Expr ')' CompoundStmt 
       | FOR '(' Expr ')' Stmt 
       | FOR '(' Expr ')' CompoundStmt 
	;

/* IfStmt Block */
IfStmt: IF '(' Expr ')' Stmt ELSE Stmt
	| IF '(' Expr ')' Stmt
	| IF'(' Expr ')' Stmt ELSE CompoundStmt
    | IF '(' Expr ')' CompoundStmt 
	| IF'(' Expr ')' CompoundStmt ELSE CompoundStmt
	;

/* Print Function */
PrintFunc: PRINTF '(' '\"' Expr '\"' ')' ';'
	|		PRINTF '(' '\"' ExprList  '\"' ')' ';'
	|		PRINTF '(' '\"' Expr '\"' ',' Expr')' ';'
	;

/* Scan Function */
ScanFunc: SCANF '(' '\"' Expr '\"' ',' Expr')' ';'
	;

/* Case Statement */
CaseStmt: CASE Expr ':' Stmt
	;

/* Break Function */
BreakFunc: BREAK ';'
	;

/* Switch Function */
SwitchFunc: SWITCH '(' Expr ')' '{' StmtList '}'


/*Expression Block*/
ExprList: ExprList Expr
	|	Expr
	;
Expr:	
	| Expr LE Expr 
	| Expr GE Expr
	| Expr NE Expr
	| Expr EQ Expr
	| Expr GT Expr
	| Expr LT Expr
	| PERCENT Expr
	| AMPERSEND Expr
	| Assignment
	| ArrayUsage 
	;
%%
#include"lex.yy.c"
#include<ctype.h>
int count=0;

int main(int argc, char *argv[])
{
	yyin = fopen(argv[1], "r");
	
   if(!yyparse())
		printf("\nParsing complete\n");
	else
		printf("\nParsing failed\n");
	
	fclose(yyin);
    return 0;
}
         
yyerror(char *s) {
	printf("%d : %s %s\n", yylineno, s, yytext );
}         

