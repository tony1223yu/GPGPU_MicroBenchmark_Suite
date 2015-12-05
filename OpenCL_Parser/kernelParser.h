#ifndef __OPENCL_PARSER_H__
#define __OPENCL_PARSER_H__

typedef struct DEP DEP;
typedef struct STMT STMT;
typedef struct STMT_GROUP STMT_GROUP;
typedef struct FUNCTION FUNCTION;
typedef struct PROGRAM PROGRAM;
typedef enum STMT_TYPE STMT_TYPE;


PROGRAM* prog;
FUNCTION *curFunction_h, *curFunction_t;
STMT_GROUP *curSTMTGroup_h, *curSTMTGroup_t;
STMT *curSTMT_h, *curSTMT_t;

enum STMT_TYPE
{
    INT_ADDITION = 0,
    INT_MULTIPLICATION,
    INT_DIVISION,
    FLOAT_ADDITION,
    FLOAT_MULTIPLICATION,
    FLOAT_DIVISION,
    DOUBLE_ADDITION,
    DOUBLE_MULTIPLICATION,
    DOUBLE_DIVISION,
    MEMORY_LOAD,
    MEMORY_STORE,
    ADDITION = 1000,
    SUBTRACTION,
    MULTIPLICATION,
    DIVISION,
    MODULAR
};

struct DEP
{
    STMT* stmt;
    unsigned long long int latency;
};

struct STMT
{
    int id; // ID of current statement
    STMT_TYPE type;
    STMT_GROUP* parentGroup;
/*
    union
    {
        COMPUTE_INSTRUCTION compute_inst;
        MEMORY_INSTRUCTION memory_inst;
    } description;
*/

    DEP* issue_dep; // pointer to the stmt that current stmt need to wait becuase of issue dependency
    DEP* structural_dep; // pointer to the stmt that current stmt need to wait becuase of structural dependency
    DEP* data_dep; // pointer to the stmt that current stmt need to wait becuase of data dependency
    STMT *next; // pointer to next stmt with ID equals to (id+1)
};

struct STMT_GROUP
{
    FUNCTION* parentFunction;
    STMT* stmt_head;
    STMT* stmt_tail;
    unsigned long long int iterationTime;
    unsigned long long int workitemCount;
    STMT_GROUP* next;
    STMT_GROUP* sibling;
    int stmtID;
};

struct FUNCTION
{
    char* functionName;
    PROGRAM* parentProgram;
    STMT_GROUP* stmt_group_head;
    STMT_GROUP* stmt_group_tail;
    FUNCTION* next;
};

struct PROGRAM
{
    FUNCTION* function_head;
    FUNCTION* function_tail;
};

#endif
