(ql:quickload 'sqlite)

(defpackage classstarter
  (:use :common-lisp :sqlite))

(in-package :classstarter)

;; Establish connection to database

(setf *db* (sqlite:connect "/home/gt/test.sqlite3"))

(setf *table-defs* (list "create table person 
 (id integer primary key, 
  name not null, 
  paypal_email not null,
  other_email null,
  phone null, 
  type not_null)" 

  "create table lesson_definition
  (id integer primary key, 
  name not null, 
  hyperlink null,
  description not null)" 

  "create table scheduled_event
  (id integer primary key, 
  lesson_def_id not null,
  date not null, 
  venue not null,
  min_rev not null,
  max_students not null,
  suggested_min not_null,
  FOREIGN KEY(lesson_def_id) 
  REFERENCES lesson_definition(id))"

 "CREATE TABLE bids
 (id integer PRIMARY KEY,
 person_id not null,
 date not null,
 scheduled_event_id not null,
 seats_desired not null,
 bid_per_seat not null,
 FOREIGN KEY(scheduled_event_id) REFERENCES scheduled_event(id),
 FOREIGN KEY(person_id) REFERENCES person(id))" )

      
(defun make-tables ()
  (loop :for str :in *table-defs*
	:do (execute-non-query *db* str)))


 "insert into lesson_definition (name, hyperlink, description)
values (?, ?, ?)" "Arduino" "hyperlink" "Cool."


(make-lesson "Arduino" "www.freeeside-atlanta.org")



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
