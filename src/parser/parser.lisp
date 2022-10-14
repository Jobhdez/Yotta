(in-package #:yotta)

(eval-when (:compile-toplevel :load-toplevel :execute)

  (defstruct plus left-exp right-exp)

  (defstruct minus left-exp right-exp)

  (defstruct mul left-exp right-exp)
  
  (defstruct vec entries)

  (defstruct matrix entries)

  (defstruct num num)

  (defstruct assignment variable exp)
  
  (defun build-plus (left-exp plus-tok right-exp)
    (declare (ignore plus-tok))
    (make-plus :left-exp left-exp
	       :right-exp right-exp))

  (defun build-minus (left-exp minus-tok right-exp)
    (declare (ignore minus-tok))
    (make-minus :left-exp left-exp
		:right-exp right-exp))

  (defun build-mul (left-exp mul-tok right-exp)
    (declare (ignore mul-tok))
    (make-mul :left-exp left-exp
	      :right-exp right-exp))

  (defun build-vec (left-bracket entries right-bracket)
    (declare (ignore left-bracket right-bracket))
    (make-vec :entries (flatten entries)))

  (defun build-matrix (left-bracket entries right-bracket)
    (declare (ignore left-bracket right-bracket))
    (make-matrix :entries entries))

  (defun build-num (num)
    (make-num :num num))

  (defun build-assignment (var assignment exp)
    (declare (ignore assignment))
    (make-assignment :variable var
		     :exp exp))

  (define-parser *linear-algebra-grammar*
      (:start-symbol expression)
    (:terminals (:number :variable :plus :minus :mul :left-bracket :right-bracket :assignment))
    (expression
     vector-exp
     matrix-exp
     assignment
     (expression :plus expression #'build-plus)
     (expression :minus expression #'build-minus)
     (expression :mul expression #'build-mul))
    (vector-exp
     (:left-bracket :right-bracket)
     (:left-bracket entries :right-bracket #'build-vec))
    (matrix-exp
     (:left-bracket  :right-bracket)
     (:left-bracket vectors :right-bracket #'build-matrix))
    (vectors
     vector-exp
     (vector-exp vectors))
    (entries
     scalar-exp
     (scalar-exp entries))
    (scalar-exp
     (:number #'build-num))
    (assignment
     (:variable :assignment expression #'build-assignment))))
  
(defun token-generator (toks)
 "Make a lexer that is compatible with CL-YACC."
  (lambda ()
    (if (null toks)
	(values nil nil)
	(let ((tok (pop toks)))
	  (values (token-type tok)
		  (token-value tok))))))

(defun token-type (tok)
  "returns the type the token TOK."
  (car tok))


(defun token-value (tok)
  "Returns the value of the token TOK."
  (cdr tok))
