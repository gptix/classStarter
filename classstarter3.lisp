#|
https://github.com/fukamachi/mito/
https://lispcookbook.github.io/cl-cookbook/databases.html
https://xach.livejournal.com/278047.html
|#

(in-package :classstarter)

(mito:connect-toplevel :sqlite3 :database-name "/home/gt/test.sqlite3")

(mito:deftable role ()
  ((name :col-type (:varchar 64))))

(mito:deftable person ()
  ((name :col-type (:varchar 64))
   (email :col-type (or (:varchar 128) :null)) 
   (paypal-email :col-type (or (:varchar 128) :null))
   (phone-number :col-type (or (:varchar 15) :null))
   (role :col-type role)))

(mito:deftable event-class ()
  ((name :col-type (:varchar 64))
   (description  :col-type :bytea)
   (materials  :col-type :bytea)
   (prerequisites  :col-type :bytea)
   (time-required-minutes :col-type :integer)))

(mito:deftable venue ()
  ((name :col-type (:varchar 64))))

(mito:deftable occurence ()
  ((venue :col-type venue)
   (date :col-type :integer)
   (start :col-type :integer)
   (stop :col-type :integer)
   (attendee-max :col-type :integer)
   (min-fee :col-type :integer)
   (min-revenue :col-type :integer)))

(mito:deftable bid ()
  ((occurence :col-type occurence)
   (attendee :col-type person)
   (seat-count :col-type :integer)
   (bid-per-seat :col-type :integer)))

(mapc #'mito:execute-sql (mito:table-definition 'role))
(mapc #'mito:execute-sql (mito:table-definition 'person))
(mapc #'mito:execute-sql (mito:table-definition 'event-class))
(mapc #'mito:execute-sql (mito:table-definition 'venue))
(mapc #'mito:execute-sql (mito:table-definition 'occurence))
(mapc #'mito:execute-sql (mito:table-definition 'bid))

(mito:connect-toplevel :sqlite3 :database-name "/home/gt/test.sqlite3")

(defun create-roles (role-names)
  (mapc (lambda (x) (mito:create-dao 'role :name x)) role-names))

(setf role-namen '("Instructor" "Student"))

(create-roles role-namen)

(defun create-person ()
  (mito:create-dao 'person :name "Jud Taylor" :paypal-email "notreal@gmail.com" :role 1))
