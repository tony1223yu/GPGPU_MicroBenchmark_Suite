%{
#include <stdio.h>
#include <stdlib.h>
#include "kernelParser.h"
#include "symbolTable.h"

void initial();
void MakeDependency(Operation*, Operation*, DEP_TYPE, unsigned long long int);
PROGRAM* CreateProgram(FUNCTION*, FUNCTION*);
void ReleaseOP(Operation*);
Operation* CreateOP(OP_KIND);
void GetStatementTypeName(Statement*, char*);
void GetOperationDescriptor(Operation*, char*, char*);
void ReleaseSTMTList(STMT_List*);
void DebugSTMTList(STMT_List*, int);
void DebugOPList(OP_List*);
STMT_List* CreateSTMTList(Statement*);
STMT_List* AddToSTMTList(STMT_List*, STMT_List*);
void ReleaseSTMT(Statement*);
Statement* CreateSTMT(void*, STMT_TYPE);
void ReleaseOPList(OP_List*);
OP_List* AddToOPList(OP_List*, OP_List*, Operation*);
OP_List* CreateEmptyOPList(OP_List*, OP_TYPE);
Decl_Node* AddDeclNode(Decl_Node*, Decl_Node*);
Decl_Node* MakeDeclNode(ID_List*, OP_List*);
Identifier* CreateIdentifier(char*);
ID_List* CreateIDList(Identifier*);
ID_List* AddToIDList(ID_List*, ID_List*);
OP_TYPE MixType(OP_TYPE, OP_TYPE);

extern PROGRAM* prog;
extern SymbolTable* symTable;

OP_TYPE MixType(OP_TYPE left, OP_TYPE right)
{
    return ((left > right) ? left : right);
}

void initial()
{
    prog = NULL;
    CreateSymbolTable();
    CreateSymbolTableLevel();
}

void release()
{
    ReleaseSymbolTableLevel();
    ReleaseSymbolTable();
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
    tmp->type = NONE_TYPE;
    tmp->issue_dep = NULL;
    tmp->structural_dep = NULL;
    tmp->data_dep = NULL;
    tmp->next = NULL;
    return tmp;
}

void ReleaseOP(Operation* op)
{
    if (!op) return;
    if (op->issue_dep)
        free (op->issue_dep);
    if (op->structural_dep)
        free (op->structural_dep);
    if (op->data_dep)
        free (op->data_dep);

    free (op);
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

void GetOperationDescriptor(Operation* op, char* outputKind, char* outputType)
{
    switch(op -> kind)
    {
        case ADDITION_OP:
            sprintf(outputKind, "add");
            break;
        case SUBTRACTION_OP:
            sprintf(outputKind, "sub");
            break;
        case MULTIPLICATION_OP:
            sprintf(outputKind, "mul");
            break;
        case DIVISION_OP:
            sprintf(outputKind, "div");
            break;
        case MODULAR_OP:
            sprintf(outputKind, "modular");
            break;
        case MEMORY_OP:
            sprintf(outputKind, "memory");
            break;
        case NONE_OP:
            sprintf(outputKind, "none");
            break;
        default:
            fprintf(stderr, "Unrecognized operation kind\n");
            break;
    }

    switch(op->type)
    {
        case NONE_TYPE: sprintf(outputType, "none"); break;
        case BOOL_TYPE: sprintf(outputType, "bool"); break;
        case HALF_TYPE: sprintf(outputType, "half"); break;
        case VOID_TYPE: sprintf(outputType, "void"); break;
        case CHAR_TYPE: sprintf(outputType, "char"); break;
        case CHAR2_TYPE: sprintf(outputType, "char2"); break;
        case CHAR4_TYPE: sprintf(outputType, "char4"); break;
        case CHAR8_TYPE: sprintf(outputType, "char8"); break;
        case CHAR16_TYPE: sprintf(outputType, "char16"); break;
        case UCHAR_TYPE: sprintf(outputType, "uchar"); break;
        case UCHAR2_TYPE: sprintf(outputType, "uchar2"); break;
        case UCHAR4_TYPE: sprintf(outputType, "uchar4"); break;
        case UCHAR8_TYPE: sprintf(outputType, "uchar8"); break;
        case UCHAR16_TYPE: sprintf(outputType, "uchar16"); break;
        case SHORT_TYPE: sprintf(outputType, "short"); break;
        case SHORT2_TYPE: sprintf(outputType, "short2"); break;
        case SHORT4_TYPE: sprintf(outputType, "short4"); break;
        case SHORT8_TYPE: sprintf(outputType, "short8"); break;
        case SHORT16_TYPE: sprintf(outputType, "short16"); break;
        case USHORT_TYPE: sprintf(outputType, "ushort"); break;
        case USHORT2_TYPE: sprintf(outputType, "ushort2"); break;
        case USHORT4_TYPE: sprintf(outputType, "ushort4"); break;
        case USHORT8_TYPE: sprintf(outputType, "ushort8"); break;
        case USHORT16_TYPE: sprintf(outputType, "ushort16"); break;
        case INT_TYPE: sprintf(outputType, "int"); break;
        case INT2_TYPE: sprintf(outputType, "int2"); break;
        case INT4_TYPE: sprintf(outputType, "int4"); break;
        case INT8_TYPE: sprintf(outputType, "int8"); break;
        case INT16_TYPE: sprintf(outputType, "int16"); break;
        case UINT_TYPE: sprintf(outputType, "uint"); break;
        case UINT2_TYPE: sprintf(outputType, "uint2"); break;
        case UINT4_TYPE: sprintf(outputType, "uint4"); break;
        case UINT8_TYPE: sprintf(outputType, "uint8"); break;
        case UINT16_TYPE: sprintf(outputType, "uint16"); break;
        case LONG_TYPE: sprintf(outputType, "long"); break;
        case LONG2_TYPE: sprintf(outputType, "long2"); break;
        case LONG4_TYPE: sprintf(outputType, "long4"); break;
        case LONG8_TYPE: sprintf(outputType, "long8"); break;
        case LONG16_TYPE: sprintf(outputType, "long16"); break;
        case ULONG_TYPE: sprintf(outputType, "ulong"); break;
        case ULONG2_TYPE: sprintf(outputType, "ulong2"); break;
        case ULONG4_TYPE: sprintf(outputType, "ulong4"); break;
        case ULONG8_TYPE: sprintf(outputType, "ulong8"); break;
        case ULONG16_TYPE: sprintf(outputType, "ulong16"); break;
        case FLOAT_TYPE: sprintf(outputType, "float"); break;
        case FLOAT2_TYPE: sprintf(outputType, "float2"); break;
        case FLOAT4_TYPE: sprintf(outputType, "float4"); break;
        case FLOAT8_TYPE: sprintf(outputType, "float8"); break;
        case FLOAT16_TYPE: sprintf(outputType, "float16"); break;
        case DOUBLE_TYPE: sprintf(outputType, "double"); break;
        case DOUBLE2_TYPE: sprintf(outputType, "double2"); break;
        case DOUBLE4_TYPE: sprintf(outputType, "double4"); break;
        case DOUBLE8_TYPE: sprintf(outputType, "double8"); break;
        case DOUBLE16_TYPE: sprintf(outputType, "double16"); break;
        default: fprintf(stderr, "Unrecognized operation type\n");
    }
}

void DebugSTMTList(STMT_List* stmt_list, int order)
{
    char opKind[30];
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
                iterOP = iterStmt->op_list->op_head;
                while (iterOP != NULL)
                {
                    GetOperationDescriptor(iterOP, opKind, opType);
                    printf("%s_%s -> ", opType, opKind);
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
        for (i = 0 ; i < order ; i ++)
            printf("\t");
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

Identifier* CreateIdentifier(char* name)
{
    Identifier* tmp = (Identifier*) malloc(sizeof(Identifier));
    tmp->name = name;
    tmp->next = NULL;
    return tmp;
}

ID_List* CreateIDList(Identifier* ID)
{
    ID_List* tmp = (ID_List*)malloc(sizeof(ID_List));
    tmp->id_head = ID;
    tmp->id_tail = ID;
    return tmp;
}

ID_List* AddToIDList(ID_List* left, ID_List* right)
{
    if ((!left) && (!right)) return NULL;

    if (!left)
        return right;
    else if (!right)
        return left;
    else
    {
        left->id_tail->next = right->id_head;
        left->id_tail = right->id_tail;

        free (right);
        return left;
    }
}

Decl_Node* AddDeclNode(Decl_Node* left, Decl_Node* right)
{
    if ((!left) && (!right)) return NULL;
    
    if (!left)
        return right;
    else if (!right)
        return left;
    else
    {
        left->IDs = AddToIDList(left->IDs, right->IDs);
        left->OPs = AddToOPList(left->OPs, right->OPs, NULL);

        free (right);
        return left;
    }
}

Decl_Node* MakeDeclNode(ID_List* id_list, OP_List* op_list)
{
    Decl_Node* tmp = (Decl_Node*) malloc(sizeof(Decl_Node));
    tmp->IDs = id_list;
    tmp->OPs = op_list;
    return tmp;
}

void ReleaseSTMTList(STMT_List* stmt_list)
{
    Statement* curr;
    Statement* next;
    if (!stmt_list) return;
    if (!stmt_list->stmt_head) return;
    
    curr = stmt_list->stmt_head;
    next = stmt_list->stmt_head->next;
    while (curr)
    {
        ReleaseSTMT(curr);
        curr = next;
        if (next)
            next = next->next;
    }
}

STMT_List* CreateSTMTList(Statement* newSTMT)
{
    if (!newSTMT)
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

void ReleaseSTMT(Statement* stmt)
{
    if (!stmt) return;

    if (stmt->stmt_list)
        ReleaseSTMTList(stmt->stmt_list);
    if (stmt->op_list)
        ReleaseOPList(stmt->op_list);

    free (stmt);
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
    tmp->next = NULL;

    if (type == EXPRESSION_STMT)
    {
        OP_List* list = (OP_List*)(ptr);
        list = AddToOPList(list, list->post_stmt_op_list, NULL);
        list->post_stmt_op_list = NULL;
        tmp->op_list = list;
    }
    else                        // ITERATION_STMT, SELECTION_STMT, IF_STMT and ELSE_STMT
    {
        tmp->stmt_list = (STMT_List*)(ptr);
    }
    return tmp;
}

void ReleaseOPList(OP_List* op_list)
{
    Operation* curr;
    Operation* next;
    if (!op_list) return; 
    if (!op_list->op_head) return;

    curr = op_list->op_head;
    next = op_list->op_head->next;

    while (curr)
    {
        ReleaseOP(curr);
        curr = next;
        if (next)
            next = next->next;
    }
}

OP_List* AddToOPList(OP_List* left, OP_List* right, Operation* newOP)
{
    OP_TYPE mix_type;
    OP_List* mix_post_stmt_op_list;

    // type
    if ((left == NULL) && (right == NULL))
        mix_type = NONE_TYPE;
    else if (left == NULL)
        mix_type = right->curr_type;
    else if (right == NULL)
        mix_type = left->curr_type;
    else
        mix_type = MixType(left->curr_type, right->curr_type);

    if (newOP)
        newOP->type = mix_type;

    // post_stmt_op_list
    if ((left == NULL) && (right == NULL))
        mix_post_stmt_op_list = NULL;
    else if (left == NULL)
        mix_post_stmt_op_list = right->post_stmt_op_list;
    else if (right == NULL)
        mix_post_stmt_op_list = left->post_stmt_op_list;
    else
        mix_post_stmt_op_list = AddToOPList(left->post_stmt_op_list, right->post_stmt_op_list, NULL);

    // contain_ops
    if ((left == NULL) && (right == NULL))
    {
        OP_List* tmp = NULL;
        if ((newOP != NULL) || (mix_type != NONE_TYPE) || (mix_post_stmt_op_list != NULL))
        {
            tmp = (OP_List*)malloc(sizeof(OP_List));
            tmp->op_head = newOP;
            tmp->op_tail = newOP;
            tmp->curr_type = mix_type;
            tmp->post_stmt_op_list = mix_post_stmt_op_list;
        }
        return tmp;
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
        right->curr_type = mix_type;
        right->post_stmt_op_list = mix_post_stmt_op_list;
        return right;
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
        left->curr_type = mix_type;
        left->post_stmt_op_list = mix_post_stmt_op_list;
        return left;
    } 
    else
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
            left->curr_type = mix_type;
            left->post_stmt_op_list = mix_post_stmt_op_list;
            free (right);
            return left;
        }
        else if (right->op_head != NULL) // only left contain operation, right contain post_stmt_op_list
        {
            if (newOP != NULL)
            {
                MakeDependency(newOP, right->op_tail, ISSUE_DEP, 1);
                right->op_tail->next = newOP;
                right->op_tail = newOP;
            }
            right->curr_type = mix_type;
            right->post_stmt_op_list = mix_post_stmt_op_list;
            free (left);
            return right;
        }
        else if (left->op_head != NULL) // only right contain operation, left contain post_stmt_op_list
        {
            if (newOP != NULL)
            {
                MakeDependency(newOP, left->op_tail, ISSUE_DEP, 1);
                left->op_tail->next = newOP;
                left->op_tail = newOP;
            }
            left->curr_type = mix_type;
            left->post_stmt_op_list = mix_post_stmt_op_list;
            free (right);
            return left;
        }
        else // both contain only post_stmt_op_list
        {
            if (newOP != NULL)
            {
                left->op_head = newOP;
                left->op_tail = newOP;
            }
            left->curr_type = mix_type;
            left->post_stmt_op_list = mix_post_stmt_op_list;
            free (right);
            return left;
        }

    }
}

OP_List* CreateEmptyOPList(OP_List* post_stmt_op_list, OP_TYPE type)
{
    OP_List* tmp;
    tmp = (OP_List*)malloc(sizeof(OP_List));
    tmp->op_head = NULL;
    tmp->op_tail = NULL;
    tmp->curr_type = type;
    tmp->post_stmt_op_list = post_stmt_op_list;
    return tmp;
}

%}

%union
{
    OP_TYPE type;
    void *ptr;
}

%token KERNEL GLOBAL_ID_FUNC GLOBAL_SIZE_FUNC LOCAL_ID_FUNC LOCAL_SIZE_FUNC ADDRESS_GLOBAL ADDRESS_LOCAL ADDRESS_PRIVATE ADDRESS_CONSTANT

%token <type> OPENCL_TYPE TYPE_NAME
%token <type> CONSTANT
%token <ptr> IDENTIFIER
%token STRING_LITERAL SIZEOF
%token PTR_OP INC_OP DEC_OP LEFT_OP RIGHT_OP LE_OP GE_OP EQ_OP NE_OP
%token AND_OP OR_OP MUL_ASSIGN DIV_ASSIGN MOD_ASSIGN ADD_ASSIGN
%token SUB_ASSIGN LEFT_ASSIGN RIGHT_ASSIGN AND_ASSIGN
%token XOR_ASSIGN OR_ASSIGN

%token TYPEDEF EXTERN STATIC AUTO REGISTER INLINE RESTRICT
%token CONST VOLATILE
%token STRUCT UNION ENUM ELLIPSIS

%token CASE DEFAULT IF ELSE SWITCH WHILE DO FOR GOTO CONTINUE BREAK RETURN

%type <type> type_specifier declaration_specifiers storage_class_specifier specifier_qualifier_list type_name

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
	: IDENTIFIER 
    {
        OP_TYPE type = FindSymbolInTable($1, SYMBOL_IDENTIFIER);
        $$ = CreateEmptyOPList(NULL, type);
    }
	| CONSTANT
    {
        $$ = CreateEmptyOPList(NULL, $1);
    }
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
	| postfix_expression INC_OP {$$ = AddToOPList($1, CreateEmptyOPList(AddToOPList(NULL, NULL, CreateOP(ADDITION_OP)), NONE_TYPE), NULL);}
    | postfix_expression DEC_OP {$$ = AddToOPList($1, CreateEmptyOPList(AddToOPList(NULL, NULL, CreateOP(SUBTRACTION_OP)), NONE_TYPE), NULL);}
	| '(' type_name ')' '{' initializer_list '}' {$$ = NULL;} /* TODO */
	| '(' type_name ')' '{' initializer_list ',' '}' {$$ = NULL;} /* TODO */
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
	| '(' type_name ')' cast_expression
    {
        if ($4)
            ((OP_List*)($4))->curr_type = $2;
        $$ = $4;
    }
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
	| declaration_specifiers init_declarator_list ';'
    {
        //Add the symbol table and return the OP_List* only
        AddToSymbolTable($1, ((Decl_Node*)($2))->IDs, SYMBOL_IDENTIFIER);
        //Write the type to all the OPs
        $$ = ((Decl_Node*)($2))->OPs;
    }
    | TYPEDEF declaration_specifiers ';' {$$ = NULL;}
    | TYPEDEF declaration_specifiers init_declarator_list ';'
    {
        //Add the symbol table and return the OP_List* only
        AddToSymbolTable($2, ((Decl_Node*)($3))->IDs, SYMBOL_TYPENAME);
        //Write the type to all the OPs
        $$ = ((Decl_Node*)($3))->OPs;
    }
	;

declaration_specifiers
	: storage_class_specifier {$$ = $1;}
    | storage_class_specifier declaration_specifiers {$$ = ($1 | $2);}
	| type_specifier {$$ = $1;}
	| type_specifier declaration_specifiers {$$ = ($1 | $2);}
	| type_qualifier {$$ = NONE_TYPE;}
	| type_qualifier declaration_specifiers {$$ = $2;}
	| function_specifier {$$ = NONE_TYPE;}
	| function_specifier declaration_specifiers {$$ = $2;}
    | address_qualifier {$$ = NONE_TYPE;}
    | address_qualifier declaration_specifiers {$$ = $2;}
	;

init_declarator_list
	: init_declarator {$$ = $1;}
	| init_declarator_list ',' init_declarator {$$ = AddDeclNode($1, $3);} // TODO: Merge the post_stmt_op
	;

init_declarator
	: declarator {$$ = MakeDeclNode(CreateIDList(CreateIdentifier($1)), NULL);}
	| declarator '=' initializer {$$ = MakeDeclNode(CreateIDList(CreateIdentifier($1)), $3);}
	;

storage_class_specifier
	: EXTERN {$$ = NONE_TYPE;}
	| STATIC {$$ = NONE_TYPE;}
	| AUTO {$$ = NONE_TYPE;}
	| REGISTER {$$ = NONE_TYPE;}
	;

type_specifier
	: struct_or_union_specifier {$$ = NONE_TYPE;}
	| enum_specifier {$$ = NONE_TYPE;}
	/*| IDENTIFIER {$$ = FindSymbolInTable($1, SYMBOL_TYPENAME);}*/
    | TYPE_NAME {$$ = $1;}
	| OPENCL_TYPE {$$ = $1;}
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
	: type_specifier specifier_qualifier_list {$$ = ($1 | $2);}
	| type_specifier {$$ = $1;}
    | type_qualifier specifier_qualifier_list {$$ = $2;}
	| type_qualifier {$$ = NONE_TYPE;}
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
	: specifier_qualifier_list {$$ = $1;}
	| specifier_qualifier_list abstract_declarator {$$ = $1;}
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
    | '{' {CreateSymbolTableLevel();} block_item_list '}' {ReleaseSymbolTableLevel(); $$ = $3;}
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
    : declaration 
    {
        $$ = CreateSTMTList(CreateSTMT($1, EXPRESSION_STMT));
    }
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
        ReleaseSTMTList($4);
        printf("[FUNCTION NAME \'%s\' END]\n\n", (char*)($2));
    }
    | declaration_specifiers declarator compound_statement
    {
        printf("[FUNCTION NAME \'%s\' START]\n", (char*)($2));
        DebugSTMTList($3, 1);
        ReleaseSTMTList($3);
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
