;;;; resettable-class.lisp

(defpackage resettable-class
  (:nicknames #:rc)
  (:use #:cl)
  (:export :resettable-class))
(in-package #:resettable-class)


(defclass resettable-class (standard-class) ())

(defmethod c2mop:validate-superclass ((class resettable-class)
                                      (superclass standard-class))
  t)

(defun reset-instance (instance &rest initargs)
  (let* ((slots (c2mop:class-slots (class-of instance)))
         (names (mapcar #'c2mop:slot-definition-name slots)))
    (mapcar (lambda (slot) (slot-makunbound instance slot)) names)
    (apply #'initialize-instance instance initargs)))

(defmethod initialize-instance :after ((class resettable-class) &key)
  (let* ((method-lambda (c2mop:make-method-lambda
                         #'reinitialize-instance
                         (c2mop:class-prototype (find-class 'standard-method))
                         '(lambda (instance &rest initargs)
                           (apply #'reset-instance instance initargs))
                         nil))
         (method (make-instance 'standard-method
                                :qualifiers '()
                                :specializers (list class)
                                :lambda-list '(instance &rest initargs)
                                :function (compile nil method-lambda))))
    (add-method #'reinitialize-instance method)))
