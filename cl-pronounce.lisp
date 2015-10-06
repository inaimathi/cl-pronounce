;;;; cl-pronounce.lisp
(in-package #:cl-pronounce)

(define-handler (v1/integer/-num=integer) ()
  (pronounce-int num))

(define-handler (v1/ratio/-num=integer/-denom=integer) ()
  (pronounce-ratio num denom))

(define-handler (v1/float/-num=string) ()
  (multiple-value-bind (int off) (parse-integer num :junk-allowed t)
    (format nil "~a point ~{~r~^ ~}"
	    (pronounce-int int) (parse-to-digits num :start (+ off 1)))))

(define-handler (v1/magic/-num=string) ()
  (or (pronounce-non-ratio num)
      (progn (set-response-code! 400)
	     "Shrug. I dunno what that is.")))

(define-handler (v1/magic/-num=integer/-denom=integer) ()
  (pronounce-ratio num denom))

(define-handler (v1/speak/-num=string :content-type "text/html") ()
  (speak (or (pronounce-non-ratio num)
	     (progn (set-response-code! 400)
		    "Iunno."))))

(define-handler (v1/speak/-num=integer/-denom=integer :content-type "text/html") ()
  (speak (pronounce-ratio num denom)))

(defun speak (a-string)
  (with-html-output-to-string (s nil)
    (:html
     (:head
      (:script (str (ps* `(if window.speech-synthesis
			      (let ((msg (new (-speech-synthesis-utterance ,a-string))))
				(window.speech-synthesis.speak msg))
			      (alert "NO SPEECH SYNTH DETECTED"))))))
     (:body (str a-string)))))

(defun parse-to-digits (num-str &key start)
  (loop for i from start while (> (length num-str) i)
     collect (parse-integer num-str :start i :end (+ i 1))))

(defun pronounce-non-ratio (num)
  (multiple-value-bind (int off) (parse-integer num :junk-allowed t)
    (cond ((= (length num) off) (pronounce-int int))
	  ((and (eql #\. (char num off))
		(const-ish? num +pi-str+))
	   (const num "pi"))
	  ((and (eql #\. (char num off))
		(const-ish? num +tau-str+))
	   (const num "tau"))
	  ((eql #\. (char num off))
	   (format nil "~a point ~{~r~^ ~}"
		   (pronounce-int int) (parse-to-digits num :start (+ off 1))))
	  (t nil))))

(defun pronounce-ratio (num denom)
  (concatenate
   'string (pronounce-int num)
   " over " (pronounce-int denom)))

(defun pronounce-int (num)
  (handler-case
      (format nil "~r" num)
    (simple-error ()
      ;; TODO - a reasonable value here
      "a fuckton")))

(defun start (&key (port 5000))
  (woo:run (make-app) :port port))
