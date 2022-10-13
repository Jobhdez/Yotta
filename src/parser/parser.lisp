(in-package #:yotta)

(eval-when (:compile-toplevel :load-toplevel :execute)
(defun i2p (a b c)
  (list b a c))

(defun k-2-3 (a b c)
  (declare (ignore a c))
  b)

(define-parser *expression-parser*
    (:start-symbol expression)
  (:terminals (:number :variable :plus :minus :mul :left-bracket :right-bracket :assignment))

  (expression
   vector-exp
   matrix-exp
   (expression :plus expression #'i2p)
   (expression :minus expression #'i2p)
   (expression :mul expression #'i2p))
  (vector-exp
   (:left-bracket :right-bracket)
   (:left-bracket entries :right-bracket))
  (matrix
   (:left-bracket  :right-bracket)
   (:left-bracket vectors :right-bracket))
  (vectors
   vector-exp
   (vector-exp vectors))
  (entries
   scalar-exp
   (scalar-exp entries))
  (scalar-exp
   :number)
  (assignment
   (:variable :assignment expression #'i2p))))
  
(defun token-generator (toks)
  (lambda ()
    (if (null toks)
	(values nil nil)
	(let ((tok (pop toks)))
	  (values (token-type tok)
		  (token-value tok))))))

(defun token-type (tok)
  (car tok))


(defun token-value (tok)
  (cdr tok))
