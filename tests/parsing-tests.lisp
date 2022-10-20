(in-package #:yotta-tests)

(deftest test-parse-vec ()
  (is (equalp (yotta:parse-with-lexer
	       (yotta:token-generator
		(yotta:lex-line "[3 4 5]"))
	       yotta:*linear-algebra-grammar*)
	      (yotta:make-program :expressions
				  (yotta:make-vec :entries
						  (list (yotta:make-num :num 3)
						        (yotta:make-num :num 4)
							(yotta:make-num :num 5)))))))

(deftest test-parse-matrix ()
  (is (equalp (yotta:parse-with-lexer
	       (yotta:token-generator
		(yotta:lex-line "[[3 4 5] [5 6 7]]"))
	       yotta:*linear-algebra-grammar*)
	      (yotta:MAKE-PROGRAM
	       :EXPRESSIONS (yotta:MAKE-MATRIX
			     :ENTRIES
			     (list
			      (yotta:MAKE-VEC
					     :ENTRIES (list (yotta:MAKE-NUM :NUM 3)
							    (yotta:MAKE-NUM :NUM 4)
                                                            (yotta:MAKE-NUM :NUM 5)))
                              (yotta:MAKE-VEC
                              :ENTRIES (list (yotta:MAKE-NUM :NUM 5)
					     (yotta:MAKE-NUM :NUM 6)
                                             (yotta:MAKE-NUM :NUM 7)))))))))

(deftest test-parse-vector-sum ()
  (is (equalp (yotta:parse-with-lexer
	       (yotta:token-generator
		(yotta:lex-line "[3 4 5] + [4 5 6]"))
	       yotta:*linear-algebra-grammar*)
	      (yotta:MAKE-PROGRAM
	       :EXPRESSIONS
	       (yotta:MAKE-PLUS
                :LEFT-EXP (yotta:MAKE-VEC
			   :ENTRIES (list (yotta:MAKE-NUM :NUM 3) (yotta:MAKE-NUM :NUM 4)
                                          (yotta:MAKE-NUM :NUM 5)))
                :RIGHT-EXP (yotta:MAKE-VEC
			   :ENTRIES (list (yotta:MAKE-NUM :NUM 4) (yotta:MAKE-NUM :NUM 5)
                                          (yotta:MAKE-NUM :NUM 6))))))))

(deftest test-parse-vector-minus ()
  (is (equalp (yotta:parse-with-lexer
	       (yotta:token-generator
		(yotta:lex-line "[3 4 5] - [4 5 6]"))
	       yotta:*linear-algebra-grammar*)
	      (yotta:MAKE-PROGRAM
	       :EXPRESSIONS
	       (yotta:MAKE-MINUS
                :LEFT-EXP (yotta:MAKE-VEC
			   :ENTRIES (list (yotta:MAKE-NUM :NUM 3) (yotta:MAKE-NUM :NUM 4)
                                          (yotta:MAKE-NUM :NUM 5)))
                :RIGHT-EXP (yotta:MAKE-VEC
			    :ENTRIES (list (yotta:MAKE-NUM :NUM 4) (yotta:MAKE-NUM :NUM 5)
                                           (yotta:MAKE-NUM :NUM 6))))))))
			    



(deftest test-parse-matrix-sum ()
  (is (equalp (yotta:parse-with-lexer
	       (yotta:token-generator
		(yotta:lex-line "[[3 4 5] [4 5 6]] + [[4 5 6] [6 7 8]]"))
	       yotta:*linear-algebra-grammar*)
	      (yotta:MAKE-PROGRAM
	       :EXPRESSIONS
	       (yotta:MAKE-PLUS
		:LEFT-EXP (yotta:MAKE-MATRIX
			   :ENTRIES (list (yotta:MAKE-VEC
					   :ENTRIES (list (yotta:MAKE-NUM :NUM 3) (yotta:MAKE-NUM :NUM 4)
                                                          (yotta:MAKE-NUM :NUM 5)))
					  (yotta:MAKE-VEC
					   :ENTRIES (list (yotta:MAKE-NUM :NUM 4) (yotta:MAKE-NUM :NUM 5)
                                                          (yotta:MAKE-NUM :NUM 6)))))
					  
                :RIGHT-EXP (yotta:MAKE-MATRIX
			    :ENTRIES (list (yotta:MAKE-VEC
					   :ENTRIES (list (yotta:MAKE-NUM :NUM 4) (yotta:MAKE-NUM :NUM 5)
                                                          (yotta:MAKE-NUM :NUM 6)))
					  (yotta:MAKE-VEC
					   :ENTRIES (list (yotta:MAKE-NUM :NUM 6) (yotta:MAKE-NUM :NUM 7)
                                                          (yotta:MAKE-NUM :NUM 8))))))))))

(deftest test-parse-matrix-minus ()
  (is (equalp (yotta:parse-with-lexer
	       (yotta:token-generator
		(yotta:lex-line "[[3 4 5] [4 5 6]] - [[4 5 6] [6 7 8]]"))
	       yotta:*linear-algebra-grammar*)
	      (yotta:MAKE-PROGRAM
	       :EXPRESSIONS
	       (yotta:MAKE-MINUS
		:LEFT-EXP (yotta:MAKE-MATRIX
			   :ENTRIES (list (yotta:MAKE-VEC
					   :ENTRIES (list (yotta:MAKE-NUM :NUM 3) (yotta:MAKE-NUM :NUM 4)
                                                          (yotta:MAKE-NUM :NUM 5)))
					  (yotta:MAKE-VEC
					   :ENTRIES (list (yotta:MAKE-NUM :NUM 4) (yotta:MAKE-NUM :NUM 5)
                                                          (yotta:MAKE-NUM :NUM 6)))))
					  
                :RIGHT-EXP (yotta:MAKE-MATRIX
			    :ENTRIES (list (yotta:MAKE-VEC
					   :ENTRIES (list (yotta:MAKE-NUM :NUM 4) (yotta:MAKE-NUM :NUM 5)
                                                          (yotta:MAKE-NUM :NUM 6)))
					  (yotta:MAKE-VEC
					   :ENTRIES (list (yotta:MAKE-NUM :NUM 6) (yotta:MAKE-NUM :NUM 7)
                                                          (yotta:MAKE-NUM :NUM 8))))))))))

(deftest test-parse-assignment ()
  (is (equalp (yotta:parse-with-lexer
	       (yotta:token-generator
		(yotta:lex-line "x = [[4 5 6] [5 6 7]]"))
	       yotta:*linear-algebra-grammar*)
	       (yotta:MAKE-PROGRAM
	       :EXPRESSIONS
	       (yotta:MAKE-ASSIGNMENT
		:VARIABLE 'X
		:EXP (yotta:MAKE-MATRIX
			    :ENTRIES (list (yotta:MAKE-VEC
					   :ENTRIES (list (yotta:MAKE-NUM :NUM 4) (yotta:MAKE-NUM :NUM 5)
                                                          (yotta:MAKE-NUM :NUM 6)))
					  (yotta:MAKE-VEC
					   :ENTRIES (list (yotta:MAKE-NUM :NUM 5) (yotta:MAKE-NUM :NUM 6)
                                                          (yotta:MAKE-NUM :NUM 7))))))))))
	      
		

	      
	      
	      
