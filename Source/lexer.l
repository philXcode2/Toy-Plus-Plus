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
  #include "../Includes/ast.hpp"  // this needs to be before grammar.h since grammar.h contains ast_node in it
  #include "grammar.h"
  using namespace std;
%}

/* describe the tokens */
%%
 /* keywords */
"fn" {yylval.node = new ast_node("fn"); return(FUNCTION);}
"int" {yylval.node = new ast_node("int"); return(INT);}
"void" {yylval.node = new ast_node("void"); return(VOID);}
"return" {yylval.node = new ast_node("return"); return(RETURN);}

 /* brackets */
"(" {yylval.node = new ast_node("("); return('(');}
")" {yylval.node = new ast_node(")"); return(')');}
"{" {yylval.node = new ast_node("{"); return('{');}
"}" {yylval.node = new ast_node("}"); return('}');}

 /* mathematical symbols */
"+" {yylval.node = new ast_node("+"); return('+');}
"-" {yylval.node = new ast_node("-"); return('-');}
"*" {yylval.node = new ast_node("*"); return('*');}
"/" {yylval.node = new ast_node("/"); return('/');}
"=" {yylval.node = new ast_node("="); return('=');}

 /* seperators */
";" {yylval.node = new ast_node(";"); return(';');}

 /* variables */
{L}({L}|{D})* {yylval.node = new ast_node(string(yytext)); return(VALUE);}

 /* numbers */
{D}* {yylval.node = new ast_node(string(yytext)); return(VALUE);}

 /* ignored characters */
[ ] {}
[\t] {}
[\n] {}
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
