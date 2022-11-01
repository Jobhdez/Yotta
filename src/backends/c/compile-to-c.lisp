(in-package #:yotta)

(defun compile-with-c-backend (exp)
  (let* ((tokens (lex-line exp))
	 (tree (parse-with-lexer (token-generator tokens) *linear-algebra-grammar*))
	 (cil (make-c-interlan tree))
	 (generatedcode (compile-to-c cil)))
    (concatenate 'string linear-algebra-defs " " generatedcode)))

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
					(c-vector-name rexp))))
	 ((c-matrix-addition :left-exp lexp
			     :right-exp rexp
			     :dimension dim)
	  (let* ((ma (compile-matrix lexp))
		 (ma2 (compile-matrix rexp))
		 (dims (mapcar (lambda (n) (write-to-string n)) dim)))
	    (compile-matrix-addition ma ma2 dims (c-matrix-name lexp) (c-matrix-name rexp))))
	 ((c-matrix-subtraction :left-exp lexp
			     :right-exp rexp
			     :dimension dim)
	  (let* ((ma (compile-matrix lexp))
		 (ma2 (compile-matrix rexp))
		 (dims (mapcar (lambda (n) (write-to-string n)) dim)))
	    (compile-matrix-subtraction ma ma2 dims (c-matrix-name lexp) (c-matrix-name rexp))))))
	 

(defun compile-vector-addition (vec vec2 vari varn vartype name vecname vec2name)
  (concatenate 'string "int main () {" " " vec ";" " " vec2 ";" " " "int size =" varn ";"  " " "int *p = add_vectors(" vecname " "  vec2name " " varn ")" ";" " "
	       "if (p) {" " "  "for (int i = 0; i < size; i++) {" " "  "printf(""%d\n"", p[i]);" " "  "}" " "  "free(p);}" " " "}"))

(defun compile-vector-subtraction (vec vec2 vari varn vartype name vecname vec2name)
  (concatenate 'string "int main () {" " " vec ";" " " vec2 ";" " " "int size =" varn ";"  " " "int *p = sub_vectors(" vecname " "  vec2name " " varn ")" ";" " "
	       "if (p) {" " "  "for (int i = 0; i < size; i++) {" " "  "printf(""%d\n"", p[i]);" " "  "}" " "  "free(p);}" " " "}"))

(defun compile-matrix-addition (ma ma2 dims maname ma2name)
  (concatenate 'string
	       "int main() { "
	       ma
	       "; "
	       ma2
	       "; "
	       "int size = "
	       (second dims)
	       "int **p2 = add_matrices( "
	       maname
	       " "
	       ma2name
	       ");"))

(defun compile-matrix-subtraction (ma ma2 dims maname ma2name)
  (concatenate 'string
	       "int main() { "
	       ma
	       "; "
	       ma2
	       "; "
	       "int size = "
	       (second dims)
	       "int **p2 = sub_matrices( "
	       maname
	       " "
	       ma2name
	       ");"))

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

(defun compile-matrix (matrix-ast-node)
  (match matrix-ast-node
	 ((c-matrix :type type
		    :length le
		    :elements els
		    :name name)
	   (let* ((ty (symbol->string type))
		  (len (mapcar (lambda (n) (write-to-string n)) le))
		  (els2 (mapcar #'compile-vec els))
		 (expression (concatenate 'string
						ty
						" "
						name
						"[" (car len) "][" (second len) "]"
						" "
						"="
						" "
					        "{" (get-matrix-numbers els2 ) "}")))
	    expression))))

	  

(defun symbol->string (s)
  (string-downcase (symbol-name s)))

(defun get-numbers (nums)
  (let ((ns (mapcar (lambda (num) (c-number-n num)) nums)))
	(format nil "~{~A~^, ~}" ns)))

(defun get-matrix-numbers (nums)
    (format nil "~{~A~^, ~}" nums))
    

(defvar linear-algebra-defs
  "int *add_vectors(int vec[], int vec2[], int size) {

  int *sum = malloc(size);

  if (!sum) {

    return NULL;

  }

  for (int i = 0; i < size; i++) {

    sum[i] = vec[i] + vec2[i];

    

  }

  return sum;

}

/*
  @param vec: a vector
  @param vec2: a vector
  @returns: the subtraction of VEC and VEC2
*/
int *sub_vectors(int vec[], int vec2[], int size) {

  int *sub = malloc(size);

  if (!sub) {

    return NULL;

  }

  for (int i = 0; i < size; i++) {

    sub[i] = vec[i] - vec2[i];

  }

  return sub;


}
int **add_matrices(int m[2][4], int m2[2][4], int size) {

  int **add;

  add = malloc(sizeof(int*) * size);

  for (int i = 0; i < size; i++) {

    add[i] = malloc(sizeof(int*) * size);

  }

  for (int i = 0; i < 2; i++) {

    for (int j = 0; j < size; j++) {

      add[i][j] = m[i][j] + m2[i][j];

    }

  }
  return add;



}

/*
  @param m: a matrix
  @param m2: a matrix
  @returns: the subtraction of M and M2
*/
int **sub_matrices(int m[2][4], int m2[2][4], int size) {

  int **sub;

  sub = malloc(sizeof(int*) * size);
  for (int i = 0; i < size; i++) {

    sub[i] = malloc(sizeof(int*) * size);

  }

  for (int i = 0; i < 2; i++) {

    for (int j = 0; j < size; j++) {

      sub[i][j] = m[i][j] + m2[i][j];

    }

  }
  return sub;

}
")

