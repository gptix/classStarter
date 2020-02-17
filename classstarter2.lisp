(in-package "COMMON-LISP-USER")

(ql:quickload 'sqlite)

(defpackage classstarter
  (:use :common-lisp :sqlite))

(in-package :classstarter)

;; Establish connection to database

(setf *db* (sqlite:connect "/home/gt/test.sqlite3"))

(load "table-def-strings.lisp")



(defun make-tables ()
  (loop :for str :in *table-defs*
	:do (execute-non-query *db* str)))

      

(defun add-lesson-definition (name hyperlink description)
  (execute-non-query *db*
		     (format nil
			     "INSERT INTO lesson_definition (name, hyperlink, description) VALUES (~s, ~s, ~s)"
			     name hyperlink description)))



(defun add-person (name paypal_email other_email phone type) 
  (execute-non-query *db*
		     (format nil
			     "INSERT INTO person (name, paypal_email, other_email, phone, type) VALUES (~s, ~s, ~s, ~s, ~s)"
			     name paypal_email other_email phone type)))





(defun add-bid (name paypal_email other_email phone type) 
  (execute-non-query *db*
		     (format nil
			     "INSERT INTO person (name, paypal_email, other_email, phone, type) VALUES (~s, ~s, ~s, ~s, ~s)"
			     name paypal_email other_email phone type)))






#|

(execute-non-query *db* "insert into users (user_name, age) values (?, ?)" "joe" 18)

(execute-non-query/named *db* "insert into users (user_name, age) values (:user_name, :user_age)" 
                         ":user_name" "dvk" ":user_age" 22)
(execute-non-query *db* "insert into users (user_name, age) values (?, ?)" "qwe" 30)
(execute-non-query *db* "insert into users (user_name, age) values (?, ?)" nil nil) ;; ERROR: constraint failed



(execute-single *db* "select id from users where user_name = ?" "dvk")

(execute-one-row-m-v *db* "select id, user_name, age from users where user_name = ?" "joe")

                           "insert into lesson_definition (name, hyperlink, description) values (?, ?, ?)" "Welding" "www" "Cool."

|#
