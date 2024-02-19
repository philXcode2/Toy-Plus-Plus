#include <bits/stdc++.h>
#include <fstream>
#include "../Includes/combined_includes.hpp"
using namespace std;

/* these are supplied by bison */
extern int yyparse();   // comes from grammar.cpp and starts the parser
extern FILE* yyin;  // this is the stdin for yyparse an is used to supply the input program file

/* these are suppied from external sources */
extern Node* root;
extern symbol_table* current_table;
extern bool compilation_successful;

/* set up files then start the compiler */
int main(int argc, char *argv[]) {
    /* set the input file and start the parser then close the file */
    // set input file
    yyin = fopen(argv[1], "r");
    if(!yyin) {
        cout << "\033[31mERROR\033[0m: cannot read file \"" << argv[1] << '\"' << endl;
        return 0;
    }

    int status_of_parser = yyparse();   // start the parser
    fclose(yyin);   // close input file

    // failed compilation
    if(status_of_parser != 0) {
        cout << "\033[31mERROR: \033[0mparser error" << endl;
        return 1;
    }
    else if(!compilation_successful) {
        cout << "\033[31mERROR\033[0m: program compilation failed" << endl;

        return 1;
    }

    /*--------------- compilation successful -------------------*/
    /* set up files */
    string output_file_name = string(argv[2]);
    
    fstream ast_file(output_file_name + ".gv", fstream::out);
    ast_file << "digraph G" << " {\nedge [dir=\"back\"]" << endl;

    fstream symbol_table_file(output_file_name + ".csv", fstream::out);
    symbol_table_file << "Name,Data Type" << endl;

    /* complete the output of the compiler and close the files */
    printAst(root->ast, ast_file);
    ast_file << "}";
    ast_file.close();

    while(current_table->parent_table != NULL) current_table = current_table->parent_table;
    printTable(current_table, symbol_table_file);
    symbol_table_file.close();

    // error in compiling dot file
    if(system(("dot -Tpdf " + output_file_name + ".gv -o " + output_file_name + ".pdf").c_str())) {
        cout << "\033[31mERROR\033[0m: dot file compilation failed" << endl;

        return 1;
    }

    cout << "\033[92mSUCCESS\033[0m: compilation complete" << endl;

    return 0;
}