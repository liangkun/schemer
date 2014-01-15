================
schemer
================

Introduction
================

A modern *scheme* language variant with following additional (different)
features:

    #. Algebraic data type and pattern matching.
    #. Polymorphism.
    #. Referencial transparency.
    #. Simple C-FFI.


Examples
================

There are some code snippets of schemer.

.. code-block:: scm

    ; schemer inherits a lot of things from scheme, including comments.

    ; Following defines a Tree type.
    (def Tree
        (data (element_type)
              (Leaf element_type)
              (Node (Tree element_type) (Treeelement_type))))

    ; Builtin List type.
    (def List
        (data (element_type)
              (Cons element_type (List element_type))
              Null))

    ; pattern matching
    (: height (-> (Tree t) Integer))
    (def (height (Leaf _)) 0) ; `_' means we donot care what is that.
    (def (height (Node left right))
         (+ 1 (max (height left)
                   (height right))))

    (: length (-> (List t) Integer))
    (def (length Null) 0)
    (def (length (Cons _ rest)) (+ 1 (length rest)))


Core Forms
================

Followings are the core forms of schemer.

    #. (data ...) : Create an algebric data type.
    #. (-> arg_types ... return_type) : Create a function type.
    #. (: name type) : Declare the type of a name (identifier)
    #. (lambda (pattern) body) : Create a closure.
    #. (case (test body)...) : Condition expression.
    #. (fn args ...) : Closure application.
    #. (reset ...) : reset operator in delimited continuation.
    #. (shift k body) : shift operator in delimited continuation.


Builtins
================

Followings are the schemer builtins.

Types
----------------

    #. Bool : True / False.
    #. Integer : integral numbers.
    #. Real : double of c.
    #. List[element_type] : list type.

Functions
----------------

    #. + - * / : arithmatic functions on all numeric types.
    #. % : mod on integral types.


Virtual Machine
================

This section gives a brief introduction to the schemer virtual machine.

Schemer virtual machine heavily depends on the LLVM infrastructure. In addition
to the operations provided by LLVM, Schemer virtual machine provides the
following intrinsic functions.
