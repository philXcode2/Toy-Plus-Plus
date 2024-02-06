/* _ is used in constructor names to prevent errors and cofusions later on */

#include <bits/stdc++.h>
#include "../Includes/ast.hpp"
using namespace std;

unsigned long long _id = 0;

ast_node::ast_node(string _name) {
    id = _id++;
    name = _name;
}

ast_node::ast_node(string _name, unsigned int _number_of_children, ...) {
    id = _id++;
    name = _name;

    // this variable will hold the list of children nodes 
    va_list _children;
    va_start(_children, _number_of_children);

    // this variable is used to copy the child to add to children vector
    ast_node* _child;

    for(unsigned int i = 1; i <= _number_of_children; i++) {
        // copies the child in current iteration to _child and pushes the iterator forward
        _child = va_arg(_children, ast_node*);  

        if(_child == NULL) {continue;}

        children.push_back(_child);
    }

    // free the memory allocated for va_list
    va_end(_children);
}

void ast_node::addChildren(unsigned int _number_of_children, ...) {
    // this variable will hold the list of children nodes 
    va_list _children;
    va_start(_children, _number_of_children);

    // this variable is used to copy the child to add to children vector
    ast_node* _child;

    for(unsigned int i = 1; i <= _number_of_children; i++) {
        // copies the child in current iteration to _child and pushes the iterator forward
        _child = va_arg(_children, ast_node*);  

        if(_child == NULL) {continue;}

        children.push_back(_child);
    }

    // free the memory allocated for va_list
    va_end(_children);
}

void printAst(ast_node* root, fstream &ast_file) {
    // set up this node
    ast_file << root->id << " [label=\"" << root->name << "\"]" << endl;
    
    // set up connections from children
    for(auto &child: root->children) {
        ast_file << root->id << " -> " << child->id << endl;
        printAst(child, ast_file);
    }
}