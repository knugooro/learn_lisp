
(defun make-film (title year) 
	(list :title title :year year))

(defvar *filmDB* nil)

(defun add-film (film) 
	(push film *filmDB*))

(defun show-films ()  
	(dolist (film *filmDB*)
		(format t "~{~a:~8t~a~%~}~%" film )))

(defun prompt-read (prompt)
	(format *query-io* "~a: " prompt)
	(force-output *query-io*)
	(read-line *query-io*))

(defun prompt-for-film ()
	(make-film 
		(prompt-read "title: ")
		(prompt-read "year: ")))

(defun add-films ()
	(loop (add-film (prompt-for-film))
		(if (not(y-or-n-p "Another? ")) (return))))

(defun help () (format t "type:~%~5ta for adding new films~%~5ts for saving the database~%~5te for exit.~%~5to for show films in database~%"))

(defun get-input () 
	(format *query-io* "What do next? ")
	(force-output *query-io*)
	(read-line *query-io*))

(defun file-name () "filmDatabase.txt")


(defun main ()
    (loop (defparameter input (get-input))
	(cond ((string-equal input "h") (help))
		((string-equal input "a") (add-films))
		((string-equal input "o") (show-films))
		((string-equal input "s") (save-films (file-name)))
		((string-equal input "e") (exit)))))

(defun save-films (filename) 
	(with-open-file (out filename :direction :output :if-exists :supersede)
		(with-standard-io-syntax (print *filmDB* out))))


(defun load-films (filename)
	(with-open-file (in filename)
		(with-standard-io-syntax (setf *filmDB* (read in)))))

(load-films (file-name))
(main)




