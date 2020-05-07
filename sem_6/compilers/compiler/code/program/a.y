%{
#include <stdio.h>
#include <stdlib.h>
extern FILE *fp;
int yylex(void);
void yyerror(char const *);
%}
%token INT FLOAT CHAR DOUBLE VOID
%token FOR WHILE 
%token SWITCH CASE BREAK 
%token IF ELSE PRINTF SCANF
%token STRUCT 
%token NUM ID
%token INCLUDE
%token DOT
%right '='
// left associativity
%left AND OR
%left '<' '>' LE GE EQ NE LT GT INC DEC
%left PERCENT AMPERSEND

%expect 35
%%
start:	Function 		
	| Declaration
	;
/* Declaration block */
Declaration: Type Assignment ';' 
	| Assignment ';'  {	printf("\nExpression accepted ==> Result = %d\n", $$); }
	| FunctionCall ';' 	
	| ArrayUsage ';'	
	| Type ArrayUsage ';'   
	| StructStmt ';'	
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
	| NUM '+' Assignment	{$$ = $1 + $3;}
	| NUM '-' Assignment	{$$ = $1 - $3;}
	| NUM '*' Assignment	{$$ = $1 * $3;}
	| NUM '/' Assignment	{$$ = $1 / $3;}
	| NUM OR Assignment		{$$ = $1 || $3;}
	| NUM AND Assignment	{$$ = $1 && $3;}	
	| NUM LE Assignment		{$$ = $1 <= $3;} 
	| NUM GE Assignment		{$$ = $1 >= $3;}
	| NUM NE Assignment		{$$ = $1 != $3;}
	| NUM EQ Assignment		{$$ = $1 == $3;}
	| NUM GT Assignment		{$$ = $1 > $3;}
	| NUM LT Assignment		{$$ = $1 < $3;}
	| ID OR Assignment		
	| ID AND Assignment		
	| ID LE Assignment		
	| ID GE Assignment		
	| ID NE Assignment		
	| ID EQ Assignment		
	| ID GT Assignment		
	| ID LT Assignment	
	| INC Assignment		
	| Assignment INC
	| DEC Assignment		
	| Assignment DEC
	| PERCENT Assignment
	| AMPERSEND Assignment	
	| '{' Assignment '}'
	|   NUM
	|   ID				
	;
/* Function Call Block */
FunctionCall: ID'('')'
	| ID'('Assignment')'
	;
/* Array Usage */
ArrayUsage: ID'['Assignment']'
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
	|   Assignment
	| ';'	
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
/* Struct Statement */
StructStmt: STRUCT ID '{' Type Assignment '}'  
	;
/* Print Function */
PrintFunc: PRINTF '(' '\"' Expr '\"' ')' ';'
	|		PRINTF '(' '\"' ExprList  '\"' ')' ';'
	|		PRINTF '(' '\"' Expr '\"' ',' Expr')' ';'
	;
/* Scan Function */
ScanFunc: SCANF '(' '\"' ExprList '\"' ',' Expr')' ';'
	;
/* Case Statement */
CaseStmt: CASE NUM ':'  Stmt                
	;
/* Break Function */
BreakFunc: BREAK ';'
	;

/* Switch Function */
SwitchFunc: SWITCH '(' Expr ')' '{' StmtList '}'
;
/*Expression Block*/
ExprList: ExprList Expr
	|	Expr
	;
Expr: Assignment	
	| ArrayUsage 
	;
%%
#include"lex.yy.c"
#include<ctype.h>

int flag, flag2=1;
int main(int argc, char *argv[])
{
	yyin = fopen(argv[1], "r");
	printf("\n----OUTPUT----\n");
	flag = yyparse();
   if(!flag)
    {
		if(flag2)
		{
			printf("\nParsing completed successfully without any errors.\n");
		}
		else
			printf("\nParsing unsuccessful\n");
	}
		
	else
		printf("\nParsing failed\n");
	
	fclose(yyin);
    return 0;
}       
yyerror(char const *s) {
	flag2=0;
	printf("=> line %d: %s %s\n", yylineno, s, yytext );
}         

