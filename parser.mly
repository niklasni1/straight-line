%{
  module I = Interpreter
%}

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
%token SEMICOLON
%token EOF

(* 'Interpreter' can't be abbreviated as our module definition above will *)
(* not show up in the generated mli file. *)
%start <Interpreter.stm list option> prog

%type <I.exp> expr
%type <I.stm> stmt

%%

prog:
  | s = stmts; EOF { Some s }
  | EOF { None };

stmts:
  | { [] }
  | s = stmt; ss = stmts { s::ss }

stmt:
  | SET; i = ID; e = expr; SEMICOLON
    { I.AssignStm (i,e) }
  | PRINT; e = expr; SEMICOLON
    { I.PrintStm e }

expr:
  | n = NUM
    { I.NumExp n }
  | i = ID
    { I.IdExp i }
  | OPEN; e1 = expr; PLUS; e2 = expr; CLOSE
    { I.OpExp (e1, I.Plus, e2) }
  | OPEN; e1 = expr; MINUS; e2 = expr; CLOSE
    { I.OpExp (e1, I.Minus, e2) }
  | OPEN; e1 = expr; TIMES; e2 = expr; CLOSE
    { I.OpExp (e1, I.Times, e2) }
  | OPEN; e1 = expr; DIV; e2 = expr; CLOSE
    { I.OpExp (e1, I.Div, e2) };


