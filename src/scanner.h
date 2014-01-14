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
// scanner.h
//   Lexical scanner for schemer language.
//
// Author: liangkun@outlook.com
//=============================================================================

#ifndef SCHEMER_SCANNER_H_
#define SCHEMER_SCANNER_H_

#ifndef yyFlexLexerOnce
#include <FlexLexer.h>
#endif

#include "parser.hh"

namespace schemer {

class Scanner : public yyFlexLexer {
public:
    Scanner(std::istream *in) : yyFlexLexer(in) {}
    Parser::symbol_type yylex(int);

private:
    int yylex();

    Parser::location_type m_loc;
};

}  // namespace schemer

#endif  // SCHEMER_SCANNER_H_
