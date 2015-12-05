%{
#include <stdio.h>
#include <stdlib.h>
#include "kernelParser.h"

void initial()
{
    prog = NULL;
    curFunction_h = NULL;
    curFunction_t = NULL;
    curSTMTGroup_h = NULL;
    curSTMTGroup_t = NULL;
}

PROGRAM* CreateProgram(FUNCTION* func_head, FUNCTION* func_tail)
{
    PROGRAM* tmp;
    FUNCTION* iter;

    tmp = (PROGRAM*)malloc(sizeof(PROGRAM));
    tmp->function_head = func_head;
    tmp->function_tail = func_tail;

    for (iter = func_head ; iter != NULL ; iter = iter->next)
    {
        iter->parentProgram = tmp;
    }

    return tmp;
}

void CreateFunction(char *name, STMT_GROUP* group_head, STMT_GROUP* group_tail)
{
    FUNCTION* tmp;
    STMT_GROUP* iter;
    STMT_GROUP* iter_sib;

    fprintf(stderr, "[OpenCL Parser] Add function %s\n", name);

    tmp = (FUNCTION*)malloc(sizeof(FUNCTION));
    tmp->functionName = name;
    tmp->stmt_group_head = group_head;
    tmp->stmt_group_tail = group_tail;
    tmp->next = NULL;
    tmp->parentProgram = NULL;

    for (iter = group_head ; iter != NULL ; iter = iter->next)
    {
        iter_sib = iter->sibling;
        while (iter_sib != NULL)
        {
            iter_sib->parentFunction = tmp;
            iter_sib = iter_sib->sibling;
        }
        iter->parentFunction = tmp;
    }

    if (curFunction_h == NULL)
    {
        curFunction_h = tmp;
        curFunction_t = tmp;
    }
    else
    {
        curFunction_t->next = tmp;
        curFunction_t = tmp;
    }

    curSTMTGroup_h = NULL;
    curSTMTGroup_t = NULL;
}

void CreateEmptySTMTGroup()
{
    STMT_GROUP* tmp;
    STMT* iter;

    fprintf(stderr, "[OpenCL Parser] Create empty STMT group\n");

    tmp = (STMT_GROUP*)malloc(sizeof(STMT_GROUP));
    tmp->stmt_head = NULL;
    tmp->stmt_tail = NULL;
    tmp->stmtID = 0;
    /* TODO iteration and workitemCount */
    tmp->next = NULL;
    tmp->sibling = NULL;
    tmp->parentFunction = NULL;

    if (curSTMTGroup_h == NULL)
    {
        curSTMTGroup_h = tmp;
        curSTMTGroup_t = tmp;
    }
    else
    {
        curSTMTGroup_t->next = tmp;
        curSTMTGroup_t = tmp;
    }
}

void CreateSTMT(STMT_TYPE type)
{
    STMT* tmp;
    fprintf(stderr, "[OpenCL Parser] Create STMT of type = %d\n", type);
    tmp = (STMT*)malloc(sizeof(STMT));
    tmp->id = curSTMTGroup_t->stmtID ++;
    tmp->type = type;
    tmp->parentGroup = NULL;
    tmp->issue_dep = NULL;
    tmp->structural_dep = NULL;
    tmp->data_dep = NULL;
    tmp->next = NULL;
    
    if (curSTMTGroup_t->stmt_head == NULL)
    {
        curSTMTGroup_t->stmt_head = tmp;
        curSTMTGroup_t->stmt_tail = tmp;
    }
    else
    {
        curSTMTGroup_t->stmt_tail->next = tmp;
        curSTMTGroup_t->stmt_tail = tmp;
    }
    tmp->parentGroup = curSTMTGroup_t;
}

%}

%union
{
    void *ptr;
    char *lexeme;
}

%token KERNEL GLOBAL_ID_FUNC GLOBAL_SIZE_FUNC LOCAL_ID_FUNC LOCAL_SIZE_FUNC ADDRESS_GLOBAL ADDRESS_LOCAL ADDRESS_PRIVATE ADDRESS_CONSTANT
%token UCHAR USHORT UINT ULONG INT_V UINT_V CHAR_V UCHAR_V SHORT_V USHORT_V LONG_V ULONG_V FLOAT_V DOUBLE_V

%token <lexeme> IDENTIFIER
%token CONSTANT STRING_LITERAL SIZEOF
%token PTR_OP INC_OP DEC_OP LEFT_OP RIGHT_OP LE_OP GE_OP EQ_OP NE_OP
%token AND_OP OR_OP MUL_ASSIGN DIV_ASSIGN MOD_ASSIGN ADD_ASSIGN
%token SUB_ASSIGN LEFT_ASSIGN RIGHT_ASSIGN AND_ASSIGN
%token XOR_ASSIGN OR_ASSIGN TYPE_NAME

%token TYPEDEF EXTERN STATIC AUTO REGISTER INLINE RESTRICT
%token CHAR SHORT INT LONG SIGNED UNSIGNED FLOAT DOUBLE CONST VOLATILE VOID
%token BOOL COMPLEX IMAGINARY
%token STRUCT UNION ENUM ELLIPSIS

%token CASE DEFAULT IF ELSE SWITCH WHILE DO FOR GOTO CONTINUE BREAK RETURN

%type <lexeme> declarator direct_declarator

%start program_unit
%%

program_unit
    : translation_unit {prog = CreateProgram(curFunction_h, curFunction_t);}
    ;

primary_expression
	: IDENTIFIER
	| CONSTANT
	| STRING_LITERAL
	| '(' expression ')'
    | GLOBAL_ID_FUNC
    | GLOBAL_SIZE_FUNC
    | LOCAL_ID_FUNC
    | LOCAL_SIZE_FUNC
	;

/* function call here */
postfix_expression
	: primary_expression
	| postfix_expression '[' expression ']'
	| postfix_expression '(' ')'
	| postfix_expression '(' argument_expression_list ')'
	| postfix_expression '.' IDENTIFIER
	| postfix_expression PTR_OP IDENTIFIER
	| postfix_expression INC_OP
	| postfix_expression DEC_OP
	| '(' type_name ')' '{' initializer_list '}'
	| '(' type_name ')' '{' initializer_list ',' '}'
	;

argument_expression_list
	: assignment_expression
	| argument_expression_list ',' assignment_expression
	;

unary_expression
	: postfix_expression
	| INC_OP unary_expression
	| DEC_OP unary_expression
	| unary_operator cast_expression
	| SIZEOF unary_expression
	| SIZEOF '(' type_name ')'
	;

unary_operator
	: '&'
	| '*'
	| '+'
	| '-'
	| '~'
	| '!'
	;

cast_expression
	: unary_expression
	| '(' type_name ')' cast_expression
	;

multiplicative_expression
	: cast_expression
	| multiplicative_expression '*' cast_expression {CreateSTMT(MULTIPLICATION);}
	| multiplicative_expression '/' cast_expression {CreateSTMT(DIVISION);}
	| multiplicative_expression '%' cast_expression {CreateSTMT(MODULAR);}
	;

additive_expression
	: multiplicative_expression
	| additive_expression '+' multiplicative_expression {CreateSTMT(ADDITION);}
	| additive_expression '-' multiplicative_expression {CreateSTMT(SUBTRACTION);}
	;

shift_expression
	: additive_expression
	| shift_expression LEFT_OP additive_expression
	| shift_expression RIGHT_OP additive_expression
	;

relational_expression
	: shift_expression
	| relational_expression '<' shift_expression
	| relational_expression '>' shift_expression
	| relational_expression LE_OP shift_expression
	| relational_expression GE_OP shift_expression
	;

equality_expression
	: relational_expression
	| equality_expression EQ_OP relational_expression
	| equality_expression NE_OP relational_expression
	;

and_expression
	: equality_expression
	| and_expression '&' equality_expression
	;

exclusive_or_expression
	: and_expression
	| exclusive_or_expression '^' and_expression
	;

inclusive_or_expression
	: exclusive_or_expression
	| inclusive_or_expression '|' exclusive_or_expression
	;

logical_and_expression
	: inclusive_or_expression
	| logical_and_expression AND_OP inclusive_or_expression
	;

logical_or_expression
	: logical_and_expression
	| logical_or_expression OR_OP logical_and_expression
	;

conditional_expression
	: logical_or_expression
	| logical_or_expression '?' expression ':' conditional_expression
	;

assignment_expression
	: conditional_expression
	| unary_expression assignment_operator assignment_expression
	;

assignment_operator
	: '='
	| MUL_ASSIGN
	| DIV_ASSIGN
	| MOD_ASSIGN
	| ADD_ASSIGN
	| SUB_ASSIGN
	| LEFT_ASSIGN
	| RIGHT_ASSIGN
	| AND_ASSIGN
	| XOR_ASSIGN
	| OR_ASSIGN
	;

expression
	: assignment_expression
	| expression ',' assignment_expression
	;

constant_expression
	: conditional_expression
	;

declaration
	: declaration_specifiers ';'
	| declaration_specifiers init_declarator_list ';'
	;

declaration_specifiers
	: storage_class_specifier
	| storage_class_specifier declaration_specifiers
	| type_specifier
	| type_specifier declaration_specifiers
	| type_qualifier
	| type_qualifier declaration_specifiers
	| function_specifier
	| function_specifier declaration_specifiers
    | address_qualifier
    | address_qualifier declaration_specifiers
	;

init_declarator_list
	: init_declarator
	| init_declarator_list ',' init_declarator
	;

init_declarator
	: declarator
	| declarator '=' initializer
	;

storage_class_specifier
	: TYPEDEF
	| EXTERN
	| STATIC
	| AUTO
	| REGISTER
	;

type_specifier
	: VOID
	| CHAR
	| SHORT
    | INT
	| LONG
	| FLOAT
	| DOUBLE
	| SIGNED
	| UNSIGNED
	| BOOL
	| COMPLEX
	| IMAGINARY
	| struct_or_union_specifier
	| enum_specifier
	| TYPE_NAME
    | UCHAR
    | USHORT
    | ULONG
    | UINT
    | INT_V
    | UINT_V
    | SHORT_V
    | USHORT_V
    | CHAR_V
    | UCHAR_V
    | LONG_V
    | ULONG_V
    | FLOAT_V
    | DOUBLE_V
	;

struct_or_union_specifier
	: struct_or_union IDENTIFIER '{' struct_declaration_list '}'
	| struct_or_union '{' struct_declaration_list '}'
	| struct_or_union IDENTIFIER
	;

struct_or_union
	: STRUCT
	| UNION
	;

struct_declaration_list
	: struct_declaration
	| struct_declaration_list struct_declaration
	;

struct_declaration
	: specifier_qualifier_list struct_declarator_list ';'
	;

specifier_qualifier_list
	: type_specifier specifier_qualifier_list
	| type_specifier
	| type_qualifier specifier_qualifier_list
	| type_qualifier
	;

struct_declarator_list
	: struct_declarator
	| struct_declarator_list ',' struct_declarator
	;

struct_declarator
	: declarator
	| ':' constant_expression
	| declarator ':' constant_expression
	;

enum_specifier
	: ENUM '{' enumerator_list '}'
	| ENUM IDENTIFIER '{' enumerator_list '}'
	| ENUM '{' enumerator_list ',' '}'
	| ENUM IDENTIFIER '{' enumerator_list ',' '}'
	| ENUM IDENTIFIER
	;

enumerator_list
	: enumerator
	| enumerator_list ',' enumerator
	;

enumerator
	: IDENTIFIER
	| IDENTIFIER '=' constant_expression
	;

type_qualifier
	: CONST
	| RESTRICT
	| VOLATILE
	;

address_qualifier
    : ADDRESS_GLOBAL
    | ADDRESS_LOCAL
    | ADDRESS_CONSTANT
    | ADDRESS_PRIVATE
    ;

function_specifier
	: INLINE
    | KERNEL
	;

declarator
	: pointer direct_declarator {$$ = $2;}
	| direct_declarator {$$ = $1;}
	;


direct_declarator
	: IDENTIFIER {$$ = $1;}
	| '(' declarator ')' {$$ = $2;}
	| direct_declarator '[' type_qualifier_list assignment_expression ']' {$$ = $1;}
	| direct_declarator '[' type_qualifier_list ']' {$$ = $1;}
	| direct_declarator '[' assignment_expression ']' {$$ = $1;}
	| direct_declarator '[' STATIC type_qualifier_list assignment_expression ']' {$$ = $1;}
	| direct_declarator '[' type_qualifier_list STATIC assignment_expression ']' {$$ = $1;}
	| direct_declarator '[' type_qualifier_list '*' ']' {$$ = $1;}
	| direct_declarator '[' '*' ']' {$$ = $1;}
	| direct_declarator '[' ']' {$$ = $1;}
	| direct_declarator '(' parameter_type_list ')' {$$ = $1;}
	| direct_declarator '(' identifier_list ')' {$$ = $1;}
	| direct_declarator '(' ')' {$$ = $1;}
	;

pointer
	: '*'
	| '*' type_qualifier_list
	| '*' pointer
	| '*' type_qualifier_list pointer
	;

type_qualifier_list
	: type_qualifier
	| type_qualifier_list type_qualifier
	;


parameter_type_list
	: parameter_list
	| parameter_list ',' ELLIPSIS
	;

parameter_list
	: parameter_declaration
	| parameter_list ',' parameter_declaration
	;

parameter_declaration
	: declaration_specifiers declarator
	| declaration_specifiers abstract_declarator
	| declaration_specifiers
	;

identifier_list
	: IDENTIFIER
	| identifier_list ',' IDENTIFIER
	;

type_name
	: specifier_qualifier_list
	| specifier_qualifier_list abstract_declarator
	;

abstract_declarator
	: pointer
	| direct_abstract_declarator
	| pointer direct_abstract_declarator
	;

direct_abstract_declarator
	: '(' abstract_declarator ')'
	| '[' ']'
	| '[' assignment_expression ']'
	| direct_abstract_declarator '[' ']'
	| direct_abstract_declarator '[' assignment_expression ']'
	| '[' '*' ']'
	| direct_abstract_declarator '[' '*' ']'
	| '(' ')'
	| '(' parameter_type_list ')'
	| direct_abstract_declarator '(' ')'
	| direct_abstract_declarator '(' parameter_type_list ')'
	;

initializer
	: assignment_expression
	| '{' initializer_list '}'
	| '{' initializer_list ',' '}'
	;

initializer_list
	: initializer
	| designation initializer
	| initializer_list ',' initializer
	| initializer_list ',' designation initializer
	;

designation
	: designator_list '='
	;

designator_list
	: designator
	| designator_list designator
	;

designator
	: '[' constant_expression ']'
	| '.' IDENTIFIER
	;

statement
	: labeled_statement
	| compound_statement
	| expression_statement
	| selection_statement
	| iteration_statement
	| jump_statement
	;

labeled_statement
	: IDENTIFIER ':' statement
	| CASE constant_expression ':' statement
	| DEFAULT ':' statement
	;

compound_statement
	: '{' '}'
    | '{' block_item_list '}'
	;

block_item_list
	: block_item
	| block_item_list block_item
	;

block_item
	: declaration
	| statement
	;

expression_statement
	: ';'
	| expression ';'
	;

selection_statement
	: IF '(' expression ')' statement
	| IF '(' expression ')' statement ELSE statement
	| SWITCH '(' expression ')' statement
	;

iteration_statement
	: WHILE '(' expression ')' {CreateEmptySTMTGroup();} statement {CreateEmptySTMTGroup();}
	| DO {CreateEmptySTMTGroup();} statement WHILE '(' expression ')' ';' {CreateEmptySTMTGroup();}
	| FOR '(' expression_statement expression_statement ')' {CreateEmptySTMTGroup();} statement {CreateEmptySTMTGroup();}
	| FOR '(' expression_statement expression_statement expression ')' {CreateEmptySTMTGroup();} statement {CreateEmptySTMTGroup();}
	| FOR '(' declaration expression_statement ')' {CreateEmptySTMTGroup();} statement {CreateEmptySTMTGroup();}
	| FOR '(' declaration expression_statement expression ')' {CreateEmptySTMTGroup();} statement {CreateEmptySTMTGroup();}
	;

jump_statement
	: GOTO IDENTIFIER ';'
	| CONTINUE ';'
	| BREAK ';'
	| RETURN ';'
	| RETURN expression ';'
	;

translation_unit
	: external_declaration
	| translation_unit external_declaration
	;

external_declaration
	: function_definition
	| declaration
	;

function_definition
	: declaration_specifiers declarator declaration_list {CreateEmptySTMTGroup();} compound_statement
    {
        CreateFunction($2, curSTMTGroup_h, curSTMTGroup_t);
    }
    | declaration_specifiers declarator {CreateEmptySTMTGroup();} compound_statement
    {
        CreateFunction($2, curSTMTGroup_h, curSTMTGroup_t);
    }
	;

declaration_list
	: declaration
	| declaration_list declaration
	;


%%
#include <stdio.h>

extern char yytext[];
extern int column;

void yyerror(char const *s)
{
	fflush(stdout);
	printf("\n%*s\n%*s\n", column, "^", column, s);
}
