all:
	lex kernelParser.l
	yacc -d kernelParser.y
	gcc kernelParser.c symbolTable.c lex.yy.c y.tab.c -o kernelParser -ll -ly
	rm lex.yy.c y.tab.c y.tab.h

clean:
	rm kernelParser
