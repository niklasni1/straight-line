all:
	ocamlbuild main.native && cp main.native straight-line

clean:
	rm -rf _build
