%{
#include <stdio.h>
#include <stdlib.h>
#include "kernelParser.h"

long long op_num;
extern PROGRAM* prog;
extern SymbolTable* symTable;
extern StructDescriptorTable* structTable;

TypeDescriptor MixType(TypeDescriptor left, TypeDescriptor right)
{
    return CreateTypeDescriptor(((left.type > right.type) ? left.type : right.type), NULL);
}

void initial()
{
    prog = NULL;
    op_num = 0;
    CreateSymbolTable();
    CreateSymbolTableLevel();
}

void release()
{
    /* Release the global level */
    ReleaseSymbolTableLevel();
    ReleaseSymbolTable();

    ReleaseStructTable();
}

void MakeDependency(Operation* currOP, Operation* dependOP, DEP_TYPE type, unsigned long long int latency)
{
    if ((currOP == NULL) || (dependOP == NULL))
        return;
    else
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
            case DATA_DEP_L:
                currOP->data_dep_l = tmp;
                break;
            case DATA_DEP_R:
                currOP->data_dep_r = tmp;
                break;
            default:
                fprintf(stderr, "[Error] Unknown type of dependency\n");
                break;
        }
    }
}

// use to create new operation with RAW dependency
Operation* CreateOPWithDataHazard(OP_KIND kind, OP_List* left, OP_List* right)
{
    if (kind != NONE_OP)
    {
        Operation* tmp;
        //fprintf(stderr, "[OpenCL Parser] Create STMT of type = %d\n", type);
        tmp = (Operation*)malloc(sizeof(Operation));
        tmp->kind = kind;
        tmp->type = NONE_TYPE;
        tmp->data_dep_l = NULL;
        tmp->data_dep_r = NULL;
        tmp->issue_dep = NULL;
        tmp->structural_dep = NULL;
        tmp->next = NULL;
        tmp->number = ++op_num;

        if (left == NULL)
            tmp->data_dep_l = NULL;
        else if (left->op_head)
            MakeDependency(tmp, left->op_tail, DATA_DEP_L, 1);
        else if (left->table_entry)
            MakeDependency(tmp, left->table_entry->op, DATA_DEP_L, 1);
        else
            tmp->data_dep_l = NULL;

        if (right == NULL)
            tmp->data_dep_r = NULL;
        else if (right->op_head)
            MakeDependency(tmp, right->op_tail, DATA_DEP_R, 1);
        else if (right->table_entry)
            MakeDependency(tmp, right->table_entry->op, DATA_DEP_R, 1);
        else
            tmp->data_dep_r = NULL;

        return tmp;
    }
    else
        return NULL;
}

Operation* CreateOP(OP_KIND kind)
{
    if (kind != NONE_OP)
    {
        Operation* tmp;
        //fprintf(stderr, "[OpenCL Parser] Create STMT of type = %d\n", type);
        tmp = (Operation*)malloc(sizeof(Operation));
        tmp->kind = kind;
        tmp->type = NONE_TYPE;
        tmp->issue_dep = NULL;
        tmp->structural_dep = NULL;
        tmp->data_dep_l = NULL;
        tmp->data_dep_r = NULL;
        tmp->next = NULL;
        tmp->number = ++op_num;
        return tmp;
    }
    else
        return NULL;
}

void ReleaseOP(Operation* op)
{
    if (!op) return;
    if (op->issue_dep)
        free (op->issue_dep);
    if (op->structural_dep)
        free (op->structural_dep);
    if (op->data_dep_l)
        free (op->data_dep_l);
    if (op->data_dep_r)
        free (op->data_dep_r);

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
            fprintf(stderr, "[Error] Unrecognized operation kind\n");
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
        default: fprintf(stderr, "[Error] Unrecognized operation type\n");
    }
}

void DebugSTMTList(STMT_List* stmt_list, int order)
{
    char opKind[30];
    char opType[30];
    char depKind[30];
    char depType[30];
    char stmtType[30];
    int i;
    if (stmt_list != NULL && stmt_list->stmt_head != NULL)
    {
        Statement* iterStmt = stmt_list->stmt_head;
        Operation* iterOP;
        while (iterStmt != NULL)
        {
            if (iterStmt->type == EXPRESSION_STMT)
            {
                iterOP = iterStmt->op_list->op_head;
                while (iterOP != NULL)
                {
                    for (i = 0 ; i < order ; i ++)
                        printf("\t");

                    GetOperationDescriptor(iterOP, opKind, opType);
                    printf("[%lld] %s_%s", iterOP->number, opType, opKind);
                    if (iterOP->issue_dep != NULL)
                    {
                        printf(", [issue] #%lld", iterOP->issue_dep->op->number);
                    }
                    if (iterOP->data_dep_l != NULL)
                    {
                        printf(", [data] #%lld", iterOP->data_dep_l->op->number);
                    }
                    if (iterOP->data_dep_r != NULL)
                    {
                        printf(", [data] #%lld", iterOP->data_dep_r->op->number);
                    }
                    printf("\n");
                    iterOP = iterOP->next;
                }
                //printf("NULL\n");
            }
            else                 // recursive call for ITERATION_STMT, SELECTION_STMT, IF_STMT and ELSE_STMT
            {
                for (i = 0 ; i < order ; i ++)
                    printf("\t");
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

Parameter* CreateParameter(TypeDescriptor type_desc, char* name)
{
    Parameter* tmp = (Parameter*) malloc(sizeof(Parameter));
    tmp->type_desc = type_desc;
    tmp->name = name;
    tmp->next = NULL;
    return tmp;
}

Param_List* CreateParamList(Parameter* param)
{
    Param_List* tmp = (Param_List*) malloc(sizeof(Param_List));
    tmp->param_head = param;
    tmp->param_tail = param;
    return tmp;
}

Param_List* AddToParamList(Param_List* left, Param_List* right)
{
    if ((!left) && (!right)) return NULL;

    if (!left)
        return right;
    else if (!right)
        return left;
    else
    {
        left->param_tail->next = right->param_head;
        left->param_tail = right->param_tail;

        free (right);
        return left;
    }
}

Declarator* CreateDeclarator(char* name, Param_List* param_list)
{
    Declarator* tmp = (Declarator*) malloc(sizeof(Declarator));
    tmp->name = name;
    tmp->Params = param_list;
    return tmp;
}

void AddParamInDeclarator(Declarator* decl)
{
    if (decl->Params)
    {
        Parameter* iter = decl->Params->param_head;
        while (iter)
        {
            AddParamToSymbolTable(iter->type_desc, iter->name, SYMBOL_IDENTIFIER);
            iter = iter->next;
        }
        free (decl->Params);
        decl->Params = NULL;
    }
}

char* GetNameInDeclarator(Declarator* decl)
{
    // Release param
    if (decl->Params)
    {
        Parameter* iter = decl->Params->param_head;
        while (iter)
        {
            free (iter->name);
            iter = iter->next;
        }
        free (decl->Params);
    }
    return decl->name; 
}

Declarator* AddToDeclarator(Declarator* origin, Param_List* extra_param)
{
    if (!origin)
    {
        return CreateDeclarator(NULL, extra_param);
    }
    else
    {
        origin->Params = AddToParamList(origin->Params, extra_param);
        return origin;
    }
}

Identifier* CreateIdentifier(char* name, OP_List* op_list)
{
    Identifier* tmp = (Identifier*) malloc(sizeof(Identifier));
    tmp->name = name;
    tmp->op = NULL;
    if (op_list)
        tmp->op = op_list->op_tail;
    tmp->next = NULL;
    return tmp;
}

ID_List* CreateIDList(Identifier* ID)
{
    ID_List* tmp = (ID_List*) malloc(sizeof(ID_List));
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

Declaration* AddDeclaration(Declaration* left, Declaration* right)
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

Declaration* MakeDeclaration(ID_List* id_list, OP_List* op_list)
{
    Declaration* tmp = (Declaration*) malloc(sizeof(Declaration));
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
        MakeDependency(curr->stmt_head->op_list->op_head, prev->stmt_tail->op_list->op_tail, ISSUE_DEP, 1);
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

        if (list == NULL)
        {
            free (tmp);
            return NULL;
        }
        else if (list->op_head == NULL)
        {
            free(tmp);
            free(list);
            return NULL;
        }
        else
        {
            list->table_entry = NULL;
            tmp->op_list = list;
        }
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

// TODO: handle symbol_entry issue
OP_List* AddToOPList(OP_List* left, OP_List* right, Operation* newOP)
{
    TypeDescriptor mix_type;
    OP_List* mix_post_stmt_op_list;

    // type
    if ((left == NULL) && (right == NULL))
        mix_type = CreateTypeDescriptor(NONE_TYPE, NULL);
    else if (left == NULL)
        mix_type = right->curr_type_desc;
    else if (right == NULL)
        mix_type = left->curr_type_desc;
    else
        mix_type = MixType(left->curr_type_desc, right->curr_type_desc);

    if (newOP)
        newOP->type = mix_type.type;

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
        if (newOP != NULL)
        {
            tmp = (OP_List*)malloc(sizeof(OP_List));
            tmp->op_head = newOP;
            tmp->op_tail = newOP;
            tmp->curr_type_desc = mix_type;
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
        right->curr_type_desc = mix_type;
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
        left->curr_type_desc = mix_type;
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
            left->curr_type_desc = mix_type;
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
            right->curr_type_desc = mix_type;
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
            left->curr_type_desc = mix_type;
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
            left->curr_type_desc = mix_type;
            left->post_stmt_op_list = mix_post_stmt_op_list;
            free (right);
            return left;
        }

    }
}

OP_List* CreateEmptyOPList(OP_List* post_stmt_op_list, TypeDescriptor type_desc, SymbolTableEntry* table_entry)
{
    OP_List* tmp;
    tmp = (OP_List*)malloc(sizeof(OP_List));
    tmp->op_head = NULL;
    tmp->op_tail = NULL;
    tmp->table_entry = table_entry;
    tmp->curr_type_desc = type_desc;
    tmp->post_stmt_op_list = post_stmt_op_list;

    if (post_stmt_op_list)
    {
        Operation* iterOP = post_stmt_op_list->op_head;
        while (iterOP)
        {
            iterOP->type = type_desc.type;
            iterOP = iterOP->next;
        }
    }
    return tmp;
}

StructDescriptor* MergeStructDescriptor(StructDescriptor* left, StructDescriptor* right)
{
    if ((left == NULL) && (right == NULL))
        return NULL;
    else if (left == NULL)
        return right;
    else if (right == NULL)
        return left;
    else
    {
        StructMember* iter_member = right->member_head;
        while (iter_member)
        {
            left = AddToStructDescriptor(left, iter_member);
            iter_member = iter_member->next;
        }
        return left;
    }
}

StructDescriptor* CreateStructDescriptor(TypeDescriptor type_desc, ID_List* IDs)
{
    Identifier* iter = IDs->id_head;

    StructMember* tmp_member = NULL;
    StructDescriptor* tmp_desc = NULL;

    while (iter)
    {
        tmp_member = CreateStructMember(type_desc, iter->name);
        tmp_desc = AddToStructDescriptor(tmp_desc, tmp_member);
        tmp_member = NULL;
        iter = iter->next;
    }
    return tmp_desc;
}

StructMember* CreateStructMember(TypeDescriptor type_desc, char* name)
{
    StructMember* tmp = (StructMember*) malloc(sizeof(StructMember));
    tmp->type_desc = type_desc;
    tmp->name = name;
    tmp->next = NULL;
    return tmp;
}

StructDescriptor* AddToStructDescriptor(StructDescriptor* origin, StructMember* newMember)
{
    if (!newMember)
        return origin;
    else if (!origin)
    {
        StructDescriptor* tmp = (StructDescriptor*) malloc(sizeof(StructDescriptor));
        tmp->member_head = newMember;
        tmp->member_tail = newMember;
        tmp->next = NULL;
        return tmp;
    }
    else
    {
        StructMember* iter = origin->member_head;
        StructMember* prev = NULL;
        int cmpResult;
        while (1)
        {
            if (!iter)
            {
                prev->next = newMember;
                origin->member_tail = newMember;
                break;
            }
            cmpResult = strcmp(iter->name, newMember->name);
            if (cmpResult > 0)
            {
                if (prev)
                    prev->next = newMember;

                newMember->next = iter;

                if (iter == origin->member_head)
                    origin->member_head = newMember;

                break;
            }
            else if (cmpResult == 0)
            {
                fprintf(stderr, "[Error] Redefine symbol %s\n", newMember->name);
                break;
            }
            else // cmpResult < 0
            {
                prev = iter;
                iter = iter->next;
            }
        }
        return origin;
    }
}

StructDescriptor* FindInStructTable(char* name)
{
    if (!structTable)
        return NULL;
    else
    {
        StructDescriptor* iter = structTable->desc_head;
        while (iter)
        {
            if (strcmp(iter->name, name) == 0)
                return iter;

            iter = iter->next;
        }
    }
}

void ReleaseStructDescriptor(StructDescriptor* desc)
{
    if (!desc) return;
    else
    {
        StructMember* iter = desc->member_head;
        while (iter)
        {
            free (iter->name);
            iter = iter->next;
        }
        free (desc->name);
    }
}

void ReleaseStructTable()
{
    if (!structTable) return;
    else
    {
        StructDescriptor* iter = structTable->desc_head;
        while (iter)
        {
            ReleaseStructDescriptor(iter);
            iter = iter->next;
        }
    }
}

void AddToStructDescriptorTable(StructDescriptor* new_desc, char* desc_name)
{
    if (new_desc)
        new_desc->name = desc_name;

    if (!structTable)
    {
        structTable = (StructDescriptorTable*) malloc(sizeof(StructDescriptorTable));
        structTable->desc_head = new_desc;
        structTable->desc_tail = new_desc;
    }
    else
    {
        structTable->desc_tail->next = new_desc;
        structTable->desc_tail = new_desc;
    }
}

TypeDescriptor GetTypeInStructDescriptor(StructDescriptor* struct_desc, char* member_name)
{
    if (!struct_desc)
        return CreateTypeDescriptor(NONE_TYPE, NULL);
    else
    {
        StructMember* iter = struct_desc->member_head;
        int compare;
        while (iter)
        {
            compare = strcmp(iter->name, member_name);
            if (compare == 0)
                return iter->type_desc;
            else if (compare < 0)
                iter = iter->next;
            else
            {
                fprintf(stderr, "[Error] Identifier %s does not defined in struct %s\n", member_name, struct_desc->name);
                return CreateTypeDescriptor(NONE_TYPE, NULL);
            }
        }
        fprintf(stderr, "[Error] Identifier %s does not defined in struct %s\n", member_name, struct_desc->name);
        return CreateTypeDescriptor(NONE_TYPE, NULL);
    }
}

SymbolTableEntry* GetStructMemberInSymbolEntry(SymbolTableEntry* entry, char* name)
{
    SymbolTableEntry* iter = entry->subEntry_head;
    while (iter)
    {
        if (strcmp(iter->sym_name, name) == 0)
            return iter;
        else
            iter = iter->next;
    }
    fprintf(stderr, "[Error] Identifier %s does not defined in struct %s\n", name, entry->sym_name);
}

TypeDescriptor CreateTypeDescriptor(OP_TYPE type, StructDescriptor* struct_desc)
{
    TypeDescriptor tmp;
    tmp.type = type;
    tmp.struct_desc = struct_desc;
    return tmp;
}

%}

%union
{
    OP_TYPE op_type;
    TypeDescriptor type_desc;
    OP_KIND op_kind;
    void *ptr;
}

%token KERNEL ADDRESS_GLOBAL ADDRESS_LOCAL ADDRESS_PRIVATE ADDRESS_CONSTANT DEFINE

%token <type_desc> TYPE_NAME
%token <op_type> OPENCL_TYPE GLOBAL_ID_FUNC GLOBAL_SIZE_FUNC LOCAL_ID_FUNC LOCAL_SIZE_FUNC WORK_DIM_FUNC NUM_GROUPS_FUNC GROUP_ID_FUNC
%token <op_type> CONSTANT
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

%type <type_desc> type_specifier declaration_specifiers storage_class_specifier specifier_qualifier_list type_name struct_or_union_specifier

%type <op_type> struct_or_union

%type <op_kind> assignment_operator

/* TYPE: (StructDescriptor*) */
%type <ptr> struct_declaration struct_declaration_list

/* TYPE: (Declarator*) */
%type <ptr> declarator direct_declarator 

/* TYPE: (Declaration*) */
%type <ptr> init_declarator_list init_declarator struct_declarator_list struct_declarator

/* TYPE: (Param_List*) */
%type <ptr> parameter_type_list parameter_list parameter_declaration


/* TYPE: (OP_List*) */
%type <ptr> primary_expression postfix_expression unary_expression cast_expression multiplicative_expression additive_expression shift_expression relational_expression equality_expression and_expression exclusive_or_expression inclusive_or_expression logical_and_expression logical_or_expression unary_operator conditional_expression assignment_expression expression expression_statement declaration initializer initializer_list

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
        TypeDescriptor type = FindSymbolInTable($1, SYMBOL_IDENTIFIER);
        SymbolTableEntry* tmp = GetTableEntry($1);
        $$ = CreateEmptyOPList(NULL, type, tmp);
    }
	| CONSTANT
    {
        $$ = CreateEmptyOPList(NULL, CreateTypeDescriptor($1, NULL), NULL);
    }
	| STRING_LITERAL {$$ = NULL;}
	| '(' expression ')' {$$ = $2;}
	;

/* function call here */
postfix_expression
	: primary_expression {$$ = $1;}
	| postfix_expression '[' expression ']' {$$ = AddToOPList($1, $3, CreateOP(MEMORY_OP));}
	| postfix_expression '(' ')' {$$ = $1;} /* TODO: function call */
	| postfix_expression '(' argument_expression_list ')' {$$ = $1;} /* TODO: function call */
	| postfix_expression '.' IDENTIFIER
    {
        OP_List* tmp = (OP_List*)($1);
        if (tmp->curr_type_desc.type == STRUCT_TYPE)
        {
            tmp->curr_type_desc = GetTypeInStructDescriptor(tmp->curr_type_desc.struct_desc, $3);
            tmp->table_entry = GetStructMemberInSymbolEntry(tmp->table_entry, $3);
        }
        else
        {
            fprintf(stderr, "[Error] Target identifier is not a struct\n");
        }
        $$ = $1;
    }
	| postfix_expression PTR_OP IDENTIFIER {$$ = $1;} /* TODO: reference for structure/union */
	| postfix_expression INC_OP {$$ = AddToOPList($1, CreateEmptyOPList(AddToOPList(NULL, NULL, CreateOP(ADDITION_OP)), ((OP_List*)($1))->curr_type_desc, NULL), NULL);}
    | postfix_expression DEC_OP {$$ = AddToOPList($1, CreateEmptyOPList(AddToOPList(NULL, NULL, CreateOP(SUBTRACTION_OP)), ((OP_List*)($1))->curr_type_desc, NULL), NULL);}
	| '(' type_name ')' '{' initializer_list '}' {$$ = NULL;} /* TODO */
	| '(' type_name ')' '{' initializer_list ',' '}' {$$ = NULL;} /* TODO */
    | GLOBAL_ID_FUNC '(' assignment_expression ')' {$$ = AddToOPList(CreateEmptyOPList(NULL, CreateTypeDescriptor($1, NULL), NULL), $3, NULL);}
    | GLOBAL_SIZE_FUNC '(' assignment_expression ')' {$$ = AddToOPList(CreateEmptyOPList(NULL, CreateTypeDescriptor($1, NULL), NULL), $3, NULL);}
    | LOCAL_ID_FUNC '(' assignment_expression ')' {$$ = AddToOPList(CreateEmptyOPList(NULL, CreateTypeDescriptor($1, NULL), NULL), $3, NULL);}
    | LOCAL_SIZE_FUNC '(' assignment_expression ')' {$$ = AddToOPList(CreateEmptyOPList(NULL, CreateTypeDescriptor($1, NULL), NULL), $3, NULL);}
    | WORK_DIM_FUNC '(' ')' {$$ = CreateEmptyOPList(NULL, CreateTypeDescriptor($1, NULL), NULL);}
    | NUM_GROUPS_FUNC '(' assignment_expression ')' {$$ = AddToOPList(CreateEmptyOPList(NULL, CreateTypeDescriptor($1, NULL), NULL), $3, NULL);}
    | GROUP_ID_FUNC '(' assignment_expression ')' {$$ = AddToOPList(CreateEmptyOPList(NULL, CreateTypeDescriptor($1, NULL), NULL), $3, NULL);}
    ;

argument_expression_list
	: assignment_expression
	| argument_expression_list ',' assignment_expression
	;

unary_expression
	: postfix_expression {$$ = $1;}
	| INC_OP unary_expression
    {
        Operation* op = CreateOPWithDataHazard(ADDITION_OP, NULL, $2);
        $$ = AddToOPList(NULL, $2, op);
    }
	| DEC_OP unary_expression
    {
        Operation* op = CreateOPWithDataHazard(SUBTRACTION_OP, NULL, $2);
        $$ = AddToOPList(NULL, $2, op);
    }
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
            ((OP_List*)($4))->curr_type_desc = $2;
        $$ = $4;
    }
	;

multiplicative_expression
	: cast_expression {$$ = $1;}
	| multiplicative_expression '*' cast_expression
    {
        Operation* op = CreateOPWithDataHazard(MULTIPLICATION_OP, $1, $3);
        $$ = AddToOPList($1, $3, op);
    }
	| multiplicative_expression '/' cast_expression
    {
        Operation* op = CreateOPWithDataHazard(DIVISION_OP, $1, $3);
        $$ = AddToOPList($1, $3, op);
    }
	| multiplicative_expression '%' cast_expression
    {
        Operation* op = CreateOPWithDataHazard(MODULAR_OP, $1, $3);
        $$ = AddToOPList($1, $3, op);
    }
	;

additive_expression
	: multiplicative_expression {$$ = $1;}
	| additive_expression '+' multiplicative_expression
    {
        Operation* op = CreateOPWithDataHazard(ADDITION_OP, $1, $3);
        $$ = AddToOPList($1, $3, op);
    }
	| additive_expression '-' multiplicative_expression
    {
        Operation* op = CreateOPWithDataHazard(SUBTRACTION_OP, $1, $3);
        $$ = AddToOPList($1, $3, op);
    }
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
	| unary_expression assignment_operator assignment_expression
    {
        // TODO: table_entry in AddToOPList()
        Operation* op = CreateOPWithDataHazard($2, $1, $3);
        $$ = AddToOPList($3, $1, op);
        UpdateSymbolTable($1, $$);
    }
	;

assignment_operator
	: '=' {$$ = NONE_OP;}
	| MUL_ASSIGN {$$ = MULTIPLICATION_OP;}
	| DIV_ASSIGN {$$ = DIVISION_OP;}
	| MOD_ASSIGN {$$ = MODULAR_OP;}
	| ADD_ASSIGN {$$ = ADDITION_OP;}
	| SUB_ASSIGN {$$ = SUBTRACTION_OP;}
	| LEFT_ASSIGN {$$ = NONE_OP;}
	| RIGHT_ASSIGN {$$ = NONE_OP;}
	| AND_ASSIGN {$$ = NONE_OP;}
	| XOR_ASSIGN {$$ = NONE_OP;}
	| OR_ASSIGN {$$ = NONE_OP;}
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
        AddIDListToSymbolTable($1, ((Declaration*)($2))->IDs, SYMBOL_IDENTIFIER);
        $$ = ((Declaration*)($2))->OPs;
        free ($2);
    }
    | TYPEDEF declaration_specifiers ';' {$$ = NULL;}
    | TYPEDEF declaration_specifiers init_declarator_list ';'
    {
        AddIDListToSymbolTable($2, ((Declaration*)($3))->IDs, SYMBOL_TYPENAME);
        $$ = ((Declaration*)($3))->OPs;
        free ($3);
    }
	;

declaration_specifiers
	: storage_class_specifier {$$ = $1;}
    | storage_class_specifier declaration_specifiers {$$ = MixType($1, $2);}
	| type_specifier {$$ = $1;}
	| type_specifier declaration_specifiers {$$ = MixType($1, $2);}
	| type_qualifier {$$ = CreateTypeDescriptor(NONE_TYPE, NULL);}
	| type_qualifier declaration_specifiers {$$ = $2;}
	| function_specifier {$$ = CreateTypeDescriptor(NONE_TYPE, NULL);}
	| function_specifier declaration_specifiers {$$ = $2;}
    | address_qualifier {$$ = CreateTypeDescriptor(NONE_TYPE, NULL);}
    | address_qualifier declaration_specifiers {$$ = $2;}
	;

init_declarator_list
	: init_declarator {$$ = $1;}
	| init_declarator_list ',' init_declarator {$$ = AddDeclaration($1, $3);} // TODO: Merge the post_stmt_op
	;

init_declarator
	: declarator {$$ = MakeDeclaration(CreateIDList(CreateIdentifier(GetNameInDeclarator($1), NULL)), NULL);}
	| declarator '=' initializer {$$ = MakeDeclaration(CreateIDList(CreateIdentifier(GetNameInDeclarator($1), $3)), $3);}
	;

storage_class_specifier
	: EXTERN {$$ = CreateTypeDescriptor(NONE_TYPE, NULL);}
	| STATIC {$$ = CreateTypeDescriptor(NONE_TYPE, NULL);}
	| AUTO {$$ = CreateTypeDescriptor(NONE_TYPE, NULL);}
	| REGISTER {$$ = CreateTypeDescriptor(NONE_TYPE, NULL);}
	;

type_specifier
    : struct_or_union_specifier {$$ = $1;}
	| enum_specifier {$$ = CreateTypeDescriptor(NONE_TYPE, NULL);}
    | TYPE_NAME {$$ = $1;}
	| OPENCL_TYPE {$$ = CreateTypeDescriptor($1, NULL);}
    ;

struct_or_union_specifier
	: struct_or_union IDENTIFIER '{' struct_declaration_list '}'
    {
        AddToStructDescriptorTable($4, $2);
        $$ = CreateTypeDescriptor($1, $4);
    }
	| struct_or_union '{' struct_declaration_list '}'
    {
        $$ = CreateTypeDescriptor($1, $3);
    }
	| struct_or_union IDENTIFIER
    {
        StructDescriptor* tmp = FindInStructTable($2);
        $$ = CreateTypeDescriptor($1, tmp);
    }
	;

struct_or_union
	: STRUCT {$$ = STRUCT_TYPE;}
	| UNION {$$ = UNION_TYPE;}
	;

struct_declaration_list
	: struct_declaration {$$ = $1;}
	| struct_declaration_list struct_declaration {$$ = MergeStructDescriptor($1, $2);}
	;

struct_declaration
	: specifier_qualifier_list struct_declarator_list ';' {$$ = CreateStructDescriptor($1, ((Declaration*)($2))->IDs);}
	;

specifier_qualifier_list
	: type_specifier specifier_qualifier_list {$$ = MixType($1, $2);}
	| type_specifier {$$ = $1;}
    | type_qualifier specifier_qualifier_list {$$ = $2;}
	| type_qualifier {$$ = CreateTypeDescriptor(NONE_TYPE, NULL);}
	;

struct_declarator_list
	: struct_declarator {$$ = $1;}
	| struct_declarator_list ',' struct_declarator {$$ = AddDeclaration($1, $3);}
	;

struct_declarator
	: declarator {$$ = MakeDeclaration(CreateIDList(CreateIdentifier(GetNameInDeclarator($1), NULL)), NULL);}
	| ':' constant_expression {$$ = NULL;}
	| declarator ':' constant_expression {$$ = MakeDeclaration(CreateIDList(CreateIdentifier(GetNameInDeclarator($1), NULL)), NULL);}
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
	: IDENTIFIER
    {
        $$ = CreateDeclarator($1, NULL);
    }
	| '(' declarator ')' {$$ = $2;}
	| direct_declarator '[' type_qualifier_list assignment_expression ']' {$$ = $1;}
	| direct_declarator '[' type_qualifier_list ']' {$$ = $1;}
	| direct_declarator '[' assignment_expression ']' {$$ = $1;}
	| direct_declarator '[' STATIC type_qualifier_list assignment_expression ']' {$$ = $1;}
	| direct_declarator '[' type_qualifier_list STATIC assignment_expression ']' {$$ = $1;}
	| direct_declarator '[' type_qualifier_list '*' ']' {$$ = $1;}
	| direct_declarator '[' '*' ']' {$$ = $1;}
	| direct_declarator '[' ']' {$$ = $1;}
	| direct_declarator '(' parameter_type_list ')'
    {
        $$ = AddToDeclarator($1, $3);
    }
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
	: parameter_list {$$ = $1;}
	| parameter_list ',' ELLIPSIS {$$ = $1;}
	;

parameter_list
	: parameter_declaration {$$ = $1;}
	| parameter_list ',' parameter_declaration {AddToParamList($1, $3);}
	;

parameter_declaration
	: declaration_specifiers declarator {$$ = CreateParamList(CreateParameter($1, GetNameInDeclarator($2)));}
	| declaration_specifiers abstract_declarator {$$ = NULL;}
	| declaration_specifiers {$$ = NULL;}
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
	| {CreateSymbolTableLevel();} compound_statement {ReleaseSymbolTableLevel(); $$ = $2;}  // Should not be a statement, return STMT_List*
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
	: declaration_specifiers declarator declaration_list
    {
        CreateSymbolTableLevel();
        AddParamInDeclarator($2);
    }
        compound_statement
    {
        char* name = GetNameInDeclarator($2);
        ReleaseSymbolTableLevel();
        printf("[FUNCTION NAME \'%s\' START]\n", name);
        DebugSTMTList($5, 1);
        ReleaseSTMTList($5);
        printf("[FUNCTION NAME \'%s\' END]\n\n", name);
        free (name);
    }
    | declaration_specifiers declarator
    {
        CreateSymbolTableLevel();
        AddParamInDeclarator($2);
    }
        compound_statement
    {
        char* name = GetNameInDeclarator($2);
        ReleaseSymbolTableLevel();
        printf("[FUNCTION NAME \'%s\' START]\n", name);
        DebugSTMTList($4, 1);
        ReleaseSTMTList($4);
        printf("[FUNCTION NAME \'%s\' END]\n\n", name);
        free (name);
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
