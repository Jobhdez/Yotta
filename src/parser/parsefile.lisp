(in-package #:yotta)

(defun parse-file (filename)
  "Given the name of a file parse the file."
  (let* ((file-string (read-file-into-string filename))
	 (tokens (lex-line file-string))
	 (ast (parse-with-lexer (token-generator tokens)
				*linear-algebra-grammar*)))
    ast))
    
