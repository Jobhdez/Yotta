(in-package #:yotta)

(deftype token ()
  `(cons keyword t))

(defun tok (type &optional val)
  (cons type val))

(alexa:define-string-lexer linear-algebra-lexer
    "Make a lexical analyzer for linear algebra expressions."
  ((:num "\\d+")
   (:name "[A-Za-z][A-Za-z0-9_]*"))
  ("{{NAME}}"  (return (tok :variable (intern (string-upcase $@) "YOTTA-VAR"))))
  ("{{NUM}}"   (return (tok :number   (parse-integer $@))))
  ("\\+"       (return (tok :plus     (intern $@ 'keyword))))
  ("\\-"       (return (tok :minus    (intern $@ 'keyword))))
  ("\\*"       (return (tok :mul      (intern $@ 'keyword))))
  ("\\["       (return (tok :left-bracket)))
  ("\\]"       (return (tok :right-bracket)))
  ("\\="       (return (tok :assignment)))
  ("\\s+"      nil))

(defun token-generator (toks)
 "Make a lexer that is compatible with CL-YACC."
  (lambda ()
    (if (null toks)
	(values nil nil)
	(let ((tok (pop toks)))
	  (values (token-type tok)
		  (token-value tok))))))

(defun token-type (tok)
  "returns the type the token TOK."
  (car tok))


(defun token-value (tok)
  "Returns the value of the token TOK."
  (cdr tok))


(defun lex-line (string)
  "Make a list of tokens given the expression represented as a string."
  (loop :with lexer := (linear-algebra-lexer string)
	:for tok := (funcall lexer)
	:while tok
	  :collect tok))
