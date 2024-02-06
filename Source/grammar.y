%{
    /*
    statements are collapsed to the left side of grammar
    */

    // set up stage before writing the language grammar
    #include<bits/stdc++.h>
    #include "../Includes/ast.hpp"
    using namespace std;

    // root node to start printing the ast
    ast_node* root = new ast_node("start");

    // define yyerror here which is filled by bison later 
    int yyerror(string s);

    // define yylex here which is filled by bison later
    // define them here because they are copied later in the header
    // these funcitons are supplied to other files by grammar.h or extern keyword
    int yylex();
    int yyparse();
%}

/* name of the language */
%name toy_plus_plus

/* set the node types that the parser will use */
%union {
    ast_node* node;
}

/* declare the tokens and the which member of the union that they take */
// data types of the language
%token <node> INT FUNCTION VOID

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
        root->addChildren(1, $1);
        cout << "collapse to end_point_of_collapse\n";
    }
    ;

list_of_functions: list_of_functions function
    {
        $$ = $1;
        $$->addChildren(1, $2);
        cout << "collect in list_of_function\n";
    }

    | function
    {
        $$ = new ast_node("list_of_functions", 1, $1);
        cout << "collapse to list_of_functions\n";
    }
    ;

function: function_declaration compound_statement_with_brackets
    {
        $$ = new ast_node("function", 2, $1, $2);
        cout << "collapse to function\n";
    }
    ;

function_declaration: FUNCTION data_type arguement_list_with_brackets VALUE
    {
        $$ = new ast_node("function_declaration", 3, $1, $2, $3, $4);
        cout << "collapse to function_declaration\n";
    }
    ;

data_type: INT
    {
        $$ = $1;
        cout << "collapse to data_type\n";
    }

    | VOID
    {
        $$ = $1;
        cout << "collapse to data_type\n";
    }
    ;

arguement_list_with_brackets: arguement_list_with_brackets ')'
    {
        $$ = $1;
        $$->addChildren(1, $2);
        cout << "end collecting arguement_list_with_brackets\n";
    }

    | arguement_list_with_brackets ',' variable_declaration
    {
        $$ = $1;
        $$->addChildren(2, $2, $3);
        cout << "collect in arguement_list_with_brackets\n";
    }

    | '(' variable_declaration
    {
        $$ = new ast_node("arguement_list_with_brackets", 2, $1, $2);
        cout << "collapse to arguement_list_with_brackets\n";
    }

    | '(' ')'
    {
        $$ = new ast_node("arguement_list_with_brackets", 2, $1, $2);
        cout << "collapse empty arguement_list_with_brackets\n"
    }
    ;

variable_declaration: data_type VALUE
    {
        $$ = new ast_node("variable_declaration", 2, $1, $2);
        cout << "collapse to variable_declaration\n";
    }
    ;

compound_statement_with_brackets: compound_statement_with_brackets '}'
    {
        $$ = $1;
        $$->addChildren(1, $2);
        cout << "end collecting compound_statements_with_brackets\n";
    }

    | compound_statement_with_brackets statement_with_semicolon
    {
        $$ = $1;
        $$->addChildren(1, $2);
        cout << "collect in compound_statement_with_brackets\n";
    }

    | '{' statement_with_semicolon
    {
        $$ = new ast_node("compound_statement_with_brackets", 2, $1, $2);
        cout << "collapse to compound_statement_with_brackets\n";
    }
    ;

statement_with_semicolon: assignment_statement ';'
    {
        $$ = new ast_node("statement_with_semicolon", 2, $1, $2);
        cout << "collapse to statement_with_semicolon\n";
    }

    | additive_statement ';'
    {
        $$ = new ast_node("statement_with_semicolon", 2, $1, $2);
        cout << "collapse to statement_with_semicolon\n";
    }

    | RETURN ';'
    {
        $$ = new ast_node("statement_with_semicolon", 2, $1, $2);
        cout << "collapse return statement\n";
    }
    ;

multiplicative_statement: multiplicative_statement '*' VALUE
    {
        $$ = $1;
        $$->addChildren(2, $2, $3);
        cout << "collect multiplication\n";
    }

    | multiplicative_statement '/' VALUE
    {
        $$ = $1;
        $$->addChildren(2, $2, $3);
        cout << "collect division\n";
    }

    | VALUE
    {
        $$ = new ast_node("multiplicative_statement", 1, $1);
        cout << "collapse to multiplicative_statement\n";
    }
    ;

additive_statement: additive_statement '+' multiplicative_statement
    {
        $$ = $1;
        $$->addChildren(2, $2, $3);
        cout << "collect addition\n";
    }

    | additive_statement '-' multiplicative_statement
    {
        $$ = $1;
        $$->addChildren(2, $2, $3);
        cout << "collect subtraction\n";
    }

    | multiplicative_statement
    {
        $$ = new ast_node("additive_statement", 1, $1);
        cout << "collapse to additive_statement\n";
    }
    ;

assignment_statement: variable_declaration '=' additive_statement
    {
        $$ = new ast_node("assignment_statement", 3, $1, $2, $3);
        cout << "collapse to assignemnt_statement\n";
    }

    | VALUE '=' additive_statement
    {
        $$ = new ast_node("assignment_statement", 3, $1, $2, $3);
        cout << "collpase to assignement_statement\n";
    }
    ;    
%%
/* ending grammar of the language */

/* describe yyerror function */
int yyerror(string s) {
    cout << "\x1B[31m" << "ERROR: " << "\033[0m" << s << endl;
    return 0;
}