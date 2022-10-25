(in-package #:yotta)

(defun make-lisp-interlan (parse-tree)
  "given a parse tree create a lisp based intermediate language."
  (match parse-tree
	 ((program :expressions exps)
	  (mapcar #'make-lisp-ast (flatten exps)))
	 (_ (error "Not valid expression."))))

(defun make-lisp-ast (expression-node)
  "given an parse tree node create a lisp abstract syntax tree node (ie., intermediate language."
  (match expression-node
	 ((assignment :variable a :exp b)
	  (make-defvarlisp :var a
			   :exp (make-lisp-ast b)))
	 ((vec :entries a)
	  (make-vectorlisp :dimension (length a)
			   :elements (mapcar #'make-lisp-ast a)))
	 ((matrix :entries exps)
	  (let ((n (length exps))
		(n2 (length (vec-entries (car exps)))))
	    (make-matrixlisp :dimension (list n n2)
			     :matrix (mapcar #'make-lisp-ast
					     exps))))
	 ((num :num n)
	  (make-numlisp :n n))
	 ((plus :left-exp lexp :right-exp rexp)
	  (cond ((and (vec-p lexp)
		      (vec-p rexp))
		 (make-vectorsum :i (quote yotta-var::i)
			         :n (length (vec-entries lexp))
			         :exp (make-setflisp :var (make-areflisp :array (quote yotta-var::newarray)
								         :i (quote yotta-var::i))
						     :exp (make-sumlisp :leftexp
								     (make-areflisp :array
										    (make-lisp-ast
										     lexp)
										    :i (quote yotta-var::i))
								        :rightexp
								     (make-areflisp :array
										    (make-lisp-ast
										     rexp)
										    :i (quote yotta-var::i))))
								     
				 :leftexp (make-lisp-ast lexp)
				 :rightexp (make-lisp-ast rexp)))
		((and (matrix-p lexp)
		      (matrix-p rexp))
		 (make-matrixsum :i (quote yotta-var::i)
				 :n (length (matrix-entries lexp))
				 :exp (make-looplisp :i  (quote yotta-var::j)
						     :n  (length (vec-entries (car (matrix-entries lexp))))
						     :exp (make-setflisp :var (make-areflisp :array (quote yotta-var::newarray)
											    :i (list (quote yotta-var::i) (quote yotta-var::j)))
									:exp (make-sumlisp :leftexp
											   (make-areflisp :array
													  (make-lisp-ast lexp)
													  :i (list (quote yotta-var::i)
														   (quote yotta-var::j)))
											   :rightexp
											   (make-areflisp :array
													  (make-lisp-ast rexp)
													  :i (list (quote yotta-var::i)
														   (quote yotta-var::j))))))
				 :leftexp (make-lisp-ast lexp)
				 :rightexp (make-lisp-ast rexp)))
		(t (error "The Expression ~S is not a valid SUM." (list '+ lexp rexp)))))
	 ((minus :left-exp lexp :right-exp rexp)
	  (cond ((and (vec-p lexp)
		     (vec-p rexp))
	      (make-vectorminus :i (quote yotta-var::i)
			      :n (length (vec-entries lexp))
			      :exp (make-setflisp :var (make-areflisp :array (quote yotta-var::newarray)
								      :i (quote yotta-var::i))
						  :exp (make-minuslisp :leftexp
								     (make-areflisp :array
										    (make-lisp-ast
										     lexp)
										    :i (quote yotta-var::i))
								     :rightexp
								     (make-areflisp :array
										    (make-lisp-ast
										     rexp)
										    :i (quote yotta-var::i))))
			      :leftexp (make-lisp-ast lexp)
			      :rightexp (make-lisp-ast rexp)))
		((and (matrix-p lexp)
		      (matrix-p rexp))
		 (make-matrixminus :i (quote yotta-var::i)
				 :n (length (matrix-entries lexp))
				 :exp (make-looplisp :i  (quote yotta-var::j)
						     :n  (length (vec-entries (car (matrix-entries lexp))))
						     :exp (make-setflisp :var (make-areflisp :array (quote yotta-var::newarray)
											    :i (list (quote yotta-var::i) (quote yotta-var::j)))
									:exp (make-minuslisp :leftexp
											   (make-areflisp :array
													  (make-lisp-ast lexp)
													  :i (list (quote yotta-var::i)
														   (quote yotta-var::j)))
											   :rightexp
											   (make-areflisp :array
													  (make-lisp-ast rexp)
													  :i (list (quote yotta-var::i)
														   (quote yotta-var::j))))))
				 :leftexp (make-lisp-ast lexp)
				 :rightexp (make-lisp-ast rexp)))
		(t (error "The Expression ~S is not a valid SUM." (list '- lexp rexp)))))
	 ;((mul :left-exp lexp :right-exp rexp)
	  ;(if (and (vec-p lexp)
		   ;(vec-p rexp))
	     ; (make-mul-vectors (make-lisp-ast lexp) (make-lisp-ast rexp))))
	 (_ (error "Not a valid expression node."))))

