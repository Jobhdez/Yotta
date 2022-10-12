(asdf:defsystem #:yotta
    :description "A Linear Algebra compiler."
    :author "Job Hernandez <hj93@protonmail.com>"
    :in-order-to ((asdf:test-op (asdf:test-op #:yotta/tests)))
    :depends-on (#:alexa)
    :serial t
    :pathname "src/"
    :components
    ((:file "package")
     (:module "lexer"
	      :components ((:file "lexer")))
     ))
