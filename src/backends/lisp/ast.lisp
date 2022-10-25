(in-package #:yotta)


"""
These are the nodes for the `lispIL` abstrax syntax tree -- i.e., intermediate language which
transoforms the parse tree, a high level intermediate language.
"""

;;--------------------------------------------------------
;;; lispIL ast nodes:
;;--------------------------------------------------------

(defstruct defvarlisp
  "DEFVARLISP node."
  var
  exp)

(defstruct vectorlisp
  "VECTORLISP node."
  dimension
  elements)

(defstruct matrixlisp
  "MATRIXLISP node."
  dimension
  matrix)

(defstruct numlisp
  "NUMLISP node."
  n)

(defstruct looplisp
  "LOOPLISP node."
  i
  n
  exp)

(defstruct (vectorsum (:include looplisp))
  "VECTORSUM node."
  leftexp
  rightexp)

(defstruct (vectorminus (:include looplisp))
  "VECTOR-MINUS node."
  leftexp
  rightexp)

(defstruct (matrixsum (:include looplisp))
  "MATRIXSUM node."
  leftexp
  rightexp)

(defstruct (matrixminus (:include looplisp))
  "MATRIXMINUS node."
  leftexp
  rightexp)

(defstruct (matrixmul (:include looplisp))
  "MATRIXMINUS node."
  leftexp
  rightexp)

(defstruct prognlisp
  "PROGNLISP node."
  expressions)

(defstruct setqlisp
  "SETQLISP node."
  var
  exp)

(defstruct setflisp
  "SETFLISP node."
  var
  exp)

(defstruct lengthlisp
  "LENGTHLISP node."
  exp)

(defstruct areflisp
  "AREFLISP node."
  array
  i)

(defstruct sumlisp
  "(primitive) SUMLISP node."
  leftexp
  rightexp)

(defstruct minuslisp
  "(primitive) MINUSLISP node."
  leftexp
  rightexp)

(defstruct mullisp
  leftexp
  rightexp)

(defstruct dotproduct
  "DOTPRODUCT node."
  expression
  vector1
  vector2)

(defstruct letexpression
  "LETEXPRESSION node."
  id
  expr
  body)

(defstruct fakevecmul
  "FAKEVECMUL node."
  vec
  vec2)

(defstruct incflisp
  id
  exp)

;;todo: matrixmul, crossproduct, dotproduct


