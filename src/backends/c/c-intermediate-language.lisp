(in-package #:yotta)

;;; this the c intermediate language; it consumes the parse tree.


(defun make-c-interlan (parse-tree)
  "Makes the C INTERMEDIATE LANGUAGE given the parse tree."
  (match parse-tree
	 ((program :expressions exps)
	  (if (listp exps)
	      (mapcar #'make-c-ast exps)
	      (make-c-ast exps)))))

(defun make-c-ast (parse-tree)
  "Makes the C ast."
  (match parse-tree
	 ((assignment :variable var
		      :exp e)
	  (make-c-assignment :type (quote yotta-var::int)
			     :var-name (generate-name e)
			     :exp (make-c-ast e)))
	 ((vec :entries v)
	  (make-c-vector :type (quote yotta-var::int)
			 :length (length v)
			 :elements (mapcar #'make-c-ast v)
			 :name (generate-name "vec")))
	 ((num :num n)
	  (make-c-number :type (quote yotta-var::int)
			 :n n))
	 ((matrix :entries m)
	  (make-c-matrix :type (quote yotta-var::int)
			 :length (list (length m) (length (vec-entries (car m))))
			 :elements (mapcar #'make-c-ast m)
			 :name (generate-name "matrix")))
	 ((plus :left-exp lexp :right-exp rexp)
	  (cond ((and (vec-p lexp)
		      (vec-p rexp))
		 (make-c-vector-addition :left-exp (make-c-ast lexp)
					 :right-exp (make-c-ast rexp)
					 :i (quote yotta-var::i)
					 :n (length (vec-entries lexp))
					 :fn-name (generate-name "vectorsum")
					 :type (quote yotta-var::int)))
		((and (matrix-p lexp)
		      (matrix-p rexp))
		 (make-c-matrix-addition :left-exp (make-c-ast lexp)
					 :right-exp (make-c-ast rexp)
					 :dimension (list (length (matrix-entries lexp))
							  (length (vec-entries (car (matrix-entries lexp)))))))))
		 
	 ((minus :left-exp lexp :right-exp rexp)
	  (cond ((and (vec-p lexp)
		      (vec-p rexp))
		 (make-c-vector-subtraction :left-exp (make-c-ast lexp)
				            :right-exp (make-c-ast rexp)
				            :i (quote yotta-var::i)
				            :n (length (vec-entries lexp))
				            :fn-name (generate-name "vectorsub")
				            :type (quote yotta-var::int)))
		((and (matrix-p lexp)
		      (matrix-p rexp))
		 (make-c-matrix-subtraction :left-exp (make-c-ast lexp)
					    :right-exp (make-c-ast rexp)
					    :dimension (list (length (matrix-entries lexp))
							  (length (vec-entries (car (matrix-entries lexp)))))))))
	 (_ (error "Only vecs right now."))))


(defun generate-name (exp)
  "Consumes a node or a string and creates a name."
  (match exp
	 ((guard x (stringp x))
	  (*gensym* x))
	 ((vec :entries v)
	  (*gensym* "vec"))
	 ((matrix :entries m)
	  (*gensym* "matrix"))
	 (_ (error "Not a valid expression."))))
	 
	 
(defvar gensym-count 0)

(defun *gensym* (string-name)
  (progn (setf gensym-count (+ gensym-count 1))
	 (concatenate 'string
		      string-name
		      (write-to-string gensym-count))))
	 
		      
