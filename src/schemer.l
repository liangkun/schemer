%{
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
// schemer.l
//   Lexical scanner for schemer language.
//
// Author: liangkun@outlook.com
//=============================================================================

#include <string>
#include "scanner.h"

#undef YY_DECL
#define YY_DECL \
    schemer::Parser::symbol_type schemer::Scanner::yylex(int)

#define YY_USER_ACTION m_loc.columns(yyleng);
%}

%option debug
%option c++
%option yyclass = "Scanner"
%option nodefault
%option noyywrap

alphabet [_a-zA-Z~!%^&*+=|<>?/-]
blank [ \t]
digit [0-9]

%%

%{
m_loc.step();
%}

{alphabet}({alphabet}|{digit})*    {
    return schemer::Parser::make_IDENTIFIER(yytext, m_loc);
}

{blank}+    { m_loc.step(); }

[\n]+    { m_loc.lines(yyleng); m_loc.step(); }

.    { return schemer::Parser::make_ERROR("invalid character", m_loc); }

<<EOF>>    { return schemer::Parser::make_END(m_loc); }

%%
