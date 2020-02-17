#|
https://github.com/fukamachi/mito/
https://lispcookbook.github.io/cl-cookbook/databases.html
|#




(ql:quickload 'mito)

(mito:connect-toplevel :sqlite3 :database-name "/home/gt/test.sqlite3")

(mito:deftable person2 ()
  ((name :col-type (:varchar 64))
   (email :col-type (or (:varchar 128) :null)) 
   (paypal-email :col-type (or (:varchar 128) :null))
   (phone-number :col-type (or (:varchar 15) :null))
   (role :col-type role)))


(mito:ensure-table-exists 'role)

(mito:deftable role ()
  ((name :col-type (:varchar 64))
   ))

(mito:deftable event-class ()
  ((name :col-type (:varchar 64))
   (description  :col-type :bytea)
   (materials  :col-type :bytea)
   (prerequisites  :col-type :bytea)
   (time-required-minutes :col-type :integer)
))

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
