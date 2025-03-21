import java_cup.runtime.*;

%%
%class MyScanner
%cup
%unicode

%{
    private Symbol symbol(int type) {
        return new Symbol(type, yytext());
    }
%}

// Macros
FUNCT = "fonction"
TYPE = "void"|"int"
ECR = "ECRIRE"|"ecrire"|"WRITE"|"write"
LIRE = "LIRE"|"lire"|"read"|"READ"
TQ = "TANTQUE"|"tantque"
DECL = "var"|"VAR"
FDL = ";"
NOM = [A-Za-z_][A-Za-z0-9_]*
SEP = [ \t\r\n]
NUM = [0-9]+  // Define the NUM macro

// Comments
SINGLE_LINE_COMMENT = "//" [^\r\n]*
MULTI_LINE_COMMENT = "/*" ~"*/"

%%

// Operators and Punctuation
"+"     { return new Symbol(Sym.ADD, yyline+1, yycolumn+1); }
"*"     { return new Symbol(Sym.MUL, yyline+1, yycolumn+1); }
"("     { return new Symbol(Sym.PO, yyline+1, yycolumn+1); }
")"     { return new Symbol(Sym.PF, yyline+1, yycolumn+1); }
"!="    { return new Symbol(Sym.DIFF, yyline+1, yycolumn+1); }
"=="    { return new Symbol(Sym.EGAL, yyline+1, yycolumn+1); }
"<"     { return new Symbol(Sym.INF, yyline+1, yycolumn+1); }
"<="    { return new Symbol(Sym.INFE, yyline+1, yycolumn+1); }
">"     { return new Symbol(Sym.SUP, yyline+1, yycolumn+1); }
">="    { return new Symbol(Sym.SUPE, yyline+1, yycolumn+1); }
"/"     { return new Symbol(Sym.DIV, yyline+1, yycolumn+1); }
"-"     { return new Symbol(Sym.SUB, yyline+1, yycolumn+1); }
"{"     { return new Symbol(Sym.DEBUT, yyline+1, yycolumn+1); }
"}"     { return new Symbol(Sym.FIN, yyline+1, yycolumn+1); }
"="     { return new Symbol(Sym.AFF, yyline+1, yycolumn+1); }
","     { return new Symbol(Sym.VIRG, yyline+1, yycolumn+1); }
{FDL}   { return new Symbol(Sym.FDL, yyline+1, yycolumn+1); }

// Keywords
"lire"  { return new Symbol(Sym.LIRE, yyline+1, yycolumn+1); }
"ecrire" { return new Symbol(Sym.ECR, yyline+1, yycolumn+1); }
"if"    { return new Symbol(Sym.SI, yyline+1, yycolumn+1); }
"else"  { return new Symbol(Sym.SINON, yyline+1, yycolumn+1); }
"while" { return new Symbol(Sym.TQ, yyline+1, yycolumn+1); }
"return" { return new Symbol(Sym.RET, yyline+1, yycolumn+1); }

// Macros (TYPE, FUNCT, DECL, etc.)
{FUNCT} { return new Symbol(Sym.FUNCT, yyline+1, yycolumn+1); }
{TYPE}  { return new Symbol(Sym.TYPE, yyline+1, yycolumn+1); }
{DECL}  { return new Symbol(Sym.DECL, yyline+1, yycolumn+1); }

// Identifiers and Numbers
{NOM}   { return new Symbol(Sym.NOM, yyline+1, yycolumn+1, yytext()); }
{NUM}   { return new Symbol(Sym.NUM, yyline+1, yycolumn+1, Integer.parseInt(yytext())); }

// Whitespace (ignore but track position)
{SEP}   { /* Ignore separators */ }

// Comments (ignore)
{SINGLE_LINE_COMMENT} { /* Ignore single-line comments */ }
{MULTI_LINE_COMMENT}  { /* Ignore multi-line comments */ }

// Error handling
[^]     {
          System.err.printf("Error at line %d, column %d: Unexpected character '%s'%n",
                            yyline+1, yycolumn+1, yytext());
          return new Symbol(Sym.error, yyline+1, yycolumn+1);
        }