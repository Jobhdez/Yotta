(asdf:defsystem #:yotta
    :description "A Linear Algebra compiler."
    :author "Job Hernandez <hj93@protonmail.com>"
    :in-order-to ((asdf:test-op (asdf:test-op #:yotta/tests)))
    :depends-on (#:alexa #:yacc #:alexandria #:trivia)
    :serial t
    :pathname "src/"
    :components
    ((:file "package")
     (:module "lexer"
	      :components ((:file "lexer")))
     (:module "parser"
	      :components ((:file "ast")
			   (:file "parser")
			   (:file "parsefile")))
     (:module "backends"
	      :components ((:module "lisp"
				    :components ((:file "lispIL")
						 (:file "ast")
						 (:file "generatelisp")))))))

(asdf:defsystem #:yotta/tests
    :description "Tests for Yotta."
    :author "Job Hernandez <hj93@protonmail.com>"
    :depends-on (#:yotta #:fiasco)
    :perform (asdf:test-op (o s)
			   (unless (symbol-call :yotta-tests
						:run-yotta-tests)
			     (error "Tests failed.")))
    :pathname "tests/"
    :serial t
    :components ((:file "package")
		 (:file "parsing-tests")
		 (:file "lisp-IL-tests")
		 (:file "utilities")))
