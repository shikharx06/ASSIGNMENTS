alpha [a-zA-Z]  
digit [0-9]     

%%
[ \t]		;               /*Assigning tab space here*/
[ \n]   { yylineno = yylineno + 1;}  /*Assigning \n to change the line or increment the line by one*/

int	return INT;
float return FLOAT;
char return CHAR;       
double return DOUBLE;       /*grouping data types*/

for 	return FOR;
while	return WHILE;       /*grouping looping statements*/

if	return IF;
else	return ELSE;
switch  return SWITCH;  
case    return CASE;  
break   return BREAK;       /*grouping control statements */

printf  return PRINTF;
scanf   return SCANF;       /*grouping  Input-output functions */



void return VOID;
^"#include ".+ ;             /*grouping Reserved keywords*/
{digit}+       return NUM;    /*Defining NUM as a set of digit which already had been declared above*/  
{alpha}({alpha}|{digit})* return ID;  /*Defining ID as a set of digit and alpha which already had been declared above*/ 
"<="    return LE;
">="    return GE;
"=="    return EQ;
"!="    return NE;
">"	    return GT;
"<"	    return LT;
"."     return DOT;
"%"     return PERCENT;
"&"     return AMPERSEND;
"++"    return INC;
"--"    return DEC;           /*grouping all the operators*/
\/\/.* ;
\/\*(.*\n)*.*\*\/ ;
.       return yytext[0];      /*Return yytext to  0 when the lex file execute witout any error*/
%%
