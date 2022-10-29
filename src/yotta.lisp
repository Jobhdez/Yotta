(in-package #:yotta)

;;;; Compiler

;;; This is just a quick `compile` function to actually compile a linear
;;; algebra expression; nevertheless, it is not very robust as does not
;;; check for the validity of the linear algebra expression. this will be
;;; fixed in the near future.

(defun compile-yotta-expr (expr)
  "Compiles a linear algebra expression into Common Lisp."
  (let* ((tokens (token-generator (lex-line expr)))
	 (parse-tree (parse-with-lexer tokens *linear-algebra-grammar*))
	 (intermediate-representation (make-lisp-interlan parse-tree))
	 (lisp-code (generate-lisp intermediate-representation)))
    lisp-code))
