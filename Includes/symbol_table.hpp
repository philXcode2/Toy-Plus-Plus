#include<bits/stdc++.h>
using namespace std;

enum DATA_TYPE {
    _INT, _FLOAT, _FUNCTION, _VOID, _NONE, _VARIABLE
};

struct symbol_table {
    unordered_map<string, DATA_TYPE> table;
    symbol_table* parent_table = NULL;
    vector<symbol_table*> children_tables = vector<symbol_table*> ();

    bool find(string variable);
};

string typeToString(DATA_TYPE type);
void printTable(symbol_table* table, fstream &table_file);