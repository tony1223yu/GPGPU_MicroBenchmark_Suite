%{
#include <stdio.h>
#include <stdlib.h>
#include "kernelParser.h"

void initial();
void MakeDependency(Operation* currOP, Operation* dependOP, DEP_TYPE type, unsigned long long int latency);
PROGRAM* CreateProgram(FUNCTION* func_head, FUNCTION* func_tail);
Operation* CreateOP(OP_KIND kind);
void GetStatementTypeName(Statement* stmt, char* output);
void DebugSTMTList(STMT_List* stmt_list, int order);
void DebugOPList(OP_List* list);
STMT_List* CreateSTMTList(Statement* newSTMT);
STMT_List* AddToSTMTList(STMT_List* prev, STMT_List* curr);
Statement* CreateSTMT(void* ptr, STMT_TYPE type);
OP_List* AddToOPList(OP_List* left, OP_List* right, Operation* newOP);
OP_List* AddPostStmtOP(OP_List* left, Operation* newOP);

void initial()
{
    prog = NULL;
}

void MakeDependency(Operation* currOP, Operation* dependOP, DEP_TYPE type, unsigned long long int latency)
{
    DEP* tmp;
    tmp = (DEP*)malloc(sizeof(DEP));
    tmp->op = dependOP;
    tmp->latency = latency;

    switch(type)
    {
        case ISSUE_DEP:
            currOP->issue_dep = tmp;
            break;
        case STRUCTURAL_DEP:
            currOP->structural_dep = tmp;
            break;
        case DATA_DEP:
            currOP->data_dep = tmp;
            break;
        default:
            fprintf(stderr, "Unknown type of dependency\n");
            break;
    }
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

/*
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
*/

Operation* CreateOP(OP_KIND kind)
{
    Operation* tmp;
    //fprintf(stderr, "[OpenCL Parser] Create STMT of type = %d\n", type);
    tmp = (Operation*)malloc(sizeof(Operation));
    tmp->kind = kind;
    tmp->issue_dep = NULL;
    tmp->structural_dep = NULL;
    tmp->data_dep = NULL;
    tmp->next = NULL;
    return tmp;
}

void GetStatementTypeName(Statement* stmt, char* output)
{
    switch(stmt -> type)
    {
        case EXPRESSION_STMT:
            sprintf(output, "%s", "EXPRESSION");
            break;
        case SELECTION_STMT:
            sprintf(output, "%s", "SELECTION");
            break;
        case ITERATION_STMT:
            sprintf(output, "%s", "ITERATION");
            break;
        case IF_STMT:
            sprintf(output, "%s", "IF");
            break;
        case ELSE_STMT:
            sprintf(output, "%s", "ELSE");
            break;
    }
}

void GetOperationTypeName(Operation* op, char* output)
{
    switch(op -> kind)
    {
        case ADDITION_OP:
            sprintf(output, "%s", "Add");
            break;
        case SUBTRACTION_OP:
            sprintf(output, "%s", "Sub");
            break;
        case MULTIPLICATION_OP:
            sprintf(output, "%s", "Mul");
            break;
        case DIVISION_OP:
            sprintf(output, "%s", "Div");
            break;
        case MODULAR_OP:
            sprintf(output, "%s", "Modular");
            break;
        case MEMORY_OP:
            sprintf(output, "%s", "Memory");
            break;
    }
}

void DebugSTMTList(STMT_List* stmt_list, int order)
{
    char opType[30];
    char stmtType[30];
    int i;
    if (stmt_list != NULL && stmt_list->stmt_head != NULL)
    {
        Statement* iterStmt = stmt_list->stmt_head;
        Operation* iterOP;
        while (iterStmt != NULL)
        {
            for (i = 0 ; i < order ; i ++)
                printf("\t");

            if (iterStmt->type == EXPRESSION_STMT)
            {
                //GetStatementTypeName(iterStmt, stmtType);
                //printf("[ STMT TYPE %s ]\n", stmtType);
                iterOP = iterStmt->op_list->op_head;
                while (iterOP != NULL)
                {
                    GetOperationTypeName(iterOP, opType);
                    printf("%s -> ", opType);
                    iterOP = iterOP->next;
                }
                printf("NULL\n");
            }
            else                 // recursive call for ITERATION_STMT, SELECTION_STMT, IF_STMT and ELSE_STMT
            {
                GetStatementTypeName(iterStmt, stmtType);
                printf("[ STMT TYPE %s ]\n", stmtType);
                DebugSTMTList(iterStmt->stmt_list, order + 1);
            }

            iterStmt = iterStmt->next;
        }
    }
    else
    {
        printf("STMT is NULL\n");
    }
}

void DebugOPList(OP_List* list)
{
    if (list != NULL)
    {
        Operation* tmp = list->op_head;
        while(tmp)
        {
            printf("%d -> ", tmp->type);
            tmp = tmp->next;
        }
        printf("\n");
    }
    else
    {
        printf("List is NULL\n");
    }
}

STMT_List* CreateSTMTList(Statement* newSTMT)
{
    if (newSTMT == NULL)
        return NULL;

    STMT_List* tmp;
    tmp = (STMT_List*)malloc(sizeof(STMT_List));

    tmp->stmt_head = newSTMT;
    tmp->stmt_tail = newSTMT;
    return tmp;
}


STMT_List* AddToSTMTList(STMT_List* prev, STMT_List* curr)
{
    if (curr == NULL) return prev;
    if (prev == NULL) return curr;

    if (prev->stmt_tail->type == EXPRESSION_STMT && curr->stmt_head->type == EXPRESSION_STMT)
    {
        prev->stmt_tail->op_list->op_tail->next = curr->stmt_head->op_list->op_head;
        MakeDependency(curr->stmt_head->op_list->op_head, prev->stmt_tail->op_list->op_tail->next, ISSUE_DEP, 1);
        prev->stmt_tail->op_list->op_tail = curr->stmt_head->op_list->op_tail;
        if (curr->stmt_tail == curr->stmt_head)
            curr->stmt_tail = curr->stmt_tail->next;
        curr->stmt_head = curr->stmt_head->next;
        prev->stmt_tail->next = curr->stmt_head;
        if (curr->stmt_tail != NULL)
            prev->stmt_tail = curr->stmt_tail;
        
        free(curr);
        return prev;
    }
    else
    {
        prev->stmt_tail->next = curr->stmt_head;
        prev->stmt_tail = curr->stmt_tail;
        free(curr);
        return prev;
    }
}

Statement* CreateSTMT(void* ptr, STMT_TYPE type)
{
    if (ptr == NULL)
        return NULL;

    Statement* tmp;
    tmp = (Statement*)malloc(sizeof(Statement));
    tmp->type = type;
    tmp->opID = 0;
    tmp->stmt_list = NULL;
    tmp->op_list = NULL;

    if (type == EXPRESSION_STMT)
    {
        OP_List* list = (OP_List*)(ptr);
        list = AddToOPList(list, list->post_stmt_op_list, NULL);
        tmp->op_list = list;
    }
    else                        // ITERATION_STMT, SELECTION_STMT, IF_STMT and ELSE_STMT
    {
        tmp->stmt_list = (STMT_List*)(ptr);
    }

    return tmp;
}

OP_List* AddToOPList(OP_List* left, OP_List* right, Operation* newOP)
{
    if ((left == NULL) && (right == NULL))
    {
        OP_List* tmp = NULL;
        if (newOP != NULL)
        {
            tmp = (OP_List*)malloc(sizeof(OP_List));
            tmp->op_head = newOP;
            tmp->op_tail = newOP;
            tmp->post_stmt_op_list = NULL;
        }
        return tmp;
    }
    else if (right == NULL)
    {
        if (newOP != NULL)
        {
            if (left->op_head != NULL)
            {
                MakeDependency(newOP, left->op_tail, ISSUE_DEP, 1);        
                left->op_tail->next = newOP;
                left->op_tail = newOP;
            }
            else
            {
                left->op_head = newOP;
                left->op_tail = newOP;
            }
        }
        return left;
    }
    else if (left == NULL)
    {
        if (newOP != NULL)
        {
            if (right->op_head != NULL)
            {
                MakeDependency(newOP, right->op_tail, ISSUE_DEP, 1);        
                right->op_tail->next = newOP;
                right->op_tail = newOP;
            }
            else
            {
                right->op_head = newOP;
                right->op_tail = newOP;
            }
        }
        return right;
    }
    else // merge two list
    {
        if ((left->op_head != NULL) && (right->op_head != NULL))
        {
            MakeDependency(right->op_head, left->op_tail, ISSUE_DEP, 1);
            left->op_tail->next = right->op_head;
            if (newOP != NULL)
            {
                MakeDependency(newOP, right->op_tail, ISSUE_DEP, 1);
                right->op_tail->next = newOP;
                left->op_tail = newOP;
            }
            else
            {
                left->op_tail = right->op_tail;
            }
            left->post_stmt_op_list = AddToOPList(left->post_stmt_op_list, right->post_stmt_op_list, NULL);
            free (right);
            return left;
        }
        else if (left->op_head == NULL)
        {
            right->post_stmt_op_list = AddToOPList(left->post_stmt_op_list, right->post_stmt_op_list, NULL);
            if (newOP != NULL)
            {
                MakeDependency(newOP, right->op_tail, ISSUE_DEP, 1);
                right->op_tail->next = newOP;
                right->op_tail = newOP;
            }
            return right;
        }
        else if (right->op_head == NULL)
        {
            left->post_stmt_op_list = AddToOPList(left->post_stmt_op_list, right->post_stmt_op_list, NULL);
            if (newOP != NULL)
            {
                MakeDependency(newOP, left->op_tail, ISSUE_DEP, 1);
                left->op_tail->next = newOP;
                left->op_tail = newOP;
            }
            return left;
        }
        else
        {
            left->post_stmt_op_list = AddToOPList(left->post_stmt_op_list, right->post_stmt_op_list, NULL);
            if (newOP != NULL)
            {
                left->op_head = newOP;
                left->op_tail = newOP;
            }
            return left;
        }
    }
}

OP_List* AddPostStmtOP(OP_List* left, Operation* newOP)
{
    if (left == NULL)
    {
        OP_List* tmp;
        tmp = (OP_List*)malloc(sizeof(OP_List));
        tmp->op_head = NULL;
        tmp->op_tail = NULL;
        tmp->post_stmt_op_list = AddToOPList(tmp->post_stmt_op_list, NULL, newOP);
        return tmp;
    }
    else
    {
        left->post_stmt_op_list = AddToOPList(left->post_stmt_op_list, NULL, newOP);
        return left;
    }
}

%}

%union
{
    void *ptr;
}

%token KERNEL GLOBAL_ID_FUNC GLOBAL_SIZE_FUNC LOCAL_ID_FUNC LOCAL_SIZE_FUNC ADDRESS_GLOBAL ADDRESS_LOCAL ADDRESS_PRIVATE ADDRESS_CONSTANT
%token UCHAR USHORT UINT ULONG INT_V UINT_V CHAR_V UCHAR_V SHORT_V USHORT_V LONG_V ULONG_V FLOAT_V DOUBLE_V

%token <ptr> IDENTIFIER
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

/* TYPE: (char*) */
%type <ptr> declarator direct_declarator

/* TYPE: (OP_List*) */
%type <ptr> primary_expression postfix_expression unary_expression cast_expression multiplicative_expression additive_expression shift_expression relational_expression equality_expression and_expression exclusive_or_expression inclusive_or_expression logical_and_expression logical_or_expression unary_operator conditional_expression assignment_expression assignment_operator expression expression_statement declaration init_declarator_list init_declarator initializer initializer_list

/* TYPE: (STMT_List*) */
%type <ptr> selection_statement iteration_statement statement block_item block_item_list compound_statement

%start program_unit
%%

program_unit
    : translation_unit
    ;

primary_expression
	: IDENTIFIER {$$ = NULL;}
	| CONSTANT {$$ = NULL;}
	| STRING_LITERAL {$$ = NULL;}
	| '(' expression ')' {$$ = $2;}
    | GLOBAL_ID_FUNC {$$ = NULL;}
    | GLOBAL_SIZE_FUNC {$$ = NULL;}
    | LOCAL_ID_FUNC {$$ = NULL;}
    | LOCAL_SIZE_FUNC {$$ = NULL;}
	;

/* function call here */
postfix_expression
	: primary_expression {$$ = $1;}
	| postfix_expression '[' expression ']' {$$ = AddToOPList($1, $3, CreateOP(MEMORY_OP));}
	| postfix_expression '(' ')' {$$ = $1;} /* TODO: function call */
	| postfix_expression '(' argument_expression_list ')' {$$ = $1;} /* TODO: function call */
	| postfix_expression '.' IDENTIFIER {$$ = $1;}
	| postfix_expression PTR_OP IDENTIFIER {$$ = $1;}
	| postfix_expression INC_OP {$$ = AddPostStmtOP($1, CreateOP(ADDITION_OP));}
	| postfix_expression DEC_OP {$$ = AddPostStmtOP($1, CreateOP(SUBTRACTION_OP));}
	| '(' type_name ')' '{' initializer_list '}' {$$ = NULL;}
	| '(' type_name ')' '{' initializer_list ',' '}' {$$ = NULL;}
	;

argument_expression_list
	: assignment_expression
	| argument_expression_list ',' assignment_expression
	;

unary_expression
	: postfix_expression {$$ = $1;}
	| INC_OP unary_expression {$$ = AddToOPList(NULL, $2, CreateOP(ADDITION_OP));}
	| DEC_OP unary_expression {$$ = AddToOPList(NULL, $2, CreateOP(SUBTRACTION_OP));}
	| unary_operator cast_expression {$$ = AddToOPList(NULL, $2, $1);}
	| SIZEOF unary_expression {$$ = $2;}
	| SIZEOF '(' type_name ')' {$$ = NULL;}
	;

unary_operator
	: '&' {$$ = NULL;}
	| '*' {$$ = CreateOP(MEMORY_OP);}
	| '+' {$$ = NULL;}
	| '-' {$$ = NULL;}
	| '~' {$$ = NULL;}
	| '!' {$$ = NULL;}
	;

cast_expression
	: unary_expression {$$ = $1;}
	| '(' type_name ')' cast_expression {$$ = $4;}
	;

multiplicative_expression
	: cast_expression {$$ = $1;}
	| multiplicative_expression '*' cast_expression {$$ = AddToOPList($1, $3, CreateOP(MULTIPLICATION_OP));}
	| multiplicative_expression '/' cast_expression {$$ = AddToOPList($1, $3, CreateOP(DIVISION_OP));}
	| multiplicative_expression '%' cast_expression {$$ = AddToOPList($1, $3, CreateOP(MODULAR_OP));}
	;

additive_expression
	: multiplicative_expression {$$ = $1;}
	| additive_expression '+' multiplicative_expression {$$ = AddToOPList($1, $3, CreateOP(ADDITION_OP));}
	| additive_expression '-' multiplicative_expression {$$ = AddToOPList($1, $3, CreateOP(SUBTRACTION_OP));}
	;

shift_expression
	: additive_expression {$$ = $1;}
	| shift_expression LEFT_OP additive_expression {$$ = AddToOPList($1, $3, NULL);}
	| shift_expression RIGHT_OP additive_expression {$$ = AddToOPList($1, $3, NULL);}
	;

relational_expression
	: shift_expression {$$ = $1;}
	| relational_expression '<' shift_expression {$$ = AddToOPList($1, $3, NULL);}
	| relational_expression '>' shift_expression {$$ = AddToOPList($1, $3, NULL);}
	| relational_expression LE_OP shift_expression {$$ = AddToOPList($1, $3, NULL);}
	| relational_expression GE_OP shift_expression {$$ = AddToOPList($1, $3, NULL);}
	;

equality_expression
	: relational_expression {$$ = $1;}
	| equality_expression EQ_OP relational_expression {$$ = AddToOPList($1, $3, NULL);}
	| equality_expression NE_OP relational_expression {$$ = AddToOPList($1, $3, NULL);}
	;

and_expression
	: equality_expression {$$ = $1;}
	| and_expression '&' equality_expression {$$ = AddToOPList($1, $3, NULL);}
	;

exclusive_or_expression
	: and_expression {$$ = $1;}
	| exclusive_or_expression '^' and_expression {$$ = AddToOPList($1, $3, NULL);}
	;

inclusive_or_expression
	: exclusive_or_expression {$$ = $1;}
	| inclusive_or_expression '|' exclusive_or_expression {$$ = AddToOPList($1, $3, NULL);}
	;

logical_and_expression
	: inclusive_or_expression {$$ = $1;}
	| logical_and_expression AND_OP inclusive_or_expression {$$ = AddToOPList($1, $3, NULL);}
	;

logical_or_expression
	: logical_and_expression {$$ = $1;}
	| logical_or_expression OR_OP logical_and_expression {$$ = AddToOPList($1, $3, NULL);}
	;

conditional_expression
	: logical_or_expression {$$ = $1;}
	| logical_or_expression '?' expression ':' conditional_expression {$$ = $1;} /* TODO: check the actual execution flow */
	;

assignment_expression
	: conditional_expression {$$ = $1;}
	| unary_expression assignment_operator assignment_expression {$$ = AddToOPList($3, $1, $2);}
	;

assignment_operator
	: '=' {$$ = NULL;}
	| MUL_ASSIGN {$$ = CreateOP(MULTIPLICATION_OP);}
	| DIV_ASSIGN {$$ = CreateOP(DIVISION_OP);}
	| MOD_ASSIGN {$$ = CreateOP(MODULAR_OP);}
	| ADD_ASSIGN {$$ = CreateOP(ADDITION_OP);}
	| SUB_ASSIGN {$$ = CreateOP(SUBTRACTION_OP);}
	| LEFT_ASSIGN {$$ = NULL;}
	| RIGHT_ASSIGN {$$ = NULL;}
	| AND_ASSIGN {$$ = NULL;}
	| XOR_ASSIGN {$$ = NULL;}
	| OR_ASSIGN {$$ = NULL;}
	;

expression
	: assignment_expression {$$ = $1;}
	| expression ',' assignment_expression {$$ = AddToOPList($1, $3, NULL);}
	;

constant_expression
	: conditional_expression
	;

declaration
	: declaration_specifiers ';' {$$ = NULL;}
	| declaration_specifiers init_declarator_list ';' {$$ = $2;}
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
	: init_declarator {$$ = $1;}
	| init_declarator_list ',' init_declarator {$$ = AddToOPList($1, $3, NULL);}
	;

init_declarator
	: declarator {$$ = NULL;}
	| declarator '=' initializer {$$ = $3;}
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
	: assignment_expression {$$ = $1;}
	| '{' initializer_list '}' {$$ = $2;}
	| '{' initializer_list ',' '}' {$$ = $2;}
	;

initializer_list
	: initializer {$$ = $1;}
	| designation initializer {$$ = $2;}
	| initializer_list ',' initializer {$$ = AddToOPList($1, $3, NULL);}
	| initializer_list ',' designation initializer {$$ = AddToOPList($1, $4, NULL);}
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
	: labeled_statement {$$ = NULL;}
	| compound_statement {$$ = $1;}  // Should not be a statement, return STMT_List*
	| expression_statement {$$ = CreateSTMTList(CreateSTMT($1, EXPRESSION_STMT));}
	| selection_statement {$$ = $1;}
	| iteration_statement {$$ = $1;} // Statement contains Stmt_List
	| jump_statement {$$ = NULL;}
	;

labeled_statement
	: IDENTIFIER ':' statement
	| CASE constant_expression ':' statement
	| DEFAULT ':' statement
	;

compound_statement
	: '{' '}' {$$ = NULL;}
    | '{' block_item_list '}' {$$ = $2;}
	;

block_item_list
	: block_item 
    {
        $$ = $1;
    }
	| block_item_list block_item 
    {
        $$ = AddToSTMTList($1, $2);
    }
	;

block_item
    : declaration {$$ = CreateSTMTList(CreateSTMT($1, EXPRESSION_STMT));} /* TODO: expressions in declaration */
	| statement {$$ = $1;}
	;

expression_statement
	: ';' {$$ = NULL;}
	| expression ';' {$$ = $1;}
	;

selection_statement
	: IF '(' expression ')' statement
    {
        STMT_List* tmp = CreateSTMTList(CreateSTMT($5, IF_STMT));
        tmp = CreateSTMTList(CreateSTMT(tmp, SELECTION_STMT));
        STMT_List* exp = CreateSTMTList(CreateSTMT($3, EXPRESSION_STMT));
        $$ = AddToSTMTList(exp, tmp);
    }
	| IF '(' expression ')' statement ELSE statement 
    {
        STMT_List* tmp = CreateSTMTList(CreateSTMT($5, IF_STMT));
        tmp = AddToSTMTList(tmp, CreateSTMTList((CreateSTMT($7, ELSE_STMT))));
        tmp = CreateSTMTList(CreateSTMT(tmp, SELECTION_STMT));
        STMT_List* exp = CreateSTMTList(CreateSTMT($3, EXPRESSION_STMT));
        $$ = AddToSTMTList(exp, tmp);
    }
	| SWITCH '(' expression ')' statement {$$ = $5;}
	;

iteration_statement /* TODO: Add the expression of loop condition and steps into the STMTList */
	: WHILE '(' expression ')' statement {$$ = CreateSTMTList(CreateSTMT($5, ITERATION_STMT));}
	| DO statement WHILE '(' expression ')' ';' {$$ = CreateSTMTList(CreateSTMT($5, ITERATION_STMT));}
	| FOR '(' expression_statement expression_statement ')' statement 
    {
        STMT_List* tmp = $6;
        tmp = AddToSTMTList(tmp, CreateSTMTList(CreateSTMT($4, EXPRESSION_STMT)));
        tmp = CreateSTMTList(CreateSTMT(tmp, ITERATION_STMT));
        STMT_List* exp = CreateSTMTList(CreateSTMT($3, EXPRESSION_STMT));
        $$ = AddToSTMTList(exp, tmp);

    } 
	| FOR '(' expression_statement expression_statement expression ')' statement
    {
        STMT_List* tmp = $7;
        tmp = AddToSTMTList(tmp, CreateSTMTList(CreateSTMT($5, EXPRESSION_STMT)));
        tmp = AddToSTMTList(tmp, CreateSTMTList(CreateSTMT($4, EXPRESSION_STMT)));
        tmp = CreateSTMTList(CreateSTMT(tmp, ITERATION_STMT));
        STMT_List* exp = CreateSTMTList(CreateSTMT($3, EXPRESSION_STMT));
        $$ = AddToSTMTList(exp, tmp);

    }
	| FOR '(' declaration expression_statement ')' statement 
    {
        STMT_List* tmp = $6;
        tmp = AddToSTMTList(tmp, CreateSTMTList(CreateSTMT($4, EXPRESSION_STMT)));
        tmp = CreateSTMTList(CreateSTMT(tmp, ITERATION_STMT)); 
        STMT_List* exp = CreateSTMTList(CreateSTMT($3, EXPRESSION_STMT));
        $$ = AddToSTMTList(exp, tmp);
    }
	| FOR '(' declaration expression_statement expression ')' statement
    {
        STMT_List* tmp = $7;
        tmp = AddToSTMTList(tmp, CreateSTMTList(CreateSTMT($5, EXPRESSION_STMT)));
        tmp = AddToSTMTList(tmp, CreateSTMTList(CreateSTMT($4, EXPRESSION_STMT)));
        tmp = CreateSTMTList(CreateSTMT(tmp, ITERATION_STMT));
        STMT_List* exp = CreateSTMTList(CreateSTMT($3, EXPRESSION_STMT));
        $$ = AddToSTMTList(exp, tmp);
    } 
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
	: declaration_specifiers declarator declaration_list compound_statement
    {
        printf("[FUNCTION NAME \'%s\' START]\n", (char*)($2));
        DebugSTMTList($4, 1);
        printf("[FUNCTION NAME \'%s\' END]\n\n", (char*)($2));
    }
    | declaration_specifiers declarator compound_statement
    {
        printf("[FUNCTION NAME \'%s\' START]\n", (char*)($2));
        DebugSTMTList($3, 1);
        printf("[FUNCTION NAME \'%s\' END]\n\n", (char*)($2));
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
