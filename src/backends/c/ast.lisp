(in-package #:yotta)

;;;; ast nodes for the c intermediate language

(defstruct c-assignment
  type
  var-name
  exp)

(defstruct c-vector
  type
  length
  elements
  name)

(defstruct c-number
  type
  n)

(defstruct c-matrix
  type
  length
  elements
  name)

(defstruct c-vector-addition
  left-exp
  right-exp
  i
  n
  fn-name
  type)

(defstruct c-vector-subtraction
  left-exp
  right-exp
  i
  n
  fn-name
  type)

(defstruct c-matrix-addition
  left-exp
  right-exp
  dimension)

(defstruct c-matrix-subtraction
  left-exp
  right-exp
  dimension)
