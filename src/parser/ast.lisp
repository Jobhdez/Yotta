(in-package #:yotta)

(defstruct program
  "A PROGRAM ast node."
  expressions)

(defstruct plus
  "A PLUS ast node."
  left-exp right-exp)

(defstruct minus
  "A MINUS ast node."
  left-exp right-exp)

(defstruct mul
  "A MULTIPLICATION ast node."
  left-exp right-exp)
  
(defstruct vec
  "A VECTOR ast node."
  entries)

(defstruct matrix
  "A MATRIX ast node."
  entries)

(defstruct num
  "A NUMBER ast node."
  num)

(defstruct var
  "A VARAIABLE ast node."
  var)

(defstruct assignment
  "An ASSIGNMENT ast node."
  variable exp)
