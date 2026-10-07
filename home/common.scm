(define-module (home common)
  #:use-module (gnu home)
  #:use-module (gnu home services)
  #:use-module (gnu home services shells)
  #:use-module (gnu packages)
  #:use-module (guix gexp)
  #:use-module (home services dotfiles)
  #:use-module (home services private-data))

(home-environment
  (packages
   (specifications->packages
    '("neovim" "git" "kitty" "starship" "yazi" "tmux")))
  (services
   (list
    (service home-activation-service-type
             #~(system* #$(file-append (specification->package "pipx")
                                       "/bin/pipx")
                        "upgrade" "--install" "rogallo"))
    (service home-bash-service-type
             (home-bash-configuration
              (bashrc (list (local-file "../dotfiles/bashrc")))))
    (service home-dotfiles-service-type
             (home-dotfiles-configuration
              (source-directory
               (local-file "../dotfiles/config" #:recursive? #t))))
    (service home-private-data-service-type))))
