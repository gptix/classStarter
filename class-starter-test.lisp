;;;; From ./package.lisp

(ql:quickload :mito)

(defpackage #:classstarter
  (:use
   #:common-lisp
   #:mito))

(in-package :classstarter)

(mito:connect-toplevel :sqlite3 :database-name "/home/gt/test.sqlite3")

(mito:deftable role ()
  ((name :col-type (:varchar 64))))

(mito:deftable person ()
  ((name :col-type (:varchar 64))
   (role :col-type role)))

(mapc #'mito:execute-sql (mito:table-definition 'role))
(mapc #'mito:execute-sql (mito:table-definition 'person))

(defun create-roles (role-names)
  (mapc (lambda (x) (mito:create-dao 'role :name x)) role-names))

;(setf role-namen '("Instructor" "Student"))

;(create-roles role-namen)

(defun create-person ()
  (mito:create-dao 'person :name "Jud Taylor" :role 1))
