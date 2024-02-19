#include<bits/stdc++.h>
using namespace std;

enum DATA_TYPE {
    _INT, _FLOAT, _FUNCTION, _VOID, _NONE, _VARIABLE
};

struct symbol_table {
    string name;

    unordered_map<string, DATA_TYPE> table;
    symbol_table* parent_table = NULL;
    vector<symbol_table*> children_tables = vector<symbol_table*> ();

    symbol_table(string _name);
};

bool findSymbol(symbol_table* current_table, string variable);
string typeToString(DATA_TYPE type);
void printTable(symbol_table* table, fstream &table_file);