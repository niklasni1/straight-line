val interpStm : stm -> Env -> Env 
val interpExp : exp -> Env -> Int 

val prog:(Lexing.lexbuf -> token) -> Lexing.lexbuf -> stm option
