%token <int> NUM
%token <string> ID
%token OPEN
%token CLOSE
%token PLUS
%token MINUS
%token TIMES
%token DIV
%token PRINT
%token SET
%token NEWLINE
%token EOF

%start <stm option> prog

%%

prog:
  | s = stmt; EOF { Some s }
  | EOF { None };

stmt:
  | SET; i = ID; e = expr; NEWLINE
    { `AssignStm (i,e) }
  | PRINT; e = expr; NEWLINE
    { `PrintStm e }
  | s1 = stmt; NEWLINE; s2 = stmt; NEWLINE
    { `CompoundStm (s1,s2) };

expr:
  | n = NUM
    { `NumExp n }
  | i = ID
    { `IdExp i }
  | OPEN; e1 = expr; PLUS; e2 = expr; CLOSE
    { `OpExp (e1, Plus, e2) }
  | OPEN; e1 = expr; MINUS; e2 = expr; CLOSE
    { `OpExp (e1, Minus, e2) }
  | OPEN; e1 = expr; TIMES; e2 = expr; CLOSE
    { `OpExp (e1, Times, e2) }
  | OPEN; e1 = expr; DIV; e2 = expr; CLOSE
    { `OpExp (e1, Div, e2) };


