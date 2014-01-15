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
// ast.h
//   Base class of abstract syntax tree for schemer.
//
// Author: liangkun@outlook.com
//=============================================================================

#ifndef SCHEMER_AST_H_
#define SCHEMER_AST_H_

#include <cassert>
#include <memory>
#include <vector>

namespace schemer {

// Ast is the base class of the schemer's abstract syntax tree.
class Ast {
public:
    enum Kind {
        kTotal,
    };
    Ast(Kind type) : m_type(type), m_parent(nullptr) {}

    Kind type() const { return m_type; }
    Ast* parent() { return m_parent; }
    std::vector<std::unique_ptr<Ast>>& children() { return m_children; }
    Ast* push_back(Ast* child) {
        assert(child->parent() == nullptr);
        child->SetParent(this);
        m_children.push_back(std::unique_ptr<Ast>(child));
    }

private:
    void SetParent(Ast* parent) { m_parent = parent; }

    const Kind m_type;
    Ast* m_parent;  // does not own parent.
    std::vector<std::unique_ptr<Ast>> m_children;  // owns all the children.
};

}  // namespace schemer

#endif  // SCHEMER_AST_H_
