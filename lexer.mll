{
open Lexing
open Parser

exception SyntaxError of string

}

let int = ['0'-'9']+
let id = ['a'-'z']+
let white = [' ' '\t' '\n' '\r']

rule read =
  parse
  | white { read lexbuf }
  | int { NUM (int_of_string (Lexing.lexeme lexbuf)) }
  | "print" { PRINT }
  | "set" { SET }
  | id { ID (Lexing.lexeme lexbuf) }
  | '(' { OPEN }
  | ')' { CLOSE }
  | '+' { PLUS }
  | '-' { MINUS }
  | '/' { DIV }
  | '*' { TIMES }
  | ';' { SEMICOLON }
  | _ { raise (SyntaxError ("Unexpected char: " ^ Lexing.lexeme lexbuf)) }
  | eof { EOF }

