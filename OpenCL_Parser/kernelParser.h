#ifndef __OPENCL_PARSER_H__
#define __OPENCL_PARSER_H__

/*========================================================================== DATA STRUCTURE DECLARATION ===============================================================*/

typedef struct DEP DEP;
typedef struct Operation Operation;
typedef struct STMT_List STMT_List;
typedef struct FUNCTION FUNCTION;
typedef struct PROGRAM PROGRAM;
typedef struct Statement Statement;
typedef struct OP_List OP_List;
typedef struct Identifier Identifier;
typedef struct ID_List ID_List;
typedef struct Parameter Parameter;
typedef struct Param_List Param_List;
typedef struct Declarator Declarator;
typedef struct Declaration Declaration;
typedef enum OP_TYPE OP_TYPE;
typedef enum OP_KIND OP_KIND;
typedef enum STMT_TYPE STMT_TYPE;
typedef enum DEP_TYPE DEP_TYPE;
typedef struct SymbolTable SymbolTable;
typedef struct SymbolTableEntry SymbolTableEntry;
typedef struct SymbolTableLevel SymbolTableLevel;
typedef struct TypeDescriptor TypeDescriptor;
typedef struct StructMember StructMember;
typedef struct StructDescriptor StructDescriptor;
typedef struct StructDescriptorTable StructDescriptorTable;
typedef enum SYMBOL_TYPE SYMBOL_TYPE;

/*========================================================================== FUNCTION DECLARATION ===============================================================*/

void CreateSymbolTable();
void ReleaseSymbolTable();
void CreateSymbolTableLevel();
void ReleaseSymbolTableLevel();
void AddParamToSymbolTable(TypeDescriptor, char*, SYMBOL_TYPE);
void AddIDListToSymbolTable(TypeDescriptor, ID_List*, SYMBOL_TYPE);
TypeDescriptor FindSymbolInTable(char*, SYMBOL_TYPE);
SymbolTableEntry* GetTableEntry(char*);
void initial();
void MakeDependency(Operation*, Operation*, DEP_TYPE, unsigned long long int);
PROGRAM* CreateProgram(FUNCTION*, FUNCTION*);
void ReleaseOP(Operation*);
Operation* CreateOP(OP_KIND);
Operation* CreateOPWithDataHazard(OP_KIND, OP_List*, OP_List*);
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
OP_List* CreateEmptyOPList(OP_List*, TypeDescriptor, SymbolTableEntry*);
Declarator* CreateDeclarator(char*, Param_List*);
Declarator* AddToDeclarator(Declarator*, Param_List*);
char* GetNameInDeclarator(Declarator*);
Declaration* AddDeclaration(Declaration*, Declaration*);
Declaration* MakeDeclaration(ID_List*, OP_List*);
Identifier* CreateIdentifier(char*, OP_List*);
ID_List* CreateIDList(Identifier*);
ID_List* AddToIDList(ID_List*, ID_List*);
TypeDescriptor MixType(TypeDescriptor, TypeDescriptor);
Parameter* CreateParameter(TypeDescriptor, char*);
Param_List* CreateParamList(Parameter*);
Param_List* AddToParamList(Param_List*, Param_List*);
StructMember* CreateStructMember(TypeDescriptor, char*);
StructDescriptor* AddToStructDescriptor(StructDescriptor*, StructMember*);
void AddToStructDescriptorTable(StructDescriptor*, char*);
StructDescriptor* FindInStructTable(char*);
TypeDescriptor CreateTypeDescriptor(OP_TYPE, StructDescriptor*);
StructDescriptor* CreateStructDescriptor(TypeDescriptor, ID_List*);
StructDescriptor* MergeStructDescriptor(StructDescriptor*, StructDescriptor*);
TypeDescriptor GetTypeInStructDescriptor(StructDescriptor*, char*);
void ReleaseStructTable();
void ReleaseStructDescriptor(StructDescriptor*);
SymbolTableEntry* CreateSymbolTableEntry(TypeDescriptor, char*, SYMBOL_TYPE, Operation*);
SymbolTableEntry* GetStructMemberInSymbolEntry(SymbolTableEntry*, char*);

/*========================================================================== GLOBAL VARIABLE DEFINITION ===============================================================*/

StructDescriptorTable* structTable;
SymbolTable* symTable;
PROGRAM* prog;

/*========================================================================== DATA STRUCTURE DEFINITION ===============================================================*/

enum OP_TYPE
{
    NONE_TYPE = 0,
    STRUCT_TYPE,
    UNION_TYPE,
    BOOL_TYPE = 0x1000,
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
    FLOAT_TYPE = 0x10000,
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

struct TypeDescriptor
{
    OP_TYPE type;
    StructDescriptor* struct_desc;
};

enum SYMBOL_TYPE
{
    SYMBOL_IDENTIFIER = 0,
    SYMBOL_TYPENAME
};

struct StructMember
{
    TypeDescriptor type_desc;
    char* name;
    StructMember* next;
};

struct StructDescriptor
{
    char* name;
    StructMember* member_head;
    StructMember* member_tail;
    StructDescriptor* next;

};

struct StructDescriptorTable
{
    StructDescriptor* desc_head;
    StructDescriptor* desc_tail;
};

struct SymbolTableEntry
{
    TypeDescriptor type_desc;
    char* sym_name;
    SYMBOL_TYPE sym_type;
    SymbolTableEntry* next;
    Operation* op;

    /* for struct */
    SymbolTableEntry* subEntry_head;
    SymbolTableEntry* subEntry_tail;
};

struct SymbolTable
{
    SymbolTableLevel* level_head;
    SymbolTableLevel* level_tail;
};

struct SymbolTableLevel
{
    SymbolTableLevel* prev;
    SymbolTableLevel* next;
    SymbolTableEntry* entry_head;
    SymbolTableEntry* entry_tail;
};

enum DEP_TYPE
{
    ISSUE_DEP = 0,
    STRUCTURAL_DEP,
    DATA_DEP_L,
    DATA_DEP_R
};

enum STMT_TYPE
{
    EXPRESSION_STMT = 0,
    SELECTION_STMT,
    ITERATION_STMT,
    IF_STMT,
    ELSE_STMT
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
    Operation* op;
    Identifier* next;
};

struct ID_List
{
    Identifier* id_head;
    Identifier* id_tail;
};

struct Parameter
{
    TypeDescriptor type_desc;
    char* name;
    Parameter* next;
};

struct Param_List
{
    Parameter* param_head;
    Parameter* param_tail;
};

/* Add post-statement operation? */
struct OP_List
{
    Operation* op_head;
    Operation* op_tail;
    OP_List* post_stmt_op_list;
    SymbolTableEntry* table_entry;
    TypeDescriptor curr_type_desc;
};

// For declarator
struct Declarator
{
    char* name;
    Param_List* Params;
};

// For declaration
struct Declaration
{
    ID_List* IDs;
    OP_List* OPs;
};

/* Add pre-statement expression? */
struct Statement
{
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

    long long number;
    DEP* issue_dep; // pointer to the stmt that current stmt need to wait becuase of issue dependency
    DEP* structural_dep; // pointer to the stmt that current stmt need to wait becuase of structural dependency
    DEP* data_dep_l; // pointer to the stmt that current stmt need to wait becuase of data dependency
    DEP* data_dep_r; // pointer to the stmt that current stmt need to wait becuase of data dependency
    Operation *next; // pointer to next stmt with ID equals to (id+1)
};

struct STMT_List
{
    Statement* stmt_head;
    Statement* stmt_tail;
};

#endif
