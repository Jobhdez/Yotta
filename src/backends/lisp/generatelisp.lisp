(in-package #:yotta)

(defun generate-lisp (ast)
  "Generates lisp code from LispIL ast."
  (if (listp ast)
      (let ((node (car ast)))
	(generate node))))

(defun generate (node)
  "Generates lisp code from ast node."
  (match node
	 ((defvarlisp :var v :exp e)
	  (gen-defvar v e))
	 ((vectorlisp :dimension dim :elements els)
	  (let ((members (mapcar #'generate els)))
	    (gen-vec dim members)))
	 ((matrixlisp :dimension dim :matrix m)
	  (let ((members (mapcar #'generate m)))
	    (gen-matrix dim members)))
	 ((numlisp :n n)
	  n)
	 ((vectorsum :i i
		     :n n
		     :exp e
		     :leftexp lexp
		     :rightexp rexp)
	  (gen-sum-vectors (generate lexp)
			    (generate rexp)))
	 ((vectorminus :i i
		       :n n
		       :exp e
		       :leftexp lexp
		       :rightexp rexp)
	  (gen-minus-vectors (generate lexp)
			      (generate rexp)))
	 ((matrixsum :i i
		     :n n
		     :exp e
		     :leftexp lexp
		     :rightexp rexp)
	  (gen-sum-matrix (generate lexp)
			   (generate rexp)))
	 ((matrixminus :i i
		       :n n
		       :exp e
		       :leftexp lexp
		       :rightexp rexp)
	  (gen-minus-matrix (generate lexp)
			     (generate rexp)))
	 ((dotproduct :expression exp
		      :vector1 v
		      :vector2 v2)
	  (gen-dot-product (generate v)
			    (generate v2)))
	 ;((matrixmul :i i
		    ; :n n
		     ;:exp e
		     ;:leftexp lexp
		     ;:rightexp rexp)
	  ;(gen-matrix-mul (generate lexp)
			  ; (generate rexp)))
	 (_ (error "The expression: ~S is not a valid EXP." node))))
	        

(defun gen-defvar (var exp)
  "Lisp based ast node for DEFVAR."
  `(defvar ,var ,exp))

(defun gen-vec (dimension elements)
  "Lisp based ast node for VECTOR."
  `(make-array ,dimension ,elements))

(defun gen-matrix (dimension elements)
  "Matrix generated code."
  `(make-array ,dimension :initial-contents ,elements))

(defun gen-sum-vectors (vec vec2)
  "Lisp based ast node for MAKE-SUM-VECTORS."
  `(progn (setq newa (make-array ,(length vec)))
          (dotimes (i ,(length vec)) 
		  (setf (aref newa i) 
			(+ (aref ,vec i)
			   (aref ,vec2 i))))
           newa))


(defun gen-minus-vectors (vec vec2)
  "Lisp based ast node for MAKE-MINUS-VECTOR."
  `(progn (setq newa (make-array ,(length vec)))
          (dotimes (i ,(length vec))
	    (setf (aref newa i) 
	       	  (- (aref ,vec i)
		     (aref ,vec2 i))))
           newa))

(defun gen-sum-matrix (m1 m2)
  `(progn (setq newa (make-array (list (array-dimension ,m1 0) (array-dimension ,m1 1))))
	  (dotimes (i (array-dimension ,m1 0))
	    (dotimes (j (array-dimension ,m1 1))
	      (setf (aref newa i j) (+ (aref ,m1 i j) (aref ,m2 i j)))))
	  newa))

(defun gen-minus-matrix (m1 m2)
  `(progn (setq newa (make-array ((array-dimension ,m1 0) (array-dimension ,m1 1))))
	  (dotimes (i (array-dimension ,m1 0))
	    (dotimes (j (array-dimension ,m1 1))
	      (setf (aref newa i j) (- (aref ,m1 i j) (aref ,m2 i j)))))
	  newa))

(defun gen-dot-product (v v2)
  `(progn (setq fakemulvec (make-array (array-dimension ,v 0)))
	  (dotimes (i (array-dimension ,v 0))
	    (setf (aref fakesumvec i)
		  (* (aref ,v i) (aref ,v2 i))))
	  (setq sum 0)
	  (dotimes (i (array-dimension fakemulvec 0))
	    (setq sum (+ sum (aref fakemulvec i))))
	  sum))
