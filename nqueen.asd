;; (require \'asdf)

(in-package :cl-user)
(defpackage nqueen-asd
  (:use :cl :asdf))
(in-package :nqueen-asd)

(defsystem :nqueen
  :version "1.0.0"
  :author "wasu"
  :license "MIT"
  :components ((:file "package")
			   (:module "src" :components ((:file "nqueen")))))
