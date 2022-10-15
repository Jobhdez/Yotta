(in-package #:yotta)

(defstruct program expressions)

(defstruct plus left-exp right-exp)

(defstruct minus left-exp right-exp)

(defstruct mul left-exp right-exp)
  
(defstruct vec entries)

(defstruct matrix entries)

(defstruct num num)

(defstruct var var)

(defstruct assignment variable exp)
