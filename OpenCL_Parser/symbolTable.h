#ifndef __SYMBOL_TABLE_H__
#define __SYMBOL_TABLE_H__

#include "kernelParser.h"

typedef struct SymbolTable SymbolTable;
typedef struct SymbolTableEntry SymbolTableEntry;
typedef struct SymbolTableLevel SymbolTableLevel;

SymbolTable* CreateSymbolTable();
void CreateSymbolTableLevel();
void AddSymbolEntry(OP_TYPE, char*);

SymbolTable* symTable;

struct SymbolTableEntry
{
    OP_TYPE identifier_type;
    char* identifier_name;
    SymbolTableEntry* next;
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

SymbolTable* CreateSymbolTable()
{
    SymbolTable* tmp = (SymbolTable*) malloc(sizeof(SymbolTable));
    tmp->level_head = NULL;
    tmp->level_tail = NULL;
    CreateSymbolTableLevel();
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

void AddSymbolEntry(OP_TYPE type, char* name)
{
    SymbolTableLevel* currLevel = symTable->level_tail;
    SymbolTableEntry *tmp = (SymbolTableEntry *)malloc(sizeof(SymbolTableEntry));
    tmp->identifier_type = type;
    tmp->identifier_name = name;
    tmp->next = NULL;

    if (currLevel->entry_head)
    {
        currLevel->entry_head = tmp;
        currLevel->entry_tail = tmp;
    }
    else
    {
        int cmp_result;
        SymbolTableEntry *prev;
        SymbolTableEntry *iter = currLevel->entry_head;
        while(1)
        {
            if (!iter) // to the end
            {
                prev->next = tmp;
                currLevel->entry_tail = prev;
                break;
            }
            
            cmp_result = strcmp(iter->identifier_name, tmp->identifier_name);
            if (cmp_result > 0)
            {
                prev->next = tmp;
                tmp->next = iter;
                break;
            }
            else if (cmp_result == 0)
            {
                fprintf(stderr, "Redefine symbol \'%s\'. \n", tmp->identifier_name);
            }
            else
            {
                prev = iter;
                iter = iter->next;
            }
        }
    }
}

#endif
