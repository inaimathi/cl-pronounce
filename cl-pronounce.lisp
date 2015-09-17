;;;; cl-pronounce.lisp
(in-package #:cl-pronounce)

(define-handler (v1/integer/-num=integer) ()
  (format nil "~r" num))

(define-handler (v1/ratio/-num=integer/-denom=integer) ()
  (format nil "~r over ~r" num denom))

(define-handler (v1/float/-num=string) ()
  (multiple-value-bind (int off) (parse-integer num :junk-allowed t)
    (format nil "~r point ~{~r~^ ~}"
	    int (loop for i from (+ off 1) while (> (length num) i)
		   collect (parse-integer num :start i :end (+ i 1))))))

(define-handler (v1/magic/-num=string) ()
  (multiple-value-bind (int off) (parse-integer num :junk-allowed t)
    (cond ((= (length num) off)
	   (format nil "~r" int))
	  ((and (eql #\. (char num off))
		(const-ish? num +pi-str+))
	   (const num "pi"))
	  ((and (eql #\. (char num off))
		(const-ish? num +tau-str+))
	   (const num "tau"))
	  ((eql #\. (char num off))
	   (format nil "~r point ~{~r~^ ~}"
		   int (loop for i from (+ off 1) while (> (length num) i)
			  collect (parse-integer num :start i :end (+ i 1))))))))

(define-handler (v1/magic/-num=integer/-denom=integer) ()
  (format nil "~r over ~r" num denom))

(defun start (&key (port 5000))
  (woo:run (make-app) :port port))

