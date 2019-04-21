;; (require \'asdf)
 
 (in-package :cl-user)
 (defpackage nqueen-test-asd
 (:use :cl :asdf))
 (in-package :nqueen-test-asd)
 
 (defsystem nqueen-test
 :depends-on (:nqueen)
 :version "1.0.0"
 :author "wasu"
 :license "MIT"
 :components ((:module "t" :components ((:file "nqueen-test"))))
 :perform (test-op :after (op c)
 (funcall (intern #.(string :run) :prove) c)))

