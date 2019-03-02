
from sys import argv, stdout
from antlr4 import *
from fassLexer import fassLexer
from fassParser import fassParser
from fassErrorListener import fassErrorListener
from myParser import myParser

def main(argv):
	if len(argv) <= 1:
		print("Usage: py fass.py source_file.fass compiled_file")
		exit()
	
	input = FileStream(argv[1])
	print( input.strdata ) # WIP TODO For debugging only

	lexer = fassLexer( input)
	tokenStream = CommonTokenStream( lexer)
	parser = myParser( tokenStream)
	parser.addErrorListener( fassErrorListener())
	parser.program()
	print( "compiled: ", parser.get_output() ) # WIP TODO Debug only
	# listener = myListener()
	# ParseTreeWalker().walk( listener, parser )

	# WIP TODO: implement argparse
	if len(argv) >= 3:
		out = open( argv[2], "wb" )
		out.write( parser.get_output() )
		out.close()

if __name__ == '__main__':
	main(argv)