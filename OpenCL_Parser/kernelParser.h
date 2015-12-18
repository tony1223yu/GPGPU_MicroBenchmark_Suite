#ifndef __OPENCL_PARSER_H__
#define __OPENCL_PARSER_H__

typedef struct DEP DEP;
typedef struct Operation Operation;
typedef struct STMT_List STMT_List;
typedef struct FUNCTION FUNCTION;
typedef struct PROGRAM PROGRAM;
typedef struct Statement Statement;
typedef struct OP_List OP_List;
typedef enum OP_TYPE OP_TYPE;
typedef enum OP_KIND OP_KIND;
typedef enum STMT_TYPE STMT_TYPE;
typedef enum DEP_TYPE DEP_TYPE;

PROGRAM* prog;

enum DEP_TYPE
{
    ISSUE_DEP = 0,
    STRUCTURAL_DEP,
    DATA_DEP
};

enum STMT_TYPE
{
    EXPRESSION_STMT = 0,
    SELECTION_STMT,
    ITERATION_STMT,
    IF_STMT,
    ELSE_STMT
};

enum OP_TYPE
{
    INT_TYPE = 0
};

enum OP_KIND
{
    ADDITION_OP = 0,
    SUBTRACTION_OP,
    MULTIPLICATION_OP,
    DIVISION_OP,
    MODULAR_OP,
    MEMORY_OP
};

struct DEP
{
    Operation* op;
    unsigned long long int latency;
};

/* Add post-statement operation? */
struct OP_List
{
    Operation* op_head;
    Operation* op_tail;
    OP_List* post_stmt_op_list;
};


/* Add pre-statement expression? */
struct Statement
{
    /* TODO: Use union to include three types of pointers? EXPRESSION_STMT, ITERATION_STMT, SELECTION_STMT */
    OP_List* op_list;
    STMT_List* stmt_list;
    STMT_TYPE type;
    int opID;
    Statement* next;
};

struct Operation
{
    int id; // ID of current statement
    OP_KIND kind;
    OP_TYPE type;

    DEP* issue_dep; // pointer to the stmt that current stmt need to wait becuase of issue dependency
    DEP* structural_dep; // pointer to the stmt that current stmt need to wait becuase of structural dependency
    DEP* data_dep; // pointer to the stmt that current stmt need to wait becuase of data dependency
    Operation *next; // pointer to next stmt with ID equals to (id+1)
};

struct STMT_List
{
    Statement* stmt_head;
    Statement* stmt_tail;
};

struct FUNCTION
{
    char* functionName;
    PROGRAM* parentProgram;
    FUNCTION* next;
};

struct PROGRAM
{
    FUNCTION* function_head;
    FUNCTION* function_tail;
};

#endif
