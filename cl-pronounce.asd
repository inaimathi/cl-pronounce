;;;; cl-pronounce.asd

(asdf:defsystem #:cl-pronounce
  :description "Describe cl-pronounce here"
  :author "Your Name <your.name@example.com>"
  :license "Specify license here"
  :serial t
  :depends-on (#:cl-handlers #:woo #:alexandria)
  :components ((:file "package")
	       (:file "util")
               (:file "cl-pronounce")))

