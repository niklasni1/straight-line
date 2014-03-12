type id = string

type binop  = Plus | Minus | Times | Div

type stm =  
            AssignStm of id * exp
            | PrintStm of exp 

 and exp = 
         IdExp of id
         | NumExp of int
         | OpExp of exp * binop * exp

module Id =
  struct
    type t = id
    let compare = compare
  end

module Env = Map.Make (Id)

let empty = Env.empty

let rec interpStm stm env =
  match stm with
  | [] -> env
  | s::ss -> let env = match s with
              | AssignStm (id,exp) -> Env.add id (interpExp exp env) env
              | PrintStm e -> print_int (interpExp e env); env
    in interpStm ss env 

and interpExp exp env =
  match exp with
  | IdExp id -> Env.find id env
  | NumExp n -> n
  | OpExp (e1, op, e2) -> match op with
                          | Plus -> (interpExp e1 env) + (interpExp e2 env)
                          | Minus -> (interpExp e1 env) - (interpExp e2 env)
                          | Times -> (interpExp e1 env) * (interpExp e2 env)
                          | Div -> (interpExp e1 env) / (interpExp e2 env)
