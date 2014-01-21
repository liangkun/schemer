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
//     Abstract syntax tree (node) of schemer language.
//
// Author: liangkun@outlook.com
//=============================================================================

#ifndef SCHEMER_AST_H_
#define SCHEMER_AST_H_

#include <initializer_list>
#include <memory>
#include <vector>

namespace schemer {

// Abstract syntax tree (node) of schemer language.
//
// We use "case class" to represents the syntax tree of schemer.
//
// All the ast instances are "constant" objects. Their contents are immutable
// after initialization.
//
// Each Ast has zero or one parent, zero or several children. Children asts
// are owned by their parent.
//
// Currently we only supports Integer type and following constructs:
// 1. Literal.
// 2. Identifier.
// 3. Lambda.
// 4. Application.
// 5. Sequence.
// 6. Primitive operations.

class Type;

// Base class of all the Ast case classes.
class Ast {
public:
    // This is the "kind" tag of the ast case classes, every kind should be
    // defined here.
    enum Kind {
        kLiteral,
        kIdentifier,
        kLambda,
        kApply,
        kSequence,
        kTotal,
    };

    Ast(Kind kind) : m_kind(kind) {}
    virtual ~Ast() {}

    Kind kind() const { return m_kind; }
    virtual Type* GetType() { return nullptr; }

private:
    const Kind m_kind;
};

// LiteralAst represends a literal value.
template<typename TValue>
class LiteralAst : public Ast {
public:
    typedef TValue Value;

    LiteralAst(const Value& value) : Ast(kLiteral), m_value(value) {}
    virtual ~LiteralAst() {}

    const Value& value() const { return m_value; }

private:
    const Value m_value;
};

// IdentifierAst represends an identifier reference.
template<typename TName>
class IdentifierAst : public Ast {
public:
    typedef TName Name;
    IdentifierAst(const Name& name) : Ast(kIdentifier), m_name(name) {}
    virtual ~IdentifierAst() {}

    const Name& name() const { return m_name; }

private:
    const Name m_name;
};

// LambdaAst represends an lambda expression.
class LambdaAst : public Ast {
public:
    LambdaAst(IdentifierAst* arg, Ast* body);
    LambdaAst(std::vector<IdentifierAst*> args, Ast* body);
    virtual ~LambdaAst() {}

    // accessors here

private:
    std::vector<std::unique_ptr<IdentifierAst> > m_args;
    std::unique_ptr<Ast> m_body;
};

// ApplyAst represends an apply expression.
class ApplyAst : public Ast {
public:
    ApplyAst(Ast* lambda, Ast* arg);
    ApplyAst(Ast* lambda, const std::vector<Ast*>& args);
    virtual ~ApplyAst() {}

    // accessors here

private:
    std::unique_ptr<Ast> m_lambda;
    std::vector<std::unique_ptr<Ast> > m_args;
};

// SequenceAst represends an sequence expression
class SequenceAst : public Ast {
public:
    SequenceAst(Ast* ast);
    SequenceAst(std::vector<Ast*>& ast);
    virtual ~SequenceAst() {}
    void SetChildren(const std::vector<Ast*>& asts);

private:
    std::vector<std::unique_ptr<Ast> > m_asts;
};

}  // namespace schemer

#endif  // SCHEMER_AST_H_
