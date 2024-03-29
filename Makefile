all:
	bison -ydvtg ./Source/grammar.y -o ./Output_Flex_Bison/grammar.cpp
	dot -Tpdf ./Output_Flex_Bison/grammar.gv -o ./Output_Flex_Bison/grammar.pdf
	flex -o ./Output_Flex_Bison/lexer.cpp ./Source/lexer.l
	g++ ./Source/external_main.cpp ./Output_Flex_Bison/lexer.cpp ./Output_Flex_Bison/grammar.cpp ./Source/combined_includes.cpp ./Source/symbol_table.cpp ./Source/ast.cpp -lfl -o ./Binaries/compiler

source_code_flow:
	dot -Tpdf ./Source/program.gv -o ./Source/program.pdf

test:
	./Binaries/compiler Test_Programs/simple.tpp Compiler_Output/simple
#	dot -Tpdf ./Compiler_Output/simple.dot -o ./Compiler_Output/simple.pdf

clean:
	rm ./Output_Flex_Bison/*
	rm ./Binaries/*
	rm ./Compiler_Output/*