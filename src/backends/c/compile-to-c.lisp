(in-package #:yotta)

(defun compile-to-c (cil)
  "given the C INTERMEDIATE LANGUAGE compile to C."
  (match cil
	 ((c-vector-addition :left-exp lexp
			    :right-exp rexp
			    :i i
			    :n n
			    :fn-name name
			    :type type)
	  (let* ((vec (compile-vec lexp))
		 (vec2 (compile-vec rexp))
		 (vari (symbol->string i))
		 (varn (write-to-string n))
		 (vartype (symbol->string type)))
	    (compile-vector-addition vec
				     vec2
				     vari
				     varn
				     vartype
				     name
				     (c-vector-name lexp)
				     (c-vector-name rexp))))
	 
	 ((c-vector-subtraction :left-exp lexp
			    :right-exp rexp
			    :i i
			    :n n
			    :fn-name name
			    :type type)
	  (let* ((vec (compile-vec lexp))
		 (vec2 (compile-vec rexp))
		 (vari (symbol->string i))
		 (varn (write-to-string n))
		 (vartype (symbol->string type)))
	    (compile-vector-subtraction vec
				        vec2
				        vari
				        varn
				        vartype
				        name
					(c-vector-name lexp)
					(c-vector-name rexp))))))

(defun compile-vector-addition (vec vec2 vari varn vartype name vecname vec2name)
  (concatenate 'string "int main () {" " " vec ";" " " vec2 ";" " " "int size =" varn ";"  " " "int *p = add_vectors(" vecname " "  vec2name " " varn ")" ";" " "
	       "if (p) {" " "  "for (int i = 0; i < size; i++) {" " "  "printf(""%d\n"", p[i]);" " "  "}" " "  "free(p);}" " " "}"))

(defun compile-vector-subtraction (vec vec2 vari varn vartype name vecname vec2name)
  (concatenate 'string "int main () {" " " vec ";" " " vec2 ";" " " "int size =" varn ";"  " " "int *p = sub_vectors(" vecname " "  vec2name " " varn ")" ";" " "
	       "if (p) {" " "  "for (int i = 0; i < size; i++) {" " "  "printf(""%d\n"", p[i]);" " "  "}" " "  "free(p);}" " " "}"))


(defun compile-vec (vec-ast-node)
  "compile to a C ARRAY from a VEV C IL node."
  (match vec-ast-node
	 ((c-vector :type type
		    :length l
		    :elements nums
		    :name name)
	  (let* ((ty (symbol->string type))
		 (len (write-to-string l))
		 (expression (concatenate 'string
						ty
						" "
						name
						"[" len "]"
						" "
						"="
						" "
					        "{" (get-numbers nums) "}")))
	    expression))))

(defun symbol->string (s)
  (string-downcase (symbol-name s)))

(defun get-numbers (nums)
  (let ((ns (mapcar (lambda (num) (c-number-n num)) nums)))
	(format nil "~{~A~^, ~}" ns)))
				   
                         
	 
