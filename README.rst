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
              (Node Tree(element_type) Tree(element_type))))

    ; pattern matching
    (def (height (Leaf _)) 0) ; `_' means we donot care what is that.
    (def (height (Node left right))
         (+ 1 (max (height left)
                   (height right))))


Core Forms
================

Followings are the core forms of schemer.

    #. (data ...) : Create an algebric data type.
