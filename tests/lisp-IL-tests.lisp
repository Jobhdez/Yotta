(in-package #:yotta-tests)

(deftest test-lispIL-vec ()
  (is (equalp (yotta:make-lisp-interlan
	       (yotta:parse-with-lexer
	       (yotta:token-generator
		(yotta:lex-line "[3 4 5]"))
	       yotta:*linear-algebra-grammar*))
	      (list (yotta:MAKE-VECTORLISP
		     :DIMENSION 3
		     :ELEMENTS (list (yotta:MAKE-NUMLISP :N 3)
				     (yotta:MAKE-NUMLISP :N 4)
				     (yotta:MAKE-NUMLISP :N 5)))))))

(deftest test-lispIL-vecsum ()
  (is (equalp (yotta:make-lisp-interlan
	       (yotta:parse-with-lexer
	       (yotta:token-generator
		(yotta:lex-line "[4 5 6] + [5 6 7]"))
	       yotta:*linear-algebra-grammar*))
	      (list (yotta:MAKE-VECTORSUM
		  :I (quote I)
		  :N 3
		  :EXP (yotta:MAKE-SETFLISP
			  :VAR (yotta:MAKE-AREFLISP :ARRAY (quote NEWARR) :I (quote I))
			  :EXP (yotta:MAKE-SUMLISP
				  :LEFTEXP (yotta:MAKE-AREFLISP
					      :ARRAY (yotta:MAKE-VECTORLISP
							:DIMENSION 3
							:ELEMENTS (list (yotta:MAKE-NUMLISP :N 4)
                                                                        (yotta:MAKE-NUMLISP :N 5)
                                                                        (yotta:MAKE-NUMLISP :N 6)))
					      :I (quote I))
				  :RIGHTEXP (yotta:MAKE-AREFLISP
					       :ARRAY (yotta:MAKE-VECTORLISP
							 :DIMENSION 3
							 :ELEMENTS (list (yotta:MAKE-NUMLISP :N 5)
                                                                         (yotta:MAKE-NUMLISP :N 6)
                                                                         (yotta:MAKE-NUMLISP :N 7)))
					       :I (quote I))))
		  :LEFTEXP (yotta:MAKE-VECTORLISP
			      :DIMENSION 3
			      :ELEMENTS (list (yotta:MAKE-NUMLISP :N 4) (yotta:MAKE-NUMLISP :N 5) (yotta:MAKE-NUMLISP :N 6)))
		  :RIGHTEXP (yotta:MAKE-VECTORLISP
			       :DIMENSION 3
			       :ELEMENTS (list (yotta:MAKE-NUMLISP :N 5)
					       (yotta:MAKE-NUMLISP :N 6)
                                               (yotta:MAKE-NUMLISP :N 7))))))))

(deftest test-lispIL-vecminus ()
  (is (equalp (yotta:make-lisp-interlan
	       (yotta:parse-with-lexer
	       (yotta:token-generator
		(yotta:lex-line "[4 5 6] - [5 6 7]"))
	       yotta:*linear-algebra-grammar*))
	      (list (yotta:MAKE-VECTORMINUS
		  :I (quote I)
		  :N 3
		  :EXP (yotta:MAKE-SETFLISP
			  :VAR (yotta:MAKE-AREFLISP :ARRAY 'NEWARR :I (quote I))
			  :EXP (yotta:MAKE-MINUSLISP
				  :LEFTEXP (yotta:MAKE-AREFLISP
					      :ARRAY (yotta:MAKE-VECTORLISP
							:DIMENSION 3
							:ELEMENTS (list (yotta:MAKE-NUMLISP :N 4)
                                                                        (yotta:MAKE-NUMLISP :N 5)
                                                                        (yotta:MAKE-NUMLISP :N 6)))
					      :I (quote I))
				  :RIGHTEXP (yotta:MAKE-AREFLISP
					       :ARRAY (yotta:MAKE-VECTORLISP
							 :DIMENSION 3
							 :ELEMENTS (list (yotta:MAKE-NUMLISP :N 5)
                                                                         (yotta:MAKE-NUMLISP :N 6)
                                                                         (yotta:MAKE-NUMLISP :N 7)))
					       :I (quote I))))
		  :LEFTEXP (yotta:MAKE-VECTORLISP
			      :DIMENSION 3
			      :ELEMENTS (list (yotta:MAKE-NUMLISP :N 4)
					      (yotta:MAKE-NUMLISP :N 5)
					      (yotta:MAKE-NUMLISP :N 6)))
		  :RIGHTEXP (yotta:MAKE-VECTORLISP
			       :DIMENSION 3
			       :ELEMENTS (list (yotta:MAKE-NUMLISP :N 5)
					       (yotta:MAKE-NUMLISP :N 6)
                                               (yotta:MAKE-NUMLISP :N 7))))))))

	      
	       


