(define-module (home root)
  #:use-module (home common)
  #:use-module (my-packages mcfly)
  #:use-module (my-packages todo-txt-cli)
  #:export (root-home-environment))

(define root-home-environment
  (make-home-environment
   #:packages (list mcfly todo-txt-cli)
   #:private-data? #f))
