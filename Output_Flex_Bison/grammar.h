#ifndef YY_toy_plus_plus_h_included
#define YY_toy_plus_plus_h_included
/*#define YY_USE_CLASS 
*/
#line 1 "/usr/share/bison++/bison.h"
/* before anything */
#ifdef c_plusplus
 #ifndef __cplusplus
  #define __cplusplus
 #endif
#endif


 #line 8 "/usr/share/bison++/bison.h"

#line 33 "./Source/grammar.y"
typedef union {
    Node* node;
} yy_toy_plus_plus_stype;
#define YY_toy_plus_plus_STYPE yy_toy_plus_plus_stype
#ifndef YY_USE_CLASS
#define YYSTYPE yy_toy_plus_plus_stype
#endif

#line 21 "/usr/share/bison++/bison.h"
 /* %{ and %header{ and %union, during decl */
#ifndef YY_toy_plus_plus_COMPATIBILITY
 #ifndef YY_USE_CLASS
  #define  YY_toy_plus_plus_COMPATIBILITY 1
 #else
  #define  YY_toy_plus_plus_COMPATIBILITY 0
 #endif
#endif

#if YY_toy_plus_plus_COMPATIBILITY != 0
/* backward compatibility */
 #ifdef YYLTYPE
  #ifndef YY_toy_plus_plus_LTYPE
   #define YY_toy_plus_plus_LTYPE YYLTYPE
/* WARNING obsolete !!! user defined YYLTYPE not reported into generated header */
/* use %define LTYPE */
  #endif
 #endif
/*#ifdef YYSTYPE*/
  #ifndef YY_toy_plus_plus_STYPE
   #define YY_toy_plus_plus_STYPE YYSTYPE
  /* WARNING obsolete !!! user defined YYSTYPE not reported into generated header */
   /* use %define STYPE */
  #endif
/*#endif*/
 #ifdef YYDEBUG
  #ifndef YY_toy_plus_plus_DEBUG
   #define  YY_toy_plus_plus_DEBUG YYDEBUG
   /* WARNING obsolete !!! user defined YYDEBUG not reported into generated header */
   /* use %define DEBUG */
  #endif
 #endif 
 /* use goto to be compatible */
 #ifndef YY_toy_plus_plus_USE_GOTO
  #define YY_toy_plus_plus_USE_GOTO 1
 #endif
#endif

/* use no goto to be clean in C++ */
#ifndef YY_toy_plus_plus_USE_GOTO
 #define YY_toy_plus_plus_USE_GOTO 0
#endif

#ifndef YY_toy_plus_plus_PURE

 #line 65 "/usr/share/bison++/bison.h"

#line 65 "/usr/share/bison++/bison.h"
/* YY_toy_plus_plus_PURE */
#endif


 #line 68 "/usr/share/bison++/bison.h"

#line 68 "/usr/share/bison++/bison.h"
/* prefix */

#ifndef YY_toy_plus_plus_DEBUG

 #line 71 "/usr/share/bison++/bison.h"
#define YY_toy_plus_plus_DEBUG 1

#line 71 "/usr/share/bison++/bison.h"
/* YY_toy_plus_plus_DEBUG */
#endif

#ifndef YY_toy_plus_plus_LSP_NEEDED

 #line 75 "/usr/share/bison++/bison.h"

#line 75 "/usr/share/bison++/bison.h"
 /* YY_toy_plus_plus_LSP_NEEDED*/
#endif

/* DEFAULT LTYPE*/
#ifdef YY_toy_plus_plus_LSP_NEEDED
 #ifndef YY_toy_plus_plus_LTYPE
  #ifndef BISON_YYLTYPE_ISDECLARED
   #define BISON_YYLTYPE_ISDECLARED
typedef
  struct yyltype
    {
      int timestamp;
      int first_line;
      int first_column;
      int last_line;
      int last_column;
      char *text;
   }
  yyltype;
  #endif

  #define YY_toy_plus_plus_LTYPE yyltype
 #endif
#endif

/* DEFAULT STYPE*/
#ifndef YY_toy_plus_plus_STYPE
 #define YY_toy_plus_plus_STYPE int
#endif

/* DEFAULT MISCELANEOUS */
#ifndef YY_toy_plus_plus_PARSE
 #define YY_toy_plus_plus_PARSE yyparse
#endif

#ifndef YY_toy_plus_plus_LEX
 #define YY_toy_plus_plus_LEX yylex
#endif

#ifndef YY_toy_plus_plus_LVAL
 #define YY_toy_plus_plus_LVAL yylval
#endif

#ifndef YY_toy_plus_plus_LLOC
 #define YY_toy_plus_plus_LLOC yylloc
#endif

#ifndef YY_toy_plus_plus_CHAR
 #define YY_toy_plus_plus_CHAR yychar
#endif

#ifndef YY_toy_plus_plus_NERRS
 #define YY_toy_plus_plus_NERRS yynerrs
#endif

#ifndef YY_toy_plus_plus_DEBUG_FLAG
 #define YY_toy_plus_plus_DEBUG_FLAG yydebug
#endif

#ifndef YY_toy_plus_plus_ERROR
 #define YY_toy_plus_plus_ERROR yyerror
#endif

#ifndef YY_toy_plus_plus_PARSE_PARAM
 #ifndef __STDC__
  #ifndef __cplusplus
   #ifndef YY_USE_CLASS
    #define YY_toy_plus_plus_PARSE_PARAM
    #ifndef YY_toy_plus_plus_PARSE_PARAM_DEF
     #define YY_toy_plus_plus_PARSE_PARAM_DEF
    #endif
   #endif
  #endif
 #endif
 #ifndef YY_toy_plus_plus_PARSE_PARAM
  #define YY_toy_plus_plus_PARSE_PARAM void
 #endif
#endif

/* TOKEN C */
#ifndef YY_USE_CLASS

 #ifndef YY_toy_plus_plus_PURE
  #ifndef yylval
   extern YY_toy_plus_plus_STYPE YY_toy_plus_plus_LVAL;
  #else
   #if yylval != YY_toy_plus_plus_LVAL
    extern YY_toy_plus_plus_STYPE YY_toy_plus_plus_LVAL;
   #else
    #warning "Namespace conflict, disabling some functionality (bison++ only)"
   #endif
  #endif
 #endif


 #line 169 "/usr/share/bison++/bison.h"
#define	INT	258
#define	FLOAT	259
#define	FUNCTION	260
#define	VOID	261
#define	VALUE	262
#define	RETURN	263


#line 169 "/usr/share/bison++/bison.h"
 /* #defines token */
/* after #define tokens, before const tokens S5*/
#else
 #ifndef YY_toy_plus_plus_CLASS
  #define YY_toy_plus_plus_CLASS toy_plus_plus
 #endif

 #ifndef YY_toy_plus_plus_INHERIT
  #define YY_toy_plus_plus_INHERIT
 #endif

 #ifndef YY_toy_plus_plus_MEMBERS
  #define YY_toy_plus_plus_MEMBERS 
 #endif

 #ifndef YY_toy_plus_plus_LEX_BODY
  #define YY_toy_plus_plus_LEX_BODY  
 #endif

 #ifndef YY_toy_plus_plus_ERROR_BODY
  #define YY_toy_plus_plus_ERROR_BODY  
 #endif

 #ifndef YY_toy_plus_plus_CONSTRUCTOR_PARAM
  #define YY_toy_plus_plus_CONSTRUCTOR_PARAM
 #endif
 /* choose between enum and const */
 #ifndef YY_toy_plus_plus_USE_CONST_TOKEN
  #define YY_toy_plus_plus_USE_CONST_TOKEN 0
  /* yes enum is more compatible with flex,  */
  /* so by default we use it */ 
 #endif
 #if YY_toy_plus_plus_USE_CONST_TOKEN != 0
  #ifndef YY_toy_plus_plus_ENUM_TOKEN
   #define YY_toy_plus_plus_ENUM_TOKEN yy_toy_plus_plus_enum_token
  #endif
 #endif

class YY_toy_plus_plus_CLASS YY_toy_plus_plus_INHERIT
{
public: 
 #if YY_toy_plus_plus_USE_CONST_TOKEN != 0
  /* static const int token ... */
  
 #line 212 "/usr/share/bison++/bison.h"
static const int INT;
static const int FLOAT;
static const int FUNCTION;
static const int VOID;
static const int VALUE;
static const int RETURN;


#line 212 "/usr/share/bison++/bison.h"
 /* decl const */
 #else
  enum YY_toy_plus_plus_ENUM_TOKEN { YY_toy_plus_plus_NULL_TOKEN=0
  
 #line 215 "/usr/share/bison++/bison.h"
	,INT=258
	,FLOAT=259
	,FUNCTION=260
	,VOID=261
	,VALUE=262
	,RETURN=263


#line 215 "/usr/share/bison++/bison.h"
 /* enum token */
     }; /* end of enum declaration */
 #endif
public:
 int YY_toy_plus_plus_PARSE(YY_toy_plus_plus_PARSE_PARAM);
 virtual void YY_toy_plus_plus_ERROR(char *msg) YY_toy_plus_plus_ERROR_BODY;
 #ifdef YY_toy_plus_plus_PURE
  #ifdef YY_toy_plus_plus_LSP_NEEDED
   virtual int  YY_toy_plus_plus_LEX(YY_toy_plus_plus_STYPE *YY_toy_plus_plus_LVAL,YY_toy_plus_plus_LTYPE *YY_toy_plus_plus_LLOC) YY_toy_plus_plus_LEX_BODY;
  #else
   virtual int  YY_toy_plus_plus_LEX(YY_toy_plus_plus_STYPE *YY_toy_plus_plus_LVAL) YY_toy_plus_plus_LEX_BODY;
  #endif
 #else
  virtual int YY_toy_plus_plus_LEX() YY_toy_plus_plus_LEX_BODY;
  YY_toy_plus_plus_STYPE YY_toy_plus_plus_LVAL;
  #ifdef YY_toy_plus_plus_LSP_NEEDED
   YY_toy_plus_plus_LTYPE YY_toy_plus_plus_LLOC;
  #endif
  int YY_toy_plus_plus_NERRS;
  int YY_toy_plus_plus_CHAR;
 #endif
 #if YY_toy_plus_plus_DEBUG != 0
  public:
   int YY_toy_plus_plus_DEBUG_FLAG;	/*  nonzero means print parse trace	*/
 #endif
public:
 YY_toy_plus_plus_CLASS(YY_toy_plus_plus_CONSTRUCTOR_PARAM);
public:
 YY_toy_plus_plus_MEMBERS 
};
/* other declare folow */
#endif


#if YY_toy_plus_plus_COMPATIBILITY != 0
 /* backward compatibility */
 /* Removed due to bison problems
 /#ifndef YYSTYPE
 / #define YYSTYPE YY_toy_plus_plus_STYPE
 /#endif*/

 #ifndef YYLTYPE
  #define YYLTYPE YY_toy_plus_plus_LTYPE
 #endif
 #ifndef YYDEBUG
  #ifdef YY_toy_plus_plus_DEBUG 
   #define YYDEBUG YY_toy_plus_plus_DEBUG
  #endif
 #endif

#endif
/* END */

 #line 267 "/usr/share/bison++/bison.h"
#endif
