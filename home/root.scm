(define-module (home root)
  #:use-module (home common)
  #:use-module (my-packages mcfly)
  #:export (root-home-environment))

(define root-home-environment
  (make-home-environment
   #:packages (list mcfly)
   #:private-data? #f))
