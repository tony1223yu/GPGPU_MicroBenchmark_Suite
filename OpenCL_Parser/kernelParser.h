#ifndef __OPENCL_PARSER_H__
#define __OPENCL_PARSER_H__

typedef struct DEP DEP;
typedef struct Operation Operation;
typedef struct STMT_List STMT_List;
typedef struct FUNCTION FUNCTION;
typedef struct PROGRAM PROGRAM;
typedef struct Statement Statement;
typedef struct OP_List OP_List;
typedef struct Identifier Identifier;
typedef struct ID_List ID_List;
typedef struct Decl_Node Decl_Node;
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
    NONE_TYPE = 0,
    BOOL_TYPE,
    HALF_TYPE,
    VOID_TYPE,
    CHAR_TYPE,
    CHAR2_TYPE,
    CHAR4_TYPE,
    CHAR8_TYPE,
    CHAR16_TYPE,
    UCHAR_TYPE,
    UCHAR2_TYPE,
    UCHAR4_TYPE,
    UCHAR8_TYPE,
    UCHAR16_TYPE,
    SHORT_TYPE,
    SHORT2_TYPE,
    SHORT4_TYPE,
    SHORT8_TYPE,
    SHORT16_TYPE,
    USHORT_TYPE,
    USHORT2_TYPE,
    USHORT4_TYPE,
    USHORT8_TYPE,
    USHORT16_TYPE,
    INT_TYPE,
    INT2_TYPE,
    INT4_TYPE,
    INT8_TYPE,
    INT16_TYPE,
    UINT_TYPE,
    UINT2_TYPE,
    UINT4_TYPE,
    UINT8_TYPE,
    UINT16_TYPE,
    LONG_TYPE,
    LONG2_TYPE,
    LONG4_TYPE,
    LONG8_TYPE,
    LONG16_TYPE,
    ULONG_TYPE,
    ULONG2_TYPE,
    ULONG4_TYPE,
    ULONG8_TYPE,
    ULONG16_TYPE,
    FLOAT_TYPE = 10000,
    FLOAT2_TYPE,
    FLOAT4_TYPE,
    FLOAT8_TYPE,
    FLOAT16_TYPE,
    DOUBLE_TYPE,
    DOUBLE2_TYPE,
    DOUBLE4_TYPE,
    DOUBLE8_TYPE,
    DOUBLE16_TYPE,
};

enum OP_KIND
{
    NONE_OP = 0,
    ADDITION_OP,
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

struct Identifier
{
    char* name;
    Identifier* next;
};

struct ID_List
{
    Identifier* id_head;
    Identifier* id_tail;
};

/* Add post-statement operation? */
struct OP_List
{
    Operation* op_head;
    Operation* op_tail;
    OP_List* post_stmt_op_list;
    OP_TYPE curr_type;
};

struct Decl_Node
{
    ID_List* IDs;
    OP_List* OPs;
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
