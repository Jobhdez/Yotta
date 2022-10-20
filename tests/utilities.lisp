(in-package #:yotta-tests)

(defun run-yotta-tests ()
  (run-package-tests
   :packages '(:yotta-tests)
   :interactive t))
