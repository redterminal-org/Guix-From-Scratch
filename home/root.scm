(define-module (home root)
  #:use-module (home common)
  #:export (root-home-environment))

(define root-home-environment
  (make-home-environment
   #:private-data? #f))