#include<bits/stdc++.h>
#include "ast.hpp"
#include "symbol_table.hpp"

struct Node {
    ast_node* ast;
    DATA_TYPE type = DATA_TYPE::_NONE;
};