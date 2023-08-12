(in-package #:yotta)

(defparameter linear-algebra-defs
  "

#include <stdio.h>
#include <stdlib.h>


typedef struct vector {
  int length;
  int *data;
} vector;

typedef struct matrix {
  int rows;
  int columns;
  int **data;
} matrix;

// vectors
vector *make_vector(int length) {

  vector *v1 = calloc(1, sizeof(*v1));
  v1->length = length;
  v1->data = calloc(v1->length, sizeof(*v1->data));

  return v1;
}
vector *initialize_vector(vector *v1, int data[]) {
    for (int i = 0; i < v1->length; i++) {
      v1->data[i] = data[i];
}

  return v1;
}
    
vector *add_vectors(vector *v1, vector *v2) {
  /*
    @param p1: a vector struct denoting a vector
    @param p2: a vector struct denoting a vector
    @returns: p3, a vector struct denoting a vector

    returns the sum of both vector.

   
   */
  vector *result = malloc(sizeof(vector));
  result->data = malloc(v1->length * sizeof(int));
  result->length = v1->length;

  if (!result->data) {
    return NULL;
  }

  for (int i = 0; i < v1->length; i++) {
    result->data[i] = v1->data[i] + v2->data[i];
  }

  return result;
}

vector *sub_vectors(vector *v1, vector *v2) {
  /*
    @param p1: a vector struct denoting a vector
    @param p2: a vector struct denoting a vector
    @returns: p3, a vector struct denoting a vector

    returns the sub of both vector.

   
   */
  vector *result = malloc(sizeof(vector));
  result->data = malloc(v1->length * sizeof(int));
  result->length = v1->length;

  if (!result->data) {
    return NULL;
  }

  for (int i = 0; i < v1->length; i++) {
    result->data[i] = v1->data[i] - v2->data[i];
  }

  return result;
}

void print_vector(vector *v1) {
    for (int i = 0; i < v1->length; i++) {
      printf(\"%d \", v1->data[i]);
    }
  }

void free_vector(vector *v) {
  free(v->data);
  free(v);
}

// matrices

/*
  @param m: a matrix
  @param m2: a matrix
  @returns: the sum of M and M2
*/

matrix *make_matrix(int rows, int columns) {
  /*
    make a matrix given two ints: rows, and columns
  */
  matrix *m = calloc(1, sizeof(*m));
  m->rows = rows;
  m->columns = columns;
  m->data = calloc(m->rows, sizeof(*m->data)); // allocate memory for column array
  for (int i = 0; i < m->rows; i++) {
    m->data[i] = calloc(m->columns, sizeof(**m->data));
  }
 
  return m;
}

matrix *initialize_matrix(matrix *m1, int n, int data[][n]) {
   for (int i = 0; i < m1->rows; i++) {
     for (int j = 0; j < m1->columns; j++) {
       m1->data[i][j] = data[i][j];
    }
}
  return m1;
}
       
matrix *add_mat(matrix *m1, matrix *m2) {

  /*
    add matrixes m1 and m2.
    
   */
  int rows = m1->rows;
  int columns = m1->columns;

  matrix *m3 = make_matrix(rows, columns);

  for (int i = 0; i < m3->rows; i++) {
    for (int j = 0; j < m3->columns; j++) {
      m3->data[i][j] = m1->data[i][j] + m2->data[i][j];
    }
  }
  return m3;
}

matrix *sub_mat(matrix *m1, matrix *m2) {
  /* subtract matrixes m1 and m2*/
  int rows = m1->rows;
  int columns = m1->columns;

  matrix *m3 = make_matrix(rows, columns);

  for (int i = 0; i < m3->rows; i++) {
    for (int j = 0; j < m3->columns; j++) {
      m3->data[i][j] = m1->data[i][j] - m2->data[i][j];
    }
  }
  return m3;
}

void print_matrix(matrix *m) {
  for (int i = 0; i < m->rows; i++) {
    for (int j = 0; j < m->columns; j++) {
      printf(\"%d\", m->data[i][j]);
      printf(\"\\t\");
    }
    printf(\"\\n\");
  }
}



void free_matrix(matrix *m) {
  free(m->data);
  free(m);
}

int main() {")


(defun generate-c (exp filename)
  (with-open-file (str filename
		       :direction :output
		       :if-exists  :supersede
		       :if-does-not-exist :create)
    (format str (compile-with-c-backend exp))))

(defun compile-with-c-backend (exp)
  (let* ((tokens (lex-line exp))
	 (tree (parse-with-lexer (token-generator tokens) *linear-algebra-grammar*))
	 (cil (make-c-interlan tree))
	 (generatedcode (compile-to-c cil)))
    (concatenate 'string linear-algebra-defs generatedcode " " "}")))

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
  (concatenate 'string vec ";" " " vec2 ";"   " " "vector *p = add_vectors(" vecname ","  vec2name ")" ";" " print_vector(p); " "free_vector(p);"))

(defun compile-vector-subtraction (vec vec2 vari varn vartype name vecname vec2name)
  (concatenate 'string vec ";" " " vec2 ";" " " "vector *p = sub_vectors(" vecname ","  vec2name ")" ";" " print_vector(p); " "free_vector(p);"))

(defun compile-matrix-addition (ma ma2 dims maname ma2name)
  (concatenate 'string
	       ma
	       "; "
	       ma2
	       "; "
	       " matrix *p2 = add_mat( "
	       maname
	       ","
	       ma2name
	       ");"
	       " print_matrix(p2);"
	       " free_matrix(p2);"))

(defun compile-matrix-subtraction (ma ma2 dims maname ma2name)
  (concatenate 'string
	       ma
	       "; "
	       ma2
	       "; "
	       " matrix *p2 = sub_mat( "
	       maname
	       ","
	       ma2name
	       ");"
	       " print_matrix(p2);"
               " free_matrix(p2);"))

(defun compile-vec (vec-ast-node)
  "compile to a C ARRAY from a VEV C IL node."
  (match vec-ast-node
	 ((c-vector :type type
		    :length l
		    :elements nums
		    :name name)
	  (let* ((ty (symbol->string type))
		 (len (write-to-string l))
		 (name2 (*gensym* "vector_"))
		 (*data* (*gensym* "data"))
		 (expression (concatenate 'string
					  "vector "
					  "*"
					  name2
					  "= "
					  "make_vector("
					  len
					  ");"
					  " "
					  "int "
					  *data*
					  "[] "
					  "="
					   "{" (get-numbers nums) "}; "
					   "vector "
					   "*"
					  name
					  "="
					  "initialize_vector("
					  name2
					  ","
					  *data*
					  ");")))
	    expression))))

(defun compile-matrix (matrix-ast-node)
  (match matrix-ast-node
	 ((c-matrix :type type
		    :length le
		    :elements els
		    :name name)
	   (let* ((ty (symbol->string type))
		  (len (mapcar (lambda (n) (write-to-string n)) le))
		  (els2 (mapcar #'get-nums els))
		  (name2 (*gensym* "matrix_"))
		  (*data* (*gensym* "data"))
		  (expression (concatenate 'string
					   "matrix "
					   "*"
					   name2
					   "= "
					   "make_matrix("
					   (car len)
					   ","
					   (second len)
					   ");"
					   "int "
					   *data*
					   "[]["
					   (second len)
					   "]"
					   "="
					   "{" (format nil "~{~a~^,~}" (mapcar (lambda (n) (format nil "{~a}" n)) els2))
					   "}"
					   ";"
					   "matrix "
					   "*"
					   name
					   "="
					   "initialize_matrix("
					   name2
					   ","
					   (second len)
					   ","
					   *data*
					   ");")))
					
	    expression))))

	  

(defun symbol->string (s)
  (string-downcase (symbol-name s)))

(defun get-nums (vec)
  (let ((ns (mapcar (lambda (num) (c-number-n num)) (c-vector-elements vec))))
    (format nil "~{~A~^, ~}" ns)))

(defun make-matrix-str (lst)
    (cond ((null lst) "}")
           (t (concatenate 'string (car lst) (make-matrix-str (cdr lst))))))

(defun get-numbers (nums)
  (let ((ns (mapcar (lambda (num) (c-number-n num)) nums)))
	(format nil "~{~A~^, ~}" ns)))

(defun get-matrix-numbers (nums)
    (format nil "~{~A~^, ~}" nums))

