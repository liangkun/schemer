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
blank    [ \t]
digit    [0-9]

%%

%{
// code executed on every token.
m_loc.step();
%}

"False"     { return Parser::make_kFalse(m_loc); }
"True"      { return Parser::make_kTrue(m_loc); }
"_"         { return Parser::make_kAnonymouse(m_loc); }
":"         { return Parser::make_kColon(m_loc); }
"case"      { return Parser::make_kCase(m_loc); }
"data"      { return Parser::make_kData(m_loc); }
"lambda"    { return Parser::make_kLambda(m_loc); }
"reset"     { return Parser::make_kReset(m_loc); }
"shift"     { return Parser::make_kShift(m_loc); }

 /* numbers must goes before identifier */
[+-]?{digit}+    { return Parser::make_kIntegerLiteral(yytext, m_loc); }

{alphabet}({alphabet}|{digit})*    {
    return Parser::make_kIdentifier(yytext, m_loc);
}

{blank}+    { m_loc.step(); }
[\n]+       { m_loc.lines(yyleng); m_loc.step(); }
.           { return Parser::make_kError("invalid character", m_loc); }
<<EOF>>     { return Parser::make_kEnd(m_loc); }

%%
