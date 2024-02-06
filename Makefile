all:
	bison -ydvt ./Source/grammar.y -o ./Output_Flex_Bison/grammar.cpp
	flex -o ./Output_Flex_Bison/lexer.cpp ./Source/lexer.l
	g++ ./Source/external_main.cpp ./Output_Flex_Bison/lexer.cpp ./Output_Flex_Bison/grammar.cpp ./Source/ast.cpp -lfl -o ./Binaries/compiler

source_code_flow:
	dot -Tpdf ./Source/program.dot -o ./Source/program.pdf

test:
	./Binaries/compiler Test_Programs/simple.tpp Compiler_Output/simple
	dot -Tpdf ./Compiler_Output/simple.dot -o ./Compiler_Output/simple.pdf

clean:
	rm ./Output_Flex_Bison/*
	rm ./Binaries/*
	rm ./Compiler_Output/*