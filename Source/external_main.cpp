#include <bits/stdc++.h>
#include "../Includes/ast.hpp"
using namespace std;

/* these are supplied by bison */
extern int yyparse();   // comes from grammar.cpp and starts the parser
extern FILE* yyin;  // this is the stdin for yyparse an is used to supply the input program file

/* these are suppied from external sources */
extern ast_node* root;

/* set up files then start the compiler */
int main(int argc, char *argv[]) {
    /* set up files */
    string output_file_name = string(argv[2]);
    fstream ast_file(output_file_name + ".dot", fstream::out);
    // find the base name of file and write to dot file
    ast_file << "digraph G" << " {\nedge [dir=\"back\"]" << endl;

    /* set the input file and start the parser then close the file */
    // set input file
    yyin = fopen(argv[1], "r");
    if(!yyin) {
        cout << "\033[31mERROR\033[0m: cannot read file \"" << argv[1] << '\"' << endl;
        return 0;
    }

    int status_of_parser = yyparse();   // start the parser
    fclose(yyin);   // close input file

    /* complete the output of the compiler and close the files */
    printAst(root, ast_file);
    ast_file << "}";
    ast_file.close();
    cout << "\033[92mSUCCESS\033[0m: compilation complete" << endl;

    return 0;
}