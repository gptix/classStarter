(in-package :classstarter)

(load #P"/home/gt/table-classes.lisp")
(load #P"/home/gt/base-data.lisp")

(defun prompt-read (prompt)
  (format *query-io* "~a: " prompt)
  (force-output *query-io*)
  (read-line *query-io*))

(defun make-record-role (name)
  (let ((my_role (make-instance 'role :name name)))
    (mito:insert-dao my_role)))

(defun make-record-person (name role-id paypal-email email phone-number)
  (let* ((my_role (mito:find-dao 'role :id role-id))
	 (pers (make-instance 'person :name name
				      :role my_role
				      :paypal_email paypal-email
				      :email email
				      :phone_number phone-number)))
    (mito:insert-dao pers)))


(defun prompt-for-person ()
  (make-record-person
   (prompt-read "Name")
   (prompt-read "Role: 1 for Instructor, 2 for Person")
   (prompt-read "Email used for Paypal")
   (prompt-read "Other Email")
   (prompt-read "Phone")
   ))

(defun make-record-venue (name)
  (let ((my_venue (make-instance 'venue :name name)))
    (mito:insert-dao my_venue)))

(defun make-record-occurrence (venue-id date start stop attendee-max min-fee min-revenue)
  (let ((my-venue (mito:find-dao 'venue :id venue-id))
	(my_occurrence (make-instance 'occurrence :venue my-venue
						  :date date
						  :start start
						  :stop stop
						  :attendee_max attendee-max
						  :min_fee min-fee
						  :min_revenue min-revenue)))
    (mito:insert-dao my_occurrence)))



(defun prompt-for-occurrence ()
  (make-record-occurrence
   (prompt-read  "venue code") 
   (prompt-read "date nm")
   (prompt-read "start time")
   (prompt-read "stop time")
   (prompt-read "attendee max")
   (prompt-read "min fee")
   (prompt-read "min rev")))


(defun prompt-for-person ()
  (make-record-person
   (prompt-read "Name")
   (prompt-read "Role: 1 for Instructor, 2 for Person")
   (prompt-read "Email used for Paypal")
   (prompt-read "Other Email")
   (prompt-read "Phone")
   ))


(defun make-record-bid (occurrence-id person-id seats bid-per)
  (let* ((my-occurrence (mito:find-dao 'occurrence :id occurrence-id))
	 (my-person (mito:find-dao 'person :id person-id))
	 (my-bid (make-instance 'bid :occurrence my-occurrence
				     :attendee my-person
				     :seat_count seats
				     :bid_per_seat bid-per)))
    (mito:insert-dao my-bid)))

(defun prompt-for-bid ()
  (make-record-person
   (prompt-read "Occurrence ID")
   (prompt-read "PersonID")
   (prompt-read "Seats Desired")
   (prompt-read "Bids per Seat")
   ))
