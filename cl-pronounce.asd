;;;; cl-pronounce.asd

(asdf:defsystem #:cl-pronounce
  :description "Written English numbers as a service"
  :author "inaimathi <leo.zovic@gmail.com>"
  :license "AGPL3"
  :version "0.0.1"
  :serial t
  :depends-on (#:cl-handlers #:woo #:alexandria #:cl-who #:parenscript)
  :components ((:file "package")
	       (:file "util")
               (:file "cl-pronounce")))

