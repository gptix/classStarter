(setf person-records ())

(let ((person-serializer 0))
  (defun new-person-serial () (incf person-serializer))
  (defun reset-person-serializer () (setq serializer 0)))

(defun make-person (name phone-number email-address)
  (push (list :person-serial (new-person-serial)
	      :name name
	      :phone-number phone-number
	      :email-address email-address)
	person-records))

(make-person "Lori" "800-222-3333" "lori@somewhere.xom")

(make-person "Ram" "800-444-5555" "ram@somewhere.xom")
;;-----------------------------------------------------------------
(setf bid-records ())

(let ((bid-serializer 0))
  (defun new-bid-serial () (incf bid-serializer))
  (defun reset-bid-serializer () (setq serializer 0)))

(defun make-bid (name lesson-event seats-desired price-per)
  (list :bid-serial (new-bid-serial)
	:name name
	:lesson-event lesson-event
	:seats-desired seats-desired
	:price-per price-per))

(setf a-bid (make-bid "Lori" 1 2 30))

(setf another-bid (make-bid "Ram" 1 1 25))
;;-----------------------------------------------------------------
(setf lesson-event-records ())

(let ((lesson-event-serializer 0))
  (defun new-lesson-event-serial () (incf lesson-event-serializer))
  (defun reset-lesson-event-serializer () (setq serializer 0)))

(defun make-lesson-event (name min-price min-rev max-seats)
  (push (list :lesson-event-serial (new-lesson-event-serial)
	      :name name
	      :min-price min-price
	      :min-rev min-rev
	      :max-seats max-seats
	      :bids ())
	lesson-event-records))

(make-lesson-event "Arduino" 15 150 10)
(make-lesson-event "Welding" 100 240 3)

(setf lesson-events nil)

;;-----------------------------------------------------------------
(setf market ())

(defun bid-on-lesson (lesson-serial person-serial seats-desired price-per)
  (push (make-bid person-serial lesson-serial seats-desired price-per)
    market))

(defun add-bid (&key lesson-event-serial person-serial seats-desired price-per)
  "Add a bid to a market for a lesson event. a bid should identify the id of the lesson, 
the name of the bidder, the number of seats desired, and the amount bid per seat."
  (push (list :person-serial person-serial :seats-desired seats-desired :price-per price-per)
	(getf
	 (car
	  (remove-if-not
	   (lambda (r) (= lesson-event-serial (getf r :lesson-event-serial)))
	   lesson-event-records))
	 :bids)))


(defun revenue-per-bid (bid)
  (* (getf bid :seats-desired) (getf bid :price-per)))

(defun total-revenue-per-lesson-event (&key lesson-event-serial)
  (reduce #'+ (mapcar #'revenue-per-bid
		      (getf (car (remove-if-not
				  (lambda (r) (= lesson-event-serial (getf r :lesson-event-serial)))
				  lesson-event-records))
			    :bids))))
  lesson-event-serial)
