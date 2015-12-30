#ifndef __SYMBOL_TABLE_H__
#define __SYMBOL_TABLE_H__

#include "kernelParser.h"

typedef struct SymbolTable SymbolTable;
typedef struct SymbolTableEntry SymbolTableEntry;
typedef struct SymbolTableLevel SymbolTableLevel;
typedef enum SYMBOL_TYPE SYMBOL_TYPE;

void CreateSymbolTable();
void ReleaseSymbolTable();
void CreateSymbolTableLevel();
void ReleaseSymbolTableLevel();
void AddToSymbolTable(OP_TYPE, ID_List*, SYMBOL_TYPE);
OP_TYPE FindSymbolInTable(char*, SYMBOL_TYPE);

SymbolTable* symTable;

enum SYMBOL_TYPE
{
    SYMBOL_IDENTIFIER = 1,
    SYMBOL_TYPENAME
};

struct SymbolTableEntry
{
    OP_TYPE type;
    char* sym_name;
    SYMBOL_TYPE sym_type;
    SymbolTableEntry* next;
    Operation* OP;
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

#endif
