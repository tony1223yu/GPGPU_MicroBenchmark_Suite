#include <stdio.h>
#include <stdlib.h>
#include "kernelParser.h"

// use to maintain the RAW data hazard of specific identifier (store the latest operation)
void UpdateSymbolTable(OP_List* source, OP_List* update)
{
    SymbolTableEntry* tmp = source->table_entry;
    if (tmp != NULL)
    {
        tmp->op = update->op_tail;
    }
}

// use to find the dependency due to RAW data hazard of specific identifier
SymbolTableEntry* GetTableEntry(char* name)
{
    if (name != NULL)
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
                    return currEntry;
                }
                else if (cmpResult > 0)
                {
                    break;
                }
                currEntry = currEntry->next;
            }
            currLevel = currLevel->prev;
        }
    }
    return NULL;
}

TypeDescriptor FindSymbolInTable(char* name, SYMBOL_TYPE type)
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
                if (currEntry->sym_type == type)
                {
                    return currEntry->type_desc;
                }
                else
                {
                    if (type == SYMBOL_IDENTIFIER)
                        fprintf(stderr, "Symbol \'%s\' not found\n", name);
                    
                    return CreateTypeDescriptor(NONE_TYPE, NULL);
                }
            }
            else if (cmpResult > 0)
            {
                break;
            }
            currEntry = currEntry->next;
        }
        currLevel = currLevel->prev;
    }
    if (type == SYMBOL_IDENTIFIER)
        fprintf(stderr, "Symbol \'%s\' not found\n", name);
    
    return CreateTypeDescriptor(NONE_TYPE, NULL);
}

void AddIDToSymbolTable(TypeDescriptor type_desc, char* ID, SYMBOL_TYPE sym_type)
{
    SymbolTableLevel* currLevel = symTable->level_tail;
    SymbolTableEntry* tmp = (SymbolTableEntry*) malloc(sizeof(SymbolTableEntry));
    tmp->type_desc = type_desc;
    tmp->sym_name = ID;
    tmp->sym_type = sym_type;
    tmp->next = NULL;
    tmp->op = NULL;

    if (currLevel->entry_head == NULL)
    {
        currLevel->entry_head = tmp;
        currLevel->entry_tail = tmp;
    }
    else
    {
        int cmp_result;
        SymbolTableEntry *prev = NULL;
        SymbolTableEntry *iterEntry = currLevel->entry_head;
        while(1)
        {
            if (!iterEntry) // to the end
            {
                prev->next = tmp;
                currLevel->entry_tail = tmp;
                break;
            }

            cmp_result = strcmp(iterEntry->sym_name, tmp->sym_name);
            if (cmp_result > 0)
            {
                if (prev)
                    prev->next = tmp;
                tmp->next = iterEntry;
                if (currLevel->entry_head == iterEntry)
                    currLevel->entry_head = tmp;
                return;
            }
            else if (cmp_result == 0)
            {
                fprintf(stderr, "Redefine symbol \'%s\'. \n", tmp->sym_name);
                return;
            }
            else
            {
                prev = iterEntry;
                iterEntry = iterEntry->next;
            }
        }
    }
}
// Add to the last level in symTable
void AddIDListToSymbolTable(TypeDescriptor type_desc, ID_List* IDs, SYMBOL_TYPE sym_type)
{
    Identifier* iter = IDs->id_head;
    SymbolTableLevel* currLevel = symTable->level_tail;

    while (iter)
    {
        SymbolTableEntry* tmp = (SymbolTableEntry*) malloc(sizeof(SymbolTableEntry));
        tmp->type_desc = type_desc;
        tmp->sym_name = iter->name;
        tmp->sym_type = sym_type;
        tmp->next = NULL;
        tmp->op = iter->op;

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
                    break;
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

void CreateSymbolTable()
{
    if (symTable != NULL)
    {
        fprintf(stderr, "Symbol Table has already been created\n");
        return;
    }
    symTable = (SymbolTable*) malloc(sizeof(SymbolTable));
    symTable->level_head = NULL;
    symTable->level_tail = NULL;
}

void ReleaseSymbolTable()
{
    if (symTable->level_head != NULL)
    {
        fprintf(stderr, "Need to release all the levels first\n");
        return;
    }
    free (symTable);
}

void ReleaseSymbolTableLevel()
{
    if (!symTable)
        fprintf(stderr, "Need to create symbol table first\n");
    else
    {
        SymbolTableLevel *tmp = symTable->level_tail;
        SymbolTableEntry *iter = tmp->entry_head;
        SymbolTableEntry *next;
        symTable->level_tail = symTable->level_tail->prev;

        if (symTable->level_tail == NULL)
            symTable->level_head = NULL;

        while (iter)
        {
            next = iter->next;
            free(iter->sym_name);
            free(iter);
            iter = next;
        }
        free (tmp);
    }
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

