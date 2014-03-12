type id = string

type binop = Plus | Minus | Times | Div

type stm =
    AssignStm of id * exp
  | PrintStm of exp 

and exp =
    IdExp of id
  | NumExp of int
  | OpExp of exp * binop * exp

module Env : Map.S with type key = id

val empty : int Env.t

val interpStm : stm list -> int Env.t -> int Env.t

val interpExp : exp -> int Env.t -> int
