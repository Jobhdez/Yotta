(in-package #:yotta)

(defun make-lisp-interlan (parse-tree)
  "given a parse tree create a lisp based intermediate language."
  (match parse-tree
	 ((program :expressions exps)
	  (mapcar #'make-lisp-ast exps))
	 (_ (error "Not valid expression."))))

(defun make-lisp-ast (expression-node)
  "given an parse tree node create a lisp abstract syntax tree node (ie., intermediate language."
  (match expression-node
	 ((assignment :variable a :exp b)
	  (make-defvar  a (make-lisp-ast b)))
	 ((vec :entries a)
	  (make-lisp-vec (mapcar #'make-lisp-ast) a))
	 ((num :num n)
	  n)
	 ((plus :left-exp lexp :right-exp rexp)
	  (if (and (vec-p lexp)
		   (vec-p rexp))
	      (make-sum-vectors (make-lisp-ast lexp) (make-lisp-ast rexp))))
	 ((minus :left-exp lexp :right-exp rexp)
	  (if (and (vec-p lexp)
		   (vec-p rexp))
	      (make-minus-vectors (make-lisp-ast lexp) (make-lisp-ast rexp))))
	 ((mul :left-exp lexp :right-exp rexp)
	  (if (and (vec-p lexp)
		   (vec-p rexp))
	      (make-mul-vectors (make-lisp-ast lexp) (make-lisp-ast rexp))))
	 (_ (error "Not a valid expression node."))))

(defun make-defvar (var exp)
  `(defvar ,var ,exp))

(defun make-sum-vectors (vec vec2)
  `(loop for i in ,vec
	 for j in ,vec2
	 collect (+ i j)))

(defun make-minus-vectors (vec vec2)
  `(loop for i in ,vec
	 for j in ,vec2
	 collect (- i j)))

(defun make-mul-vectors (vec vec2)
  `(loop for i in ,vec
	 for j in ,vec2
	 collect (* i j)))

	 
  
