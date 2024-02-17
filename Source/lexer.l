/* give aliases to letters and alphabets */
D [0-9]
L [a-zA-Z_]

%{
  /*
  no space before token description
  put space before comment in lexer words to push it in c++ code instead of flex code
  keep include files before grammar.h since they are included in the grammar.h as well
  */

  // set up the stage before writing tokens
  #include <bits/stdc++.h>
  #include "../Includes/combined_includes.hpp"  // this needs to be before grammar.h since grammar.h contains Node in it  
  
  int line_number = 1;
  
  #include "grammar.h"
  using namespace std;
%}

/* describe the tokens */
%%
 /* keywords */
"fn" {
    yylval.node = new Node();
    yylval.node->ast = new ast_node("fn");
    yylval.node->type = DATA_TYPE::_FUNCTION;
    return(FUNCTION);
  }

"int" {
    yylval.node = new Node();
    yylval.node->ast = new ast_node("int");
    yylval.node->type = DATA_TYPE::_INT;
    return(INT);
  }

"float" {
    yylval.node = new Node();
    yylval.node->ast = new ast_node("float");
    yylval.node->type = DATA_TYPE::_FLOAT;
    return(FLOAT);
  }

"void" {
    yylval.node = new Node();
    yylval.node->ast = new ast_node("void");
    yylval.node->type = DATA_TYPE::_VOID;
    return(VOID);
  }

"return" {
    yylval.node = new Node();
    yylval.node->ast = new ast_node("return");
    yylval.node->type = DATA_TYPE::_NONE;
    return(RETURN);
  }

 /* brackets */
"(" {
    yylval.node = new Node();
    yylval.node->ast = new ast_node("(");
    yylval.node->type = DATA_TYPE::_NONE;
    return('(');
  }

")" {
    yylval.node = new Node();
    yylval.node->ast = new ast_node(")");
    yylval.node->type = DATA_TYPE::_NONE;
    return(')');
  }

"{" {
    yylval.node = new Node();
    yylval.node->ast = new ast_node("{");
    yylval.node->type = DATA_TYPE::_NONE;
    return('{');
  }

"}" {
    yylval.node = new Node();
    yylval.node->ast = new ast_node("}");
    yylval.node->type = DATA_TYPE::_NONE;
    return('}');
  }

 /* mathematical symbols */
"+" {
    yylval.node = new Node();
    yylval.node->ast = new ast_node("+");
    yylval.node->type = DATA_TYPE::_NONE;
    return('+');
  }

"-" {
    yylval.node = new Node();
    yylval.node->ast = new ast_node("-");
    yylval.node->type = DATA_TYPE::_NONE;
    return('-');
  }

"*" {
    yylval.node = new Node();
    yylval.node->ast = new ast_node("*");
    yylval.node->type = DATA_TYPE::_NONE;
    return('*');
  }

"/" {
    yylval.node = new Node();
    yylval.node->ast = new ast_node("/");
    yylval.node->type = DATA_TYPE::_NONE;
    return('/');
  }

"=" {
    yylval.node = new Node();
    yylval.node->ast = new ast_node("=");
    yylval.node->type = DATA_TYPE::_NONE;
    return('=');
  }

 /* seperators */
";" {
    yylval.node = new Node();
    yylval.node->ast = new ast_node(";");
    yylval.node->type = DATA_TYPE::_NONE;
    return(';');
  }

"," {
    yylval.node = new Node();
    yylval.node->ast = new ast_node(",");
    yylval.node->type = DATA_TYPE::_NONE;
    return(',');
  }

 /* variables */
{L}({L}|{D})* {
    yylval.node = new Node();
    yylval.node->ast = new ast_node(string(yytext));
    yylval.node->type = DATA_TYPE::_VARIABLE;
    return(VALUE);
  }

 /* numbers */
{D}* {
    //p cout << "int: " << string(yytext) << endl;
    yylval.node = new Node();
    yylval.node->ast = new ast_node(string(yytext));
    yylval.node->type = DATA_TYPE::_INT;
    return(VALUE);
  }

{D}*[.]{D}* {
    //p cout << "float: " << string(yytext) << endl;
    yylval.node = new Node();
    yylval.node->ast = new ast_node(string(yytext));
    yylval.node->type = DATA_TYPE::_FLOAT;
    return(VALUE);
  }

 /* ignored characters */
[ ] {}
[\t] {}
[\n] {line_number++;}
. {}
%%

/* function marks the end of lexer */
int yywrap() {return 1;}

/* set up files then start the compiler */
// int main(int argc, char *argv[]) {
//   // set up files

//   // start the parser
//   int status = yyparse();

//   return status;
// }
