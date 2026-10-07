(define-module (home services dotfiles)
  #:use-module (gnu home services)
  #:use-module (guix gexp)
  #:use-module (guix records)
  #:export (home-dotfiles-configuration home-dotfiles-service-type))

(define-record-type* <home-dotfiles-configuration>
  home-dotfiles-configuration make-home-dotfiles-configuration
  home-dotfiles-configuration?
  (home-directory home-dotfiles-configuration-home-directory)
  (config-directory home-dotfiles-configuration-config-directory))

(define (dotfiles-activation config)
  (let ((home-source
         (home-dotfiles-configuration-home-directory config))
        (config-source
         (home-dotfiles-configuration-config-directory config)))
    #~(begin
        (use-modules (guix build utils))
        (let ((home (getenv "HOME"))
              (config (string-append (getenv "HOME") "/.config")))
          (copy-recursively #$home-source home)
          (mkdir-p config)
          (copy-recursively #$config-source config)))))

(define home-dotfiles-service-type
  (service-type
   (name 'home-dotfiles)
   (extensions
    (list (service-extension home-activation-service-type dotfiles-activation)))
   (default-value #f)
   (description
    "Copy the home and configuration dotfile trees into the user's home directory as mutable overlays; preserve files not present in the sources.")))
