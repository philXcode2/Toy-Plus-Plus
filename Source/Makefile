all:
	bison -ydvt grammar.y -o grammar.cpp
	flex -o lexer.cpp lexer.l
	g++ external_main.cpp lexer.cpp grammar.cpp ast.cpp -lfl -o ../Binaries/lexer

test:
	../Binaries/lexer < ../Test_Programs/simple.tpp

clean:
	rm grammar.h
	rm grammar.cpp
	rm grammar.output
	rm lexer.cpp