let main () =
  let lexbuf = Lexing.from_channel stdin in
  begin match Parser.prog Lexer.read lexbuf with
  | None -> ()
  | Some stm ->
    let _ = Interpreter.interpStm stm Interpreter.empty in
    print_newline ()
  end

let _ =
  main ()
