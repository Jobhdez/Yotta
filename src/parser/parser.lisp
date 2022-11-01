(in-package #:yotta)

(eval-when (:compile-toplevel :load-toplevel :execute)

  (defun build-program (expressions)
    (make-program :expressions expressions))
  
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
    (make-matrix :entries (flatten entries)))

  (defun build-num (num)
    (make-num :num num))

  (defun build-var (var)
    (make-var :var var))

  (defun build-assignment (var assignment exp)
    (declare (ignore assignment))
    (make-assignment :variable var
		     :exp exp))

  (define-parser *linear-algebra-grammar*
      (:start-symbol program)
    (:terminals (:number :variable :plus :minus :mul :left-bracket :right-bracket :assignment))
    (program
     (expressions #'build-program))
    (expressions
     expression
     (expression expressions))
    (expression
     vector-exp
     matrix-exp
     assignment
     variable
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
    (variable
     (:variable #'build-var))
    (assignment
     (:variable :assignment expression #'build-assignment))))
  
