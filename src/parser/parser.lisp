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
  (matrix-exp
   (:left-bracket :left-bracket :right-bracket :right-bracket)
   (:left-bracket :left-bracket entries :right-bracket :right-bracket))
  (entries
   scalar-exp
   (scalar-exp entries))
  (scalar-exp
   :number)
  (assignment
   (:variable :assignment expression #'i2p))))
  
(defun token-generator (tokens)
  (lambda ()
    (if (null tokens)
	(values nil nil)
	(let ((tok (pop tokens)))
	  (let ((terminal
		 (cond ((member tok '((:right-bracket) (:left-bracket)))
			tok)
		       ((member (car tok) '(:number :plus :minus :mul))
			tok)
		       (t (error "Unexpected value ~S" tok)))))
		(values terminal tok))))))
