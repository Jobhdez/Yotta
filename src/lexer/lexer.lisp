(in-package #:yotta)

(deftype token ()
  `(cons keyword t))

(defun tok (type &optional val)
  (cons type val))

(alexa:define-string-lexer linear-algebra-lexer
    "Make a lexical analyzer for linear algebra expressions."
  ((:num "\\d+")
   (:name "[A-Za-z][A-Za-z0-9_]*"))
  ("{{NAME}}"  (return (tok :variable (intern $@))))
  ("{{NUM}}"   (return (tok :number   (parse-integer $@))))
  ("\\+"       (return (tok :plus     (intern $@ 'keyword))))
  ("\\-"       (return (tok :minus    (intern $@ 'keyword))))
  ("\\*"       (return (tok :mul      (intern $@ 'keyword))))
  ("\\["       (return (tok :left-bracket)))
  ("\\]"       (return (tok :right-bracket)))
  ("\\="       (return (tok :assignment)))
  ("\\s+"      nil))

(defun lex-line (string)
  (loop :with lexer := (linear-algebra-lexer string)
	:for tok := (funcall lexer)
	:while tok
	  :collect tok))
