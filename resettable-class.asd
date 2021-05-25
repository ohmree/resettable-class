;;;; resettable-class.asd

(asdf:defsystem #:resettable-class
  :description "A metaclass for classes whose instances can be reset using `reinitialize-instance`."
  :author "Omri"
  :license  "TODO"
  :version "0.0.1"
  :components ((:file "resettable-class"))
  :depends-on (#:closer-mop))
