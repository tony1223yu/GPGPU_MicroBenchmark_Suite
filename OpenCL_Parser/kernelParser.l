D			[0-9]
L			[a-zA-Z_]
H			[a-fA-F0-9]
E			([Ee][+-]?{D}+)
P                       ([Pp][+-]?{D}+)
FS			(f|F|l|L)
IS                      ((u|U)|(u|U)?(l|L|ll|LL)|(l|L|ll|LL)(u|U))

%{
#include <stdio.h>
#include "symbolTable.h"
#include "kernelParser.h"
#include "y.tab.h"

/* L?\"(\\.|[^\\"\n])*\"	{ printf("string : \"%s\"\n", yytext); count(); return(STRING_LITERAL); } */
void count(void);
void comment(void);
%}

%%
"/*"			{ comment(); }
"//"[^\n]*              { /* consume //-comment */ }

"__kernel"      { count(); return(KERNEL); }
"__global"      { count(); return(ADDRESS_GLOBAL); }
"__local"      { count(); return(ADDRESS_LOCAL); }
"__constant"      { count(); return(ADDRESS_CONSTANT); }
"__private"      { count(); return(ADDRESS_PRIVATE); }
"get_global_id"     { count(); return(GLOBAL_ID_FUNC); }
"get_global_size"   { count(); return(GLOBAL_SIZE_FUNC); }
"get_local_id"      { count(); return(LOCAL_ID_FUNC); }
"get_local_size"    { count(); return(LOCAL_SIZE_FUNC); }

"float"           { count(); yylval.op_type = (FLOAT_TYPE); return (OPENCL_TYPE); }
"float2"          { count(); yylval.op_type = (FLOAT2_TYPE); return (OPENCL_TYPE); }
"float4"          { count(); yylval.op_type = (FLOAT4_TYPE); return (OPENCL_TYPE); }
"float8"          { count(); yylval.op_type = (FLOAT8_TYPE); return (OPENCL_TYPE); }
"float16"          { count(); yylval.op_type = (FLOAT16_TYPE); return (OPENCL_TYPE); }
"double"           { count(); yylval.op_type = (DOUBLE_TYPE); return (OPENCL_TYPE); }
"double2"          { count(); yylval.op_type = (DOUBLE2_TYPE); return (OPENCL_TYPE); }
"double4"          { count(); yylval.op_type = (DOUBLE4_TYPE); return (OPENCL_TYPE); }
"double8"          { count(); yylval.op_type = (DOUBLE8_TYPE); return (OPENCL_TYPE); }
"double16"          { count(); yylval.op_type = (DOUBLE16_TYPE); return (OPENCL_TYPE); }
"char2"          { count(); yylval.op_type = (CHAR2_TYPE); return (OPENCL_TYPE); }
"char4"          { count(); yylval.op_type = (CHAR4_TYPE); return (OPENCL_TYPE); }
"char8"          { count(); yylval.op_type = (CHAR8_TYPE); return (OPENCL_TYPE); }
"char16"          { count(); yylval.op_type = (CHAR16_TYPE); return (OPENCL_TYPE); }
"short"           { count(); yylval.op_type = (SHORT_TYPE); return (OPENCL_TYPE); }
"short2"          { count(); yylval.op_type = (SHORT2_TYPE); return (OPENCL_TYPE); }
"short4"          { count(); yylval.op_type = (SHORT4_TYPE); return (OPENCL_TYPE); }
"short8"          { count(); yylval.op_type = (SHORT8_TYPE); return (OPENCL_TYPE); }
"short16"          { count(); yylval.op_type = (SHORT16_TYPE); return (OPENCL_TYPE); }
"int"           { count(); yylval.op_type = (INT_TYPE); return (OPENCL_TYPE); }
"int2"          { count(); yylval.op_type = (INT2_TYPE); return (OPENCL_TYPE); }
"int4"          { count(); yylval.op_type = (INT4_TYPE); return (OPENCL_TYPE); }
"int8"          { count(); yylval.op_type = (INT8_TYPE); return (OPENCL_TYPE); }
"int16"          { count(); yylval.op_type = (INT16_TYPE); return (OPENCL_TYPE); }
"long"           { count(); yylval.op_type = (LONG_TYPE); return (OPENCL_TYPE); }
"long2"          { count(); yylval.op_type = (LONG2_TYPE); return (OPENCL_TYPE); }
"long4"          { count(); yylval.op_type = (LONG4_TYPE); return (OPENCL_TYPE); }
"long8"          { count(); yylval.op_type = (LONG8_TYPE); return (OPENCL_TYPE); }
"long16"          { count(); yylval.op_type = (LONG16_TYPE); return (OPENCL_TYPE); }
"uchar" | "unsigned char"           { count(); yylval.op_type = (UCHAR_TYPE); return (OPENCL_TYPE); }
"uchar2"          { count(); yylval.op_type = (UCHAR2_TYPE); return (OPENCL_TYPE); }
"uchar4"          { count(); yylval.op_type = (UCHAR4_TYPE); return (OPENCL_TYPE); }
"uchar8"          { count(); yylval.op_type = (UCHAR8_TYPE); return (OPENCL_TYPE); }
"uchar16"          { count(); yylval.op_type = (UCHAR16_TYPE); return (OPENCL_TYPE); }
"ushort" | "unsigned short"           { count(); yylval.op_type = (USHORT_TYPE); return (OPENCL_TYPE); }
"ushort2"          { count(); yylval.op_type = (USHORT2_TYPE); return (OPENCL_TYPE); }
"ushort4"          { count(); yylval.op_type = (USHORT4_TYPE); return (OPENCL_TYPE); }
"ushort8"          { count(); yylval.op_type = (USHORT8_TYPE); return (OPENCL_TYPE); }
"ushort16"          { count(); yylval.op_type = (USHORT16_TYPE); return (OPENCL_TYPE); }
"uint" | "unsigned int"           { count(); yylval.op_type = (UINT_TYPE); return (OPENCL_TYPE); }
"uint2"          { count(); yylval.op_type = (UINT2_TYPE); return (OPENCL_TYPE); }
"uint4"          { count(); yylval.op_type = (UINT4_TYPE); return (OPENCL_TYPE); }
"uint8"          { count(); yylval.op_type = (UINT8_TYPE); return (OPENCL_TYPE); }
"uint16"          { count(); yylval.op_type = (UINT16_TYPE); return (OPENCL_TYPE); }
"ulong" | "unsigned long"           { count(); yylval.op_type = (ULONG_TYPE); return (OPENCL_TYPE); }
"ulong2"          { count(); yylval.op_type = (ULONG2_TYPE); return (OPENCL_TYPE); }
"ulong4"          { count(); yylval.op_type = (ULONG4_TYPE); return (OPENCL_TYPE); }
"ulong8"          { count(); yylval.op_type = (ULONG8_TYPE); return (OPENCL_TYPE); }
"ulong16"          { count(); yylval.op_type = (ULONG16_TYPE); return (OPENCL_TYPE); }
"bool"			{ count(); yylval.op_type = (BOOL_TYPE); return (OPENCL_TYPE); }
"half"          { count(); yylval.op_type = (HALF_TYPE); return (OPENCL_TYPE); }
"void"			{ count(); yylval.op_type = (VOID_TYPE); return (OPENCL_TYPE); }

"auto"			{ count(); return(AUTO); }
"break"			{ count(); return(BREAK); }
"case"			{ count(); return(CASE); }
"const"			{ count(); return(CONST); }
"continue"		{ count(); return(CONTINUE); }
"default"		{ count(); return(DEFAULT); }
"do"			{ count(); return(DO); }
"else"			{ count(); return(ELSE); }
"enum"			{ count(); return(ENUM); }
"extern"		{ count(); return(EXTERN); }
"for"			{ count(); return(FOR); }
"goto"			{ count(); return(GOTO); }
"if"			{ count(); return(IF); }
"inline"		{ count(); return(INLINE); }
"register"		{ count(); return(REGISTER); }
"restrict"		{ count(); return(RESTRICT); }
"return"		{ count(); return(RETURN); }
"sizeof"		{ count(); return(SIZEOF); }
"static"		{ count(); return(STATIC); }
"struct"		{ count(); return(STRUCT); }
"switch"		{ count(); return(SWITCH); }
"typedef"		{ count(); return(TYPEDEF); }
"union"			{ count(); return(UNION); }
"volatile"		{ count(); return(VOLATILE); }
"while"			{ count(); return(WHILE); }

{L}({L}|{D})*		{ count(); return(check_type()); }


 /* TODO: seperate int/long and float/double */
0[xX]{H}+{IS}?		{ count(); yylval.op_type = INT_TYPE; return(CONSTANT); }
0[0-7]*{IS}?		{ count(); yylval.op_type = INT_TYPE; return(CONSTANT); }
[1-9]{D}*{IS}?		{ count(); yylval.op_type = INT_TYPE; return(CONSTANT); }
L?'(\\.|[^\\'\n])+'	{ count(); yylval.op_type = INT_TYPE; return(CONSTANT); }

{D}+{E}{FS}?		{ count(); yylval.op_type = DOUBLE_TYPE; return(CONSTANT); }
{D}*"."{D}+{E}?{FS}?	{ count(); yylval.op_type = DOUBLE_TYPE; return(CONSTANT); }
{D}+"."{D}*{E}?{FS}?	{ count(); yylval.op_type = DOUBLE_TYPE; return(CONSTANT); }
0[xX]{H}+{P}{FS}?	{ count(); yylval.op_type = DOUBLE_TYPE; return(CONSTANT); }
0[xX]{H}*"."{H}+{P}?{FS}?     { count(); yylval.op_type = DOUBLE_TYPE; return(CONSTANT); }
0[xX]{H}+"."{H}*{P}?{FS}?     { count(); yylval.op_type = DOUBLE_TYPE; return(CONSTANT); }


L?\"([^"]|\\.)*\" { count(); return(STRING_LITERAL); }

"..."			{ count(); return(ELLIPSIS); }
">>="			{ count(); return(RIGHT_ASSIGN); }
"<<="			{ count(); return(LEFT_ASSIGN); }
"+="			{ count(); return(ADD_ASSIGN); }
"-="			{ count(); return(SUB_ASSIGN); }
"*="			{ count(); return(MUL_ASSIGN); }
"/="			{ count(); return(DIV_ASSIGN); }
"%="			{ count(); return(MOD_ASSIGN); }
"&="			{ count(); return(AND_ASSIGN); }
"^="			{ count(); return(XOR_ASSIGN); }
"|="			{ count(); return(OR_ASSIGN); }
">>"			{ count(); return(RIGHT_OP); }
"<<"			{ count(); return(LEFT_OP); }
"++"			{ count(); return(INC_OP); }
"--"			{ count(); return(DEC_OP); }
"->"			{ count(); return(PTR_OP); }
"&&"			{ count(); return(AND_OP); }
"||"			{ count(); return(OR_OP); }
"<="			{ count(); return(LE_OP); }
">="			{ count(); return(GE_OP); }
"=="			{ count(); return(EQ_OP); }
"!="			{ count(); return(NE_OP); }
";"			{ count(); return(';'); }
("{"|"<%")		{ count(); return('{'); }
("}"|"%>")		{ count(); return('}'); }
","			{ count(); return(','); }
":"			{ count(); return(':'); }
"="			{ count(); return('='); }
"("			{ count(); return('('); }
")"			{ count(); return(')'); }
("["|"<:")		{ count(); return('['); }
("]"|":>")		{ count(); return(']'); }
"."			{ count(); return('.'); }
"&"			{ count(); return('&'); }
"!"			{ count(); return('!'); }
"~"			{ count(); return('~'); }
"-"			{ count(); return('-'); }
"+"			{ count(); return('+'); }
"*"			{ count(); return('*'); }
"/"			{ count(); return('/'); }
"%"			{ count(); return('%'); }
"<"			{ count(); return('<'); }
">"			{ count(); return('>'); }
"^"			{ count(); return('^'); }
"|"			{ count(); return('|'); }
"?"			{ count(); return('?'); }

[ \t\v\n\f]		{ count(); }
.			{ /* Add code to complain about unmatched characters */ }

%%

int yywrap(void)
{
	return 1;
}


void comment(void)
{
	char c, prev = 0;
  
	while ((c = input()) != 0)      /* (EOF maps to 0) */
	{
		if (c == '/' && prev == '*')
			return;
		prev = c;
	}
	error("unterminated comment");
}


int column = 0;

void count(void)
{
	int i;

	for (i = 0; yytext[i] != '\0'; i++)
		if (yytext[i] == '\n')
			column = 0;
		else if (yytext[i] == '\t')
			column += 8 - (column % 8);
		else
			column++;

	//ECHO;
}


int check_type(void)
{
/*
* pseudo code --- this is what it should check
*
*	if (yytext == type_name)
*		return TYPE_NAME;
*
*	return IDENTIFIER;
*/

/*
*	it actually will only return IDENTIFIER
*/

    OP_TYPE type = FindSymbolInTable(yytext, SYMBOL_TYPENAME);
    if (type != NONE_TYPE)
    {
        yylval.op_type = type;
        return TYPE_NAME;
    }
    else
    {
        yylval.ptr = strdup(yytext);
        if (!yylval.ptr)
        {
            fprintf(stderr, "out of memory\n");
            exit(1);
        }
        return IDENTIFIER;
    }
}
