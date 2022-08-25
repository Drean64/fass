grammar fass;

program:
	(statement? EOL)* // optional statements ending in newlines
	statement? // optional last line with no newline
	EOF;

label: IDENTIFIER ':';

// --> Statements
statement:
	address_stmt
	| remote_label_stmt
	| filler_stmt
	| const_stmt
	| data_stmt
	| flag_set_stmt
	| stack_stmt
	| goto_stmt
	// | if_then_stmt
	| label statement?;

// single_stmt: data_stmt | flag_set_stmt | stack_stmt;

address: decimal | hexadecimal;

address_stmt: ADDRESS_KWD address;

remote_label_stmt: IDENTIFIER 'at' address;

filler_stmt: FILLER_KWD value | FILLER_KWD DEFAULT_KWD;

const_stmt: CONST_KWD const_name = IDENTIFIER '=' value;

data_stmt: DATA_KWD ( datas += value ','?)+;

// if_then_stmt: IF_KWD condition THEN_KWD single_stmt (ELSE_KWD single_stmt)?;

// condition: ZERO | NOT ZERO | POSITIVE | NEGATIVE | CARRY | NOT CARRY | OVERFLOW | NOT OVERFLOW;
flag_set_stmt:
	(CARRY | OVERFLOW) '=' one_zero = decimal
	| (INTERRUPT | DECIMAL_MODE) (ON | OFF);

stack_stmt:
	A '=' PULL_KWD
	| PUSH_KWD A
	| FLAGS_KWD '=' PULL_KWD
	| PUSH_KWD FLAGS_KWD;

goto_stmt: GOTO_KWD reference;

// --> References

reference:
	direct
	| indirect; // | indexed_x | indexed_y | indirect_y | x_indirect

direct: IDENTIFIER;
indirect: '(' IDENTIFIER ')';

// --> Values

value: literal | constant;
constant: IDENTIFIER;
literal:
	hexadecimal
	| decimal
	| binary
	| negative_number
	| opcode_literal;

opcode_literal: BRK | NOP | NOP3;
hexadecimal: HEXADECIMAL;
decimal: DECIMAL;
binary: BINARY;
brk_literal: BRK;
nop_literal: NOP;
nop3_literal: NOP3;
negative_number: NEGATIVE_NUMBER;

// --> Literals
HEXADECIMAL: '$' [0-9a-fA-F]+;
BINARY: '%' [01]+;
DECIMAL: [0-9]+;
NEGATIVE_NUMBER: '-' [0-9]+;
BRK: [bB][rR][kK];
NOP: [nN][oO][pP];
NOP3: [nN][oO][pP]'3';

// --> Keywords
ADDRESS_KWD: [aA][dD][dD][rR][eE][sS][sS];
FILLER_KWD: [fF][iI][lL][lL][eE][rR];
DEFAULT_KWD: [dD][eE][fF][aA][uU][lL][tT];
DATA_KWD: [dD][aA][tT][aA];
CONST_KWD: [cC][oO][nN][sS][tT];
IF_KWD: [iI][fF];
THEN_KWD: [tT][hH][eE][nN];
ELSE_KWD: [eE][lL][sS][eE];
GOTO_KWD: [gG][oO][tT][oO];
GOSUB_KWD: [gG][oO][sS][uU][bB];
RETURN_KWD: [rR][eE][tT][uU][rR][nN];
RETINT_KWD: [rR][eE][tT][iI][nN][tT];
PUSH_KWD: [pP][uU][sS][hH];
PULL_KWD: [pP][uU][lL][lL];
FLAGS_KWD: [fF][lL][aA][gG][sS];
AND_KWD: [aA][nN][dD]'=';
OR_KWD: [oO][rR]'=';
XOR_KWD: [xX][oO][rR]'=';
BITTEST_KWD: [bB][iI][tT][tT][eE][sS][tT];
COMPARE_KWD: [cC][oO][mM][pP][aA][rR][eE];
// Keywords <--

// --> Flags
CARRY: [cC][aA][rR][rR][yY];
OVERFLOW: [oO][vV][eE][rR][fF][lL][oO][wW];
INTERRUPT: [iI][nN][tT][eE][rR][rR][uU][pP][tT];
DECIMAL_MODE: [dD][eE][cC][iI][mM][aA][lL];

NOT: [nN][oO][tT];
ZERO: [zZ][eE][rR][oO];
POSITIVE: [pP][oO][sS][iI][tT][iI][vV][eE];
NEGATIVE: [nN][eE][gG][aA][tT][iI][vV][eE];
EQUAL: [eE][qQ][uU][aA][lL];

ON: [oO][nN];
OFF: [oO][fF][fF];

// ETC -->
A: [aA];
X: [xX];
Y: [yY];
STACK: [sS][tT][aA][cC][kK];

IDENTIFIER: [_a-zA-Z] [._a-zA-Z0-9]*;
// The dot allows a dot-notation-like syntactic sugar 
WHITESPACE: [ \t]+ -> skip;
EOL: '\r'? '\n';