(define-module (home daniel)
  #:use-module (home common)
  #:use-module (my-packages mcfly)
  #:use-module (my-packages todo-txt-cli)
  #:export (daniel-home-environment))

(define daniel-home-environment
  (make-home-environment
   #:packages (list mcfly todo-txt-cli)))
