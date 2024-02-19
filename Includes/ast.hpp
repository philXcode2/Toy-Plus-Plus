/*  keep out of Source and at top level because these are used by output of flex and bison.
    fucntions are kept out of structs because each struct will also take memory of function during initialization which increases the memory program takes.
    fucntions outside of struct keeps memory low as their only single copies are made unlike struct function.
*/

#include <bits/stdc++.h>
using namespace std;

struct ast_node {
    unsigned long long id;  // id of the node
    string name;    // name of the node
    vector<ast_node*> children = vector<ast_node*> (); // children of the node

    // Constructors
    ast_node(string _name);
    ast_node(string _name, unsigned int _number_of_children, ...);
};

void addChildren(ast_node* _node, unsigned int _number_of_children, ...);
void printAst(ast_node* root, fstream &ast_file);