%code requires {
//=============================================================================
// Copyright (c) 2014 Liang Kun.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
// schemer.y
//   Syntax parser for schemer language.
//
// Author: liangkun@outlook.com
//=============================================================================

namespace schemer {
    class Scanner;
}  // namespace schemer

}  /* %code requires */

%skeleton "lalr1.cc"
%require "3.0"
%define api.namespace { schemer }
%define parser_class_name { Parser }
%define api.token.constructor
%define api.value.type variant
%define parse.assert
%defines
%locations
%lex-param { Scanner* scanner }
%parse-param { Scanner* scanner }

%code {
#include <string>
#include "ast.h"

namespace schemer {

static Parser::symbol_type yylex(Scanner* scanner);

}  // namespace schemer
}  /* %code */

/* token definitions */
%token kAnonymouse "_"
%token kCase "case"
%token kColon ":"
%token kData "data(keyword)"
%token <std::string> kError "lexing error"
%token kEnd 0 "end of input stream"
%token kFalse "false"
%token <std::string> kFloatLiteral "float"
%token <std::string> kIdentifier "identifier"
%token <std::string> kIntegerLiteral "integer"
%token kLambda "lambda"
%token kReset "reset"
%token kShift "shift"
%token kTrue "true"

%printer { yyoutput << $$; } <*>

%%

expr_list: /* empty */
;

%%

#include "scanner.h"
namespace schemer {

Parser::symbol_type yylex(Scanner* scanner) {
    return scanner->yylex(0);
}

}  // namespace schemer
