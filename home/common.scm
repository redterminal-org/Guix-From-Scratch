(define-module (home common)
  #:use-module (gnu home)
  #:use-module (gnu home services)
  #:use-module (gnu packages)
  #:use-module (guix gexp)
  #:use-module (home services dotfiles)
  #:use-module (home services private-data)
  #:export (make-home-environment))

(define* (make-home-environment #:key (packages '()) (private-data? #t))
  (home-environment
    (packages
     (specifications->packages packages))
    (services
     (append
      (list
       (service home-activation-service-type
                #~(system* #$(file-append (specification->package "pipx")
                                          "/bin/pipx")
                           "upgrade" "--install" "rogallo"))
       (service home-dotfiles-service-type
                (home-dotfiles-configuration
                 (home-directory
                  (local-file "../dotfiles/home" #:recursive? #t))
                 (config-directory
                  (local-file "../dotfiles/config" #:recursive? #t))))
      (if private-data?
          (list (service home-private-data-service-type))
          '())))))
