(in-package #:yotta)

(defun normal-sum (v v2)
  (defvar v3 (make-array (array-dimension v 0)))
  (loop for i from 0 to (- (array-dimension v 0) 1)
    do (setf (aref v3 i) (+ (aref v i) (aref v2 i)))))

(defun normal-sum-declare (v v2)
  (declare (optimize (speed 3) (safety 0)))
  (declare (type array v v2))
  (defvar v3 (make-array (array-dimension v 0)))
  (loop for i from 0 to (- (array-dimension v 0) 1)
         do  (setf (aref v3 i) (+ (aref v i) (aref v2 i)))))

(defun unrolled-sum (v v2)
  (defvar v3 (make-array (array-dimension v 0)))
  (loop for i from 0 to (- (array-dimension v 0) 1) by 2
	do (progn (setf (aref v3 i) (+ (aref v i) (aref v2 i)))
		  (setf (aref v3 (+ i 1)) (+ (aref v (+ i 1)) (aref v2 (+ i 1)))))))


(defun unrolled-sum-declare (v v2)
  (declare (optimize (speed 3) (safety 0)))
  (declare (type array v v2))
  (defvar v3 (make-array (array-dimension v 0)))
  (loop for i from 0 to (- (array-dimension v 0) 1) by 2
	do (progn (setf (aref v3 i) (+ (aref v i) (aref v2 i)))
		  (setf (aref v3 (+ i 1)) (+ (aref v (+ i 1)) (aref v2 (+ i 1)))))))

(defvar vt (make-array 1000))
(defvar elements (loop for i from 1 to 1000
		       collect i))
(defvar testv (make-array 1000 :initial-contents elements))
