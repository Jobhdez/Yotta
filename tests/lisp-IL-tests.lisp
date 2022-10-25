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

(deftest test-lispIL-matrix ()
  (is (equalp (yotta:make-lisp-interlan
	       (yotta:parse-with-lexer
	       (yotta:token-generator
		(yotta:lex-line "[[4 5 6] [5 6 7]]"))
	       yotta:*linear-algebra-grammar*))
	      (list (yotta:make-matrixlisp
		     :dimension (list 2 3)
		     :matrix (list (yotta:MAKE-VECTORLISP
				    :DIMENSION 3
				    :ELEMENTS (list (yotta:MAKE-NUMLISP :N 4)
				                    (yotta:MAKE-NUMLISP :N 5)
				                    (yotta:MAKE-NUMLISP :N 6)))
				    (yotta:MAKE-VECTORLISP
				    :DIMENSION 3
				    :ELEMENTS (list (yotta:MAKE-NUMLISP :N 5)
				                    (yotta:MAKE-NUMLISP :N 6)
				                    (yotta:MAKE-NUMLISP :N 7)))))))))
				   




(deftest test-lispIL-vecsum ()
  (is (equalp (yotta:make-lisp-interlan
	       (yotta:parse-with-lexer
	       (yotta:token-generator
		(yotta:lex-line "[4 5 6] + [5 6 7]"))
	       yotta:*linear-algebra-grammar*))
	      (list (yotta:MAKE-VECTORSUM
		  :I (quote yotta-var::I)
		  :N 3
		  :EXP (yotta:MAKE-SETFLISP
			  :VAR (yotta:MAKE-AREFLISP :ARRAY (quote yotta-var::NEWARRAY) :I (quote yotta-var::I))
			  :EXP (yotta:MAKE-SUMLISP
				  :LEFTEXP (yotta:MAKE-AREFLISP
					      :ARRAY (yotta:MAKE-VECTORLISP
							:DIMENSION 3
							:ELEMENTS (list (yotta:MAKE-NUMLISP :N 4)
                                                                        (yotta:MAKE-NUMLISP :N 5)
                                                                        (yotta:MAKE-NUMLISP :N 6)))
					      :I (quote yotta-var::I))
				  :RIGHTEXP (yotta:MAKE-AREFLISP
					       :ARRAY (yotta:MAKE-VECTORLISP
							 :DIMENSION 3
							 :ELEMENTS (list (yotta:MAKE-NUMLISP :N 5)
                                                                         (yotta:MAKE-NUMLISP :N 6)
                                                                         (yotta:MAKE-NUMLISP :N 7)))
					       :I (quote yotta-var::I))))
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
		  :I (quote yotta-var::I)
		  :N 3
		  :EXP (yotta:MAKE-SETFLISP
			  :VAR (yotta:MAKE-AREFLISP :ARRAY (quote yotta-var::NEWARRAY) :I (quote yotta-var::I))
			  :EXP (yotta:MAKE-MINUSLISP
				  :LEFTEXP (yotta:MAKE-AREFLISP
					      :ARRAY (yotta:MAKE-VECTORLISP
							:DIMENSION 3
							:ELEMENTS (list (yotta:MAKE-NUMLISP :N 4)
                                                                        (yotta:MAKE-NUMLISP :N 5)
                                                                        (yotta:MAKE-NUMLISP :N 6)))
					      :I (quote yotta-var::I))
				  :RIGHTEXP (yotta:MAKE-AREFLISP
					       :ARRAY (yotta:MAKE-VECTORLISP
							 :DIMENSION 3
							 :ELEMENTS (list (yotta:MAKE-NUMLISP :N 5)
                                                                         (yotta:MAKE-NUMLISP :N 6)
                                                                         (yotta:MAKE-NUMLISP :N 7)))
					       :I (quote yotta-var::I))))
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

	      
	       


(deftest test-lispIL-matrix-sum ()
  (is (equalp (yotta:make-lisp-interlan
	       (yotta:parse-with-lexer
	       (yotta:token-generator
		(yotta:lex-line "[[3 4 5] [6 7 8]] + [[9 10 11] [12 13 14]]"))
	       yotta:*linear-algebra-grammar*))
	      (list (yotta:make-MATRIXSUM
    :I (quote YOTTA-VAR::I)
    :N 2
    :EXP (yotta:make-LOOPLISP
            :I (quote YOTTA-VAR::J)
            :N 3
            :EXP (yotta:make-SETFLISP
                    :VAR (yotta:make-AREFLISP
                            :ARRAY (quote YOTTA-VAR::NEWARRAY)
                            :I (list (quote YOTTA-VAR::I) (quote YOTTA-VAR::J)))
                    :EXP (yotta:make-SUMLISP
                            :LEFTEXP (yotta:make-AREFLISP
                                        :ARRAY (yotta:make-MATRIXLISP
                                                  :DIMENSION (list 2 3)
                                                  :MATRIX (list (yotta:make-VECTORLISP
                                                              :DIMENSION 3
                                                              :ELEMENTS (list (yotta:make-NUMLISP
                                                                            :N 3)
                                                                         (yotta:make-NUMLISP
                                                                            :N 4)
                                                                         (yotta:make-NUMLISP
                                                                            :N 5)))
                                                           (yotta:make-VECTORLISP
                                                              :DIMENSION 3
                                                              :ELEMENTS (list (yotta:make-NUMLISP
                                                                            :N 6)
                                                                         (yotta:make-NUMLISP
                                                                            :N 7)
                                                                         (yotta:make-NUMLISP
                                                                            :N 8)))))
                                        :I (list (quote YOTTA-VAR::I) (quote YOTTA-VAR::J)))
                            :RIGHTEXP (yotta:make-AREFLISP
                                        :ARRAY (yotta:make-MATRIXLISP
                                                  :DIMENSION (list 2 3)
                                                  :MATRIX (list (yotta:make-VECTORLISP
                                                              :DIMENSION 3
                                                              :ELEMENTS (list (yotta:make-NUMLISP
                                                                            :N 9)
                                                                         (yotta:make-NUMLISP
                                                                            :N 10)
                                                                         (yotta:make-NUMLISP
                                                                            :N 11)))
                                                           (yotta:make-VECTORLISP
                                                              :DIMENSION 3
                                                              :ELEMENTS (list (yotta:make-NUMLISP
                                                                            :N 12)
                                                                         (yotta:make-NUMLISP
                                                                            :N 13)
                                                                         (yotta:make-NUMLISP
                                                                            :N 14)))))
                                        :I (list (quote YOTTA-VAR::I) (quote YOTTA-VAR::J))))))
    :LEFTEXP (yotta:make-MATRIXLISP
                :DIMENSION (list 2 3)
                :MATRIX (list (yotta:make-VECTORLISP
                            :DIMENSION 3
                            :ELEMENTS (list (yotta:make-NUMLISP :N 3) (yotta:make-NUMLISP :N 4)
                                       (yotta:make-NUMLISP :N 5)))
                         (yotta:make-VECTORLISP
                            :DIMENSION 3
                            :ELEMENTS (list (yotta:make-NUMLISP :N 6) (yotta:make-NUMLISP :N 7)
					    (yotta:make-NUMLISP :N 8)))))
    :RIGHTEXP (yotta:make-MATRIXLISP
                :DIMENSION (list 2 3)
                :MATRIX (list (yotta:make-VECTORLISP
                            :DIMENSION 3
                            :ELEMENTS (list (yotta:make-NUMLISP :N 9) (yotta:make-NUMLISP :N 10)
                                       (yotta:make-NUMLISP :N 11)))
                         (yotta:make-VECTORLISP
                            :DIMENSION 3
                            :ELEMENTS (list (yotta:make-NUMLISP :N 12) (yotta:make-NUMLISP :N 13)
                                       (yotta:make-NUMLISP :N 14))))))))))

(deftest test-lispIL-matrix-minus ()
  (is (equalp (yotta:make-lisp-interlan
	       (yotta:parse-with-lexer
	       (yotta:token-generator
		(yotta:lex-line "[[3 4 5] [6 7 8]] - [[9 10 11] [12 13 14]]"))
	       yotta:*linear-algebra-grammar*))
	      (list (yotta:make-MATRIXMINUS
    :I (quote YOTTA-VAR::I)
    :N 2
    :EXP (yotta:make-LOOPLISP
            :I (quote YOTTA-VAR::J)
            :N 3
            :EXP (yotta:make-SETFLISP
                    :VAR (yotta:make-AREFLISP
                            :ARRAY (quote YOTTA-VAR::NEWARRAY)
                            :I (list (quote YOTTA-VAR::I) (quote YOTTA-VAR::J)))
                    :EXP (yotta:make-MINUSLISP
                            :LEFTEXP (yotta:make-AREFLISP
                                        :ARRAY (yotta:make-MATRIXLISP
                                                  :DIMENSION (list 2 3)
                                                  :MATRIX (list (yotta:make-VECTORLISP
                                                              :DIMENSION 3
                                                              :ELEMENTS (list (yotta:make-NUMLISP
                                                                            :N 3)
                                                                         (yotta:make-NUMLISP
                                                                            :N 4)
                                                                         (yotta:make-NUMLISP
                                                                            :N 5)))
                                                           (yotta:make-VECTORLISP
                                                              :DIMENSION 3
                                                              :ELEMENTS (list (yotta:make-NUMLISP
                                                                            :N 6)
                                                                         (yotta:make-NUMLISP
                                                                            :N 7)
                                                                         (yotta:make-NUMLISP
                                                                            :N 8)))))
                                        :I (list (quote YOTTA-VAR::I) (quote YOTTA-VAR::J)))
                            :RIGHTEXP (yotta:make-AREFLISP
                                        :ARRAY (yotta:make-MATRIXLISP
                                                  :DIMENSION (list 2 3)
                                                  :MATRIX (list (yotta:make-VECTORLISP
                                                              :DIMENSION 3
                                                              :ELEMENTS (list (yotta:make-NUMLISP
                                                                            :N 9)
                                                                         (yotta:make-NUMLISP
                                                                            :N 10)
                                                                         (yotta:make-NUMLISP
                                                                            :N 11)))
                                                           (yotta:make-VECTORLISP
                                                              :DIMENSION 3
                                                              :ELEMENTS (list (yotta:make-NUMLISP
                                                                            :N 12)
                                                                         (yotta:make-NUMLISP
                                                                            :N 13)
                                                                         (yotta:make-NUMLISP
                                                                            :N 14)))))
                                        :I (list (quote YOTTA-VAR::I) (quote YOTTA-VAR::J))))))
    :LEFTEXP (yotta:make-MATRIXLISP
                :DIMENSION (list 2 3)
                :MATRIX (list (yotta:make-VECTORLISP
                            :DIMENSION 3
                            :ELEMENTS (list (yotta:make-NUMLISP :N 3) (yotta:make-NUMLISP :N 4)
                                       (yotta:make-NUMLISP :N 5)))
                         (yotta:make-VECTORLISP
                            :DIMENSION 3
                            :ELEMENTS (list (yotta:make-NUMLISP :N 6) (yotta:make-NUMLISP :N 7)
					    (yotta:make-NUMLISP :N 8)))))
    :RIGHTEXP (yotta:make-MATRIXLISP
                :DIMENSION (list 2 3)
                :MATRIX (list (yotta:make-VECTORLISP
                            :DIMENSION 3
                            :ELEMENTS (list (yotta:make-NUMLISP :N 9) (yotta:make-NUMLISP :N 10)
                                       (yotta:make-NUMLISP :N 11)))
                         (yotta:make-VECTORLISP
                            :DIMENSION 3
                            :ELEMENTS (list (yotta:make-NUMLISP :N 12) (yotta:make-NUMLISP :N 13)
                                       (yotta:make-NUMLISP :N 14))))))))))
