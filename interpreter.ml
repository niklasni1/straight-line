type id = string

type binop  = Plus | Minus | Times | Div

type stm = CompoundStm of stm * stm
         | AssignStm of id * exp
         | PrintStm of exp list

 and exp = IdExp of id
         | NumExp of int
         | OpExp of exp * binop * exp

module Id =
  struct
    type t = id
    let compare = compare
  end

module Env = Map.Make (Id)

let rec interpStm s env =
  match s with
  | CompoundStm (s1,s2) -> interpStm s2 (interpStm s1 env)
  | AssignStm (id,exp) -> Env.add id (interpExp exp env) env
  | PrintStm es -> match es with
                   | [] -> env
                   | e::tl -> print_int (interpExp e env); interpStm (PrintStm tl) env

and interpExp exp env =
  match exp with
  | IdExp id -> Env.find id env
  | NumExp n -> n
  | OpExp (e1, op, e2) -> match op with
                          | Plus -> (interpExp e1 env) + (interpExp e2 env)
                          | Minus -> (interpExp e1 env) - (interpExp e2 env)
                          | Times -> (interpExp e1 env) * (interpExp e2 env)
                          | Div -> (interpExp e1 env) / (interpExp e2 env)
;;

let prog = CompoundStm(AssignStm("a", NumExp 3), PrintStm[IdExp "a"])

let e = interpStm prog Env.empty
