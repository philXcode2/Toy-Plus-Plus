/* keep out of Soource and at top level because these are used by output of flex and bison */

#include <bits/stdc++.h>
using namespace std;

struct ast_node {
    unsigned long long id;  // id of the node
    string name;    // name of the node
    vector<ast_node*> children = vector<ast_node*> (); // children of the node

    // Constructors
    ast_node(string _name);
    ast_node(string _name, unsigned int _number_of_children, ...);
    
    // private member functions
    void addChildren(unsigned int _number_of_children, ...);
};

void printAst(ast_node* root, fstream &ast_file);