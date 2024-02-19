#include<bits/stdc++.h>
#include "../Includes/symbol_table.hpp"

symbol_table::symbol_table(string _name) {
    this->name = _name;
}

bool findSymbol(symbol_table* current_table, string variable) {
    return current_table->table.count(variable) == 1;
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

void printTable(symbol_table* current_table, fstream &table_file) {
    if(current_table == NULL) return;

    table_file << "-," << current_table->name << ",-" << endl;
    for(auto &table_entry: current_table->table) {
        table_file << table_entry.first << "," << typeToString(table_entry.second) << endl;
    }
    table_file << endl;

    for(auto &child_table: current_table->children_tables) {
        printTable(child_table, table_file);
    }

    return;
}