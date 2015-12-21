#ifndef __SYMBOL_TABLE_H__
#define __SYMBOL_TABLE_H__

#include "kernelParser.h"

typedef struct SymbolTable SymbolTable;
typedef struct SymbolTableEntry SymbolTableEntry;
typedef struct SymbolTableLevel SymbolTableLevel;
typedef enum SYMBOL_TYPE SYMBOL_TYPE;

SymbolTable* CreateSymbolTable();
void CreateSymbolTableLevel();
void AddToSymbolTable(OP_TYPE, ID_List*);
OP_TYPE FindSymbolInTable(char*);

SymbolTable* symTable;

enum SYMBOL_TYPE
{
    identifier_name = 0,
    type_name
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

OP_TYPE FindSymbolInTable(char* name)
{
    SymbolTableLevel* currLevel = symTable->level_tail;
    int cmpResult;
    while (currLevel)
    {
        SymbolTableEntry* currEntry = currLevel->entry_head;
        while (currEntry)
        {
            cmpResult = strcmp(currEntry->sym_name, name);
            if (cmpResult == 0)
            {
                return currEntry->type;
            }
            else if (cmpResult > 0)
            {
                break;
            }
            currEntry = currEntry->next;
        }
        currLevel = currLevel->prev;
    }
    fprintf(stderr, "Symbol \'%s\' not found\n", name);
    return NONE_TYPE;
}

// Add to the last level in symTable
void AddToSymbolTable(OP_TYPE type, ID_List* IDs)
{
    Identifier* iter = IDs->id_head;
    SymbolTableLevel* currLevel = symTable->level_tail;

    while (iter)
    {
        SymbolTableEntry* tmp = (SymbolTableEntry*) malloc(sizeof(SymbolTableEntry));
        tmp->type = type;
        tmp->sym_name = iter->name;
        tmp->next = NULL;
        tmp->OP = NULL;

        if (currLevel->entry_head == NULL)
        {
            currLevel->entry_head = tmp;
            currLevel->entry_tail = tmp;
        }
        else
        {
            int cmp_result;
            SymbolTableEntry *prev;
            SymbolTableEntry *iterEntry = currLevel->entry_head;
            while(1)
            {
                if (!iterEntry) // to the end
                {
                    prev->next = tmp;
                    currLevel->entry_tail = prev;
                    break;
                }
                
                cmp_result = strcmp(iterEntry->sym_name, tmp->sym_name);
                if (cmp_result > 0)
                {
                    prev->next = tmp;
                    tmp->next = iterEntry;
                    break;
                }
                else if (cmp_result == 0)
                {
                    fprintf(stderr, "Redefine symbol \'%s\'. \n", tmp->sym_name);
                }
                else
                {
                    prev = iterEntry;
                    iterEntry = iterEntry->next;
                }
            }
        }

        iter = iter->next;
    }
}

SymbolTable* CreateSymbolTable()
{
    SymbolTable* tmp = (SymbolTable*) malloc(sizeof(SymbolTable));
    tmp->level_head = NULL;
    tmp->level_tail = NULL;
    return tmp;
}

void CreateSymbolTableLevel()
{
    if (!symTable)
        fprintf(stderr, "Need to create symbol table first\n");
    else
    {
        SymbolTableLevel *tmp = (SymbolTableLevel *)malloc(sizeof(SymbolTableLevel));
        tmp->prev = NULL;
        tmp->next = NULL;
        tmp->entry_head = NULL;
        tmp->entry_tail = NULL;

        if (!symTable->level_head)
        {
            symTable->level_head = tmp;
            symTable->level_tail = tmp;
        }
        else
        {
            tmp->prev = symTable->level_tail;
            symTable->level_tail->next = tmp;
            symTable->level_tail = tmp;
        }
    }
}

#endif
