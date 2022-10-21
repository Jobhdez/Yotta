(in-package #:yotta)

"""
these are procedures for generating lisp code that is not optimized so this is more of a draft as
of 10/20; if you see this message this file still contains code that is not optimized; in fact,
this code represents the LISP Intermediate Language -- ie file <lispIL.lisp>. I have this file
for reference and to give structure.
"""

(defun make-defvar (var exp)
  "Lisp based ast node for DEFVAR."
  `(defvar ,var ,exp))

(defun make-lisp-vec (elements)
  "Lisp based ast node for VECTOR."
  (let ((vec (map 'vector (lambda (n) n) elements)))
    vec))

(defun make-sum-vectors (vec vec2)
  "Lisp based ast node for MAKE-SUM-VECTORS."
  `(progn (setq newa (make-array ,(length vec)))
          (dotimes (i ,(length vec)) 
		  (setf (aref newa i) 
			(+ (aref ,vec i)
			   (aref ,vec2 i))))
           newa))


(defun make-minus-vectors (vec vec2)
  "Lisp based ast node for MAKE-MINUS-VECTOR."
  `(progn (setq newa (make-array ,(length vec)))
          (dotimes (i ,(length vec))
	    (setf (aref newa i) 
	       	  (- (aref ,vec i)
		     (aref ,vec2 i))))
           newa))
