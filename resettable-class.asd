;;;; resettable-class.asd
#-asdf3 (error "This project requires ASDF 3")

(asdf:defsystem #:resettable-class
  :description "A metaclass for classes whose instances can be reset using `reinitialize-instance`."
  :author "Omri"
  :license  "TODO"
  :class :package-inferred-system
  :defsystem-depends-on (:asdf-package-system)
  :version "0.0.1"
  :depends-on (#:closer-mop
               #:resettable-class))
