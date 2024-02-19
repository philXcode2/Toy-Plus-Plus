%{
    /*
        statements are collapsed to the left side of grammar
    */

    // set up stage before writing the language grammar
    #include<bits/stdc++.h>
    #include "../Includes/combined_includes.hpp"
    using namespace std;

    // root node to start printing the ast
    // any value assigning to any field of Node here causes does not name a type error
    Node* root = new Node();
    // global symbol table
    symbol_table* current_table = new symbol_table("global");
    // state of compilation
    bool compilation_successful = true;

    // line number of lexer
    extern int line_number;

    // define yyerror here which is filled by bison later 
    int yyerror(string s);

    // define yylex here which is filled by bison later
    // define them here because they are copied later in the header
    // these funcitons are supplied to other files by grammar.h or extern keyword
    int yylex();
    int yyparse();
%}

/* name of the language */
//%name toy_plus_plus

/* set the node types that the parser will use */
%union {
    Node* node;
}

/* declare the tokens and the which member of the union that they take */
// data types of the language
%token <node> INT FLOAT FUNCTION VOID

// variables and numbers in the language
%token <node> VALUE

// miscellaneous tokens in the language
%token <node> RETURN

// mathematical symbols in the language
%token <node> '+' '-' '*' '/' '=' 

// miscellaneous symbols in the language
%token <node> '(' ')' '{' '}' ';' ','

/* all the intermediate types of statements that are generated while writing the grammar */
%type <node> end_point_of_collapse list_of_functions function function_declaration arguement_list_with_brackets
%type <node> compound_statement_with_brackets data_type variable_declaration
%type <node> statement_with_semicolon assignment_statement additive_statement multiplicative_statement

// start point of grammar i.e. end point of parsing
%start end_point_of_collapse

/* write the grammar of the language*/
%%
/* end point of parsing*/
end_point_of_collapse: list_of_functions
    {
        // doing this in upper c++ code creates does not name a type error
        root->ast = new ast_node("start");
        addChildren(root->ast, 1, $1->ast);
        
        //pcout << "collapse to end_point_of_collapse\n";
    }
    ;

list_of_functions: list_of_functions function
    {
        $$ = new Node();

        // building ast
        $$->ast = $1->ast;
        addChildren($$->ast, 1, $2->ast);
        
        //pcout << "collect in list_of_function\n";
    }

    | function
    {
        $$ = new Node();

        // building ast
        $$->ast = new ast_node("list_of_functions", 1, $1->ast);
        
        //pcout << "collapse to list_of_functions\n";
    }
    ;

function: function_declaration compound_statement_with_brackets
    {
        $$ = new Node();

        // building ast
        $$->ast = new ast_node("function", 2, $1->ast, $2->ast);
        
        //pcout << "collapse to function\n";
    }
    ;

function_declaration: FUNCTION data_type arguement_list_with_brackets VALUE
    {
        $$ = new Node();

        // building ast
        $$->ast = new ast_node("function_declaration", 3, $1->ast, $2->ast, $3->ast, $4->ast);
        
        // type checking
        if(findSymbol(current_table->parent_table, $4->ast->name)) {
            cout << "\033[31mERROR line \033[34m" << line_number << "\033[0m: this variable already exist with another type." << endl;
            compilation_successful = false;
        }
        else {
            current_table->name = $4->ast->name; // set name of the function's symbol table
            current_table->parent_table->table[$4->ast->name] = $1->type;
        }
        
        //pcout << "collapse to function_declaration\n";
    }
    ;

data_type: INT
    {
        $$ = $1;
        
        //pcout << "collapse to data_type\n";
    }

    | FLOAT
    {
        $$ = $1;
        
        //pcout << "collapse to data_type\n";
    }

    | VOID
    {
        $$ = $1;
        
        //pcout << "collapse to data_type\n";
    }
    ;

arguement_list_with_brackets: arguement_list_with_brackets ')'
    {
        $$ = $1;
        
        // building ast
        addChildren($$->ast, 1, $2->ast);

        //pcout << "end collecting arguement_list_with_brackets\n";
    }

    | arguement_list_with_brackets ',' variable_declaration
    {
        $$ = $1;

        // building ast
        addChildren($$->ast, 2, $2->ast, $3->ast);
        
        //pcout << "collect in arguement_list_with_brackets\n";
    }

    | '(' variable_declaration
    {
        $$ = new Node();

        // building ast
        $$->ast = new ast_node("arguement_list_with_brackets", 2, $1->ast, $2->ast);
        
        //pcout << "collapse to arguement_list_with_brackets\n";
    }

    | '(' ')'
    {
        $$ = new Node();

        // building ast
        $$->ast = new ast_node("arguement_list_with_brackets", 2, $1->ast, $2->ast);
        
        //pcout << "collapse empty arguement_list_with_brackets\n";
    }
    ;

variable_declaration: data_type VALUE
    {
        $$ = new Node();

        // building ast
        $$->ast = new ast_node("variable_declaration", 2, $1->ast, $2->ast);

        // type checking
        $$->type = $1->type;
        if($2->type != DATA_TYPE::_VARIABLE) {
            cout << "\033[31mERROR line \033[34m" << line_number << "\033[0m: use valid variable name." << endl;
            compilation_successful = false;
        }
        else if(findSymbol(current_table, $2->ast->name)) {
            cout << "\033[31mERROR line \033[34m" << line_number << "\033[0m: this variable already exist with another type." << endl;
            compilation_successful = false;
        }
        else {
            current_table->table[$2->ast->name] = $1->type;
            $$->type = $1->type;
        }
        
        //pcout << "collapse to variable_declaration\n";
    }
    ;

compound_statement_with_brackets: compound_statement_with_brackets '}'
    {
        $$ = $1;

        // building ast
        addChildren($$->ast, 1, $2->ast);

        // type checking
        current_table = current_table->parent_table;
        
        //pcout << "end collecting compound_statements_with_brackets\n";
    }

    | compound_statement_with_brackets statement_with_semicolon
    {
        $$ = $1;

        // building ast
        addChildren($$->ast, 1, $2->ast);
        
        //pcout << "collect in compound_statement_with_brackets\n";
    }

    | '{' statement_with_semicolon
    {
        $$ = new Node();

        // building ast
        $$->ast = new ast_node("compound_statement_with_brackets", 2, $1->ast, $2->ast);
        
        //pcout << "collapse to compound_statement_with_brackets\n";
    }
    ;

statement_with_semicolon: assignment_statement ';'
    {
        $$ = new Node();

        // building ast
        $$->ast = new ast_node("statement_with_semicolon", 2, $1->ast, $2->ast);
        
        //pcout << "collapse to statement_with_semicolon\n";
    }

    | additive_statement ';'
    {
        $$ = new Node();

        // building ast
        $$->ast = new ast_node("statement_with_semicolon", 2, $1->ast, $2->ast);
        
        //pcout << "collapse to statement_with_semicolon\n";
    }

    | RETURN ';'
    {
        $$ = new Node();

        // building ast
        $$->ast = new ast_node("statement_with_semicolon", 2, $1->ast, $2->ast);
        
        //pcout << "collapse return statement\n";
    }
    ;

multiplicative_statement: multiplicative_statement '*' VALUE
    {
        $$ = $1;

        // building ast
        addChildren($$->ast, 2, $2->ast, $3->ast);

        // type checking
        if($3->type == DATA_TYPE::_VARIABLE) {
            if(findSymbol(current_table, $1->ast->name)) {
                $$->type = current_table->table[$3->ast->name];
            }
            else {
                cout << "\033[31mERROR line \033[34m" << line_number << "\033[0m: variable \"" << $3->ast->name << "\" does not exist." << endl;
                compilation_successful = false;
            }
        }
        if($1->type != $3->type) {
            cout << "\033[31mERROR line \033[34m" << line_number << "\033[0m: type mismatch in multiplication." << endl;
            compilation_successful = false;
        }
        
        //pcout << "collect multiplication\n";
    }

    | multiplicative_statement '/' VALUE
    {
        $$ = $1;

        // building ast
        addChildren($$->ast, 2, $2->ast, $3->ast);

        // type checking
        if($3->type == DATA_TYPE::_VARIABLE) {
            if(findSymbol(current_table, $3->ast->name)) {
                $$->type = current_table->table[$3->ast->name];
            }
            else {
                cout << "\033[31mERROR line \033[34m" << line_number << "\033[0m: variable \"" << $1->ast->name << "\" does not exist." << endl;
                compilation_successful = false;
            }
        }
        if($1->type != $3->type) {
            cout << "\033[31mERROR line \033[34m" << line_number << "\033[0m: type mismatch in division." << endl;
            compilation_successful = false;
        }
        else if($3->ast->name == "0") {
            cout << "\033[31mERROR line \033[34m" << line_number << "\033[0m: divide by zero error." << endl;
            compilation_successful = false;
        }

        //pcout << "collect division\n";
    }

    | VALUE
    {
        $$ = new Node();

        // building ast
        $$->ast = new ast_node("multiplicative_statement", 1, $1->ast);

        // type checking
        // check if value is variable and exists or just pass on if it is number
        if($1->type == DATA_TYPE::_VARIABLE) {
            if(findSymbol(current_table, $1->ast->name)) {
                $$->type = current_table->table[$1->ast->name];
            }
            else {
                cout << "\033[31mERROR line \033[34m" << line_number << "\033[0m: variable \"" << $1->ast->name << "\" does not exist." << endl;
                compilation_successful = false;
            }
        }
        else {
            $$->type = $1->type;
        }

        //pcout << "collapse to multiplicative_statement\n";
    }
    ;

additive_statement: additive_statement '+' multiplicative_statement
    {
        $$ = $1;

        // building ast
        addChildren($$->ast, 2, $2->ast, $3->ast);

        // type checking
        if($1->type != $3->type) {
            cout << "\033[31mERROR line \033[34m" << line_number << "\033[0m: type mismatch in addition." << endl;
            compilation_successful = false;
        }

        //pcout << "collect addition\n";
    }

    | additive_statement '-' multiplicative_statement
    {
        $$ = $1;

        // building ast
        addChildren($$->ast, 2, $2->ast, $3->ast);

        // type checking
        if($1->type != $3->type) {
            cout << "\033[31mERROR line \033[34m" << line_number << "\033[0m: type mismatch in subtraction." << endl;
            compilation_successful = false;
        }

        //pcout << "collect subtraction\n";
    }

    | multiplicative_statement
    {
        $$ = new Node();

        // building ast
        $$->ast = new ast_node("additive_statement", 1, $1->ast);

        // type checking
        $$->type = $1->type;

        //pcout << "collapse to additive_statement\n";
    }
    ;

assignment_statement: variable_declaration '=' additive_statement
    {
        $$ = new Node();

        // building ast
        $$->ast = new ast_node("assignment_statement", 3, $1->ast, $2->ast, $3->ast);
        
        // type checking
        if($1->type != $3->type) {
            cout << "\033[31mERROR line \033[34m" << line_number << "\033[0m: type mismatch in assignment." << endl;
            compilation_successful = false;
        }
        $$->type = $3->type;
        
        //pcout << "collapse to assignemnt_statement\n";
    }

    | VALUE '=' additive_statement
    {
        $$ = new Node();

        // building ast
        $$->ast = new ast_node("assignment_statement", 3, $1->ast, $2->ast, $3->ast);
        
        // type checking
        if(!findSymbol(current_table, $1->ast->name)) {
            cout << "\033[31mERROR line \033[34m" << line_number << "\033[0m: this variable\"" << $1->ast->name << "\"does not exist." << endl;
            compilation_successful = false;
        }
        else if(current_table->table[$1->ast->name] != $3->type) {
            cout << "\033[31mERROR line \033[34m" << line_number << "\033[0m: type mismatch in assignment." << endl;
            compilation_successful = false;
        }
        $$->type = $3->type;

        //pcout << "collpase to assignement_statement\n";
    }
    ;
%%
/* ending grammar of the language */

/* describe yyerror function */
int yyerror(string s) {
    cout << "\x1B[31m" << "ERROR: " << "\033[0m" << s << endl;
    return 0;
}