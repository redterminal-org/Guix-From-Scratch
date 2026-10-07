(define-module (home daniel)
  #:use-module (home common)
  #:use-module (my-packages mcfly)
  #:export (daniel-home-environment))

(define daniel-home-environment
  (make-home-environment
   #:packages (list mcfly)))
