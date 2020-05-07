all:
	lex program/a.l
	bison program/a.y -vgk
	gcc a.tab.c -ll -ly -w
	./a.out test/$(test)
