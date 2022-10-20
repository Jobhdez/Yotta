(fiasco:define-test-package #:yotta-tests
    (:documentation "Tests for Yotta.")
  (:use #:cl
	#:yotta)
  (:export #:run-yotta-tests))
