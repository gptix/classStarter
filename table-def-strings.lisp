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
 FOREIGN KEY(person_id) REFERENCES person(id))" ))

