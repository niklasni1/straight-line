{
open Lexing
open Parser

exception SyntaxError of string

}

let int = ['0'-'9']+
let id = ['a'-'z']+
let white = [' ' '\t' ]
let newline = '\r' | '\n' | "\r\n"

rule read =
  parse
  | white { read lexbuf }
  | int { NUM (int_of_string (Lexing.lexeme lexbuf)) }
  | id { ID (Lexing.lexeme lexbuf) }
  | newline { NEWLINE }
  | '(' { OPEN }
  | ')' { CLOSE }
  | '+' { PLUS }
  | '-' { MINUS }
  | '/' { DIV }
  | '*' { TIMES }
  | "print" { PRINT }
  | "set" { SET }
  | _ { raise (SyntaxError ("Unexpected char: " ^ Lexing.lexeme lexbuf)) }
  | eof { EOF }

