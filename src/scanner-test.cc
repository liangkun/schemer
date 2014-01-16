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
// scanner-test.cc
//
// Author: liangkun@outlook.com
//=============================================================================

#include "scanner.h"
#include <fstream>
#include <iostream>
#include <sstream>
#include <string>
#include <gtest/gtest.h>
#include "parser.hh"

namespace {

using namespace std;
using namespace schemer;
typedef Parser::symbol_type symbol_type;
typedef Parser::token token;

TEST(ScannerTest, Identifiers) {
    istringstream ss("_ name ->");
    Scanner scanner(&ss);
    symbol_type symbol0 = scanner.yylex(0);
    ASSERT_EQ(token::kAnonymouse, symbol0.token());

    symbol_type symbol1 = scanner.yylex(0);
    ASSERT_EQ(token::kIdentifier, symbol1.token());
    ASSERT_STREQ("name", symbol1.value.as<string>().c_str());

    symbol_type symbol2 = scanner.yylex(0);
    ASSERT_EQ(token::kIdentifier, symbol2.token());
    ASSERT_STREQ("->", symbol2.value.as<string>().c_str());

    symbol_type symbol3 = scanner.yylex(0);
    ASSERT_EQ(token::kEnd, symbol3.token());
}

}  // anonymous namespace
