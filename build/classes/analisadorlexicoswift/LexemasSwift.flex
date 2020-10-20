package analisadorlexicoswift;

import static analisadorlexicoswift.Tokens.*;
%%
%class Swift
%type Tokens

L = [a-zA-Z_]
D = [0-9]
WHITE=[ \r,]

%{
public String lexeme;
%}
%%
{WHITE} {/*Ignore*/}

/*Pular linha*/
("\n") {lexeme = yytext(); return QUEBRA_LINHA;}

/*Identação*/
("   " | "\t") {lexeme = yytext(); return IDENTACAO;}

/*Operadores aritméticos*/
("+" | "-" | "*" | "/" | "%") {lexeme = yytext(); return OPERADOR_ARITMETICO;}

/*Operadores lógicos*/
("&&" | "||" | "!a") {lexeme = yytext(); return OPERADOR_LOGICO;}

/*Operadores relacionais*/
(">" | "<" | ">=" | "<=" | "==" | "!=") {lexeme = yytext(); return OPERADOR_RELACIONAL;}

/*Operador de atribuição*/
("=" | "+=" | "-=" | "*=" | "/=") {lexeme = yytext(); return OPERADOR_ATRIBUICAO;}

/*Delimitador Aberto*/
("(" | "{") {lexeme = yytext(); return DELIMITADOR_ABERTO;}

/*Delimitador Fechado*/
(")" | "}") {lexeme = yytext(); return DELIMITADOR_FECHADO;}

/*Números inteiros*/
{D}+ {lexeme = yytext(); return NUMERO_INTEIRO;}

/*Acessor de propriedade de objeto*/
(".") {lexeme = yytext(); return ACESSOR_PROPRIEDADE;}

/*Números flutuantes*/
{D}+"."{D}* {lexeme = yytext(); return NUMERO_FLUTUANTE;}

/*Strings*/
(\"[^\n,]*\" | \'[^\n,]*\') {lexeme = yytext(); return STRING;}

/*Lista Aberta*/
("[") {lexeme = yytext(); return ABRE_ARRAY;}

/*Lista Fechada*/
("]") {lexeme = yytext(); return FECHA_ARRAY;}

/*Palavras reservadas*/
(println|var|in|let|class|case|break|as|associativity|deinit|case|dynamicType|convenience|enum|continue|dynamic|extension|default|is|didSet|func|do|nil|final|import|self|get) {lexeme = yytext(); return PALAVRA_RESERVADA;}

/*Controlador de fluxo*/
(if|switch|where|else) {lexeme = yytext(); return CONTROLADOR_FLUXO;}

/*Estrutura de repetição*/
(for|while|repeat) {lexeme = yytext(); return ESTRUTURA_REPETICAO;}

/*Inferidor de tipagem*/
(":") {lexeme = yytext(); return INFERIR_TIPO;}

/*Booleanos*/
("true", "false") {lexeme = yytext(); return BOOLEANOS;}

/*Comentários*/
("//"[^\n]*) {lexeme = yytext(); return COMENTARIO_SIMPLES;}

("/*" [^*] ~"*/" | "/*" "*"+ "/") {lexeme = yytext(); return COMENTARIO_MULTILINE;}

/*Identificador de variável*/
({L}+ | {L}+{D}+) {lexeme = yytext(); return IDENTIFICADOR;}

. {return ERROR;}