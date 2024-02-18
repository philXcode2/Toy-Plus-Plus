#include<bits/stdc++.h>
#include "../Includes/symbol_table.hpp"

bool symbol_table::find(string variable) {
    return this->table.count(variable) == 1;
}

string typeToString(DATA_TYPE type) {
    switch(type) {
        case DATA_TYPE::_INT: return string("INT");
        case DATA_TYPE::_FLOAT: return string("FLOAT");
        case DATA_TYPE::_VOID: return string("VOID");
        case DATA_TYPE::_FUNCTION: return string("FUNCTION");
        case DATA_TYPE::_NONE: return string("NONE");
        case DATA_TYPE::_VARIABLE: return string("VARIABLE");
    }
    return string("");
}

void printTable(symbol_table* table, fstream &table_file) {
    if(table == NULL) return;

    for(auto &table_entry: table->table) {
        table_file << table_entry.first << "," << typeToString(table_entry.second) << endl;
    }

    for(auto &child_table: table->children_tables) {
        printTable(child_table, table_file);
    }

    return;
}