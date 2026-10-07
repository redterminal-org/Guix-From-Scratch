(define-module (home services dotfiles)
  #:use-module (gnu home services)
  #:use-module (guix gexp)
  #:use-module (guix records)
  #:export (home-dotfiles-configuration home-dotfiles-service-type))

(define-record-type* <home-dotfiles-configuration>
  home-dotfiles-configuration make-home-dotfiles-configuration
  home-dotfiles-configuration?
  (source-directory home-dotfiles-configuration-source-directory))

(define (dotfiles-activation config)
  (let ((source (home-dotfiles-configuration-source-directory config)))
    #~(begin
        (use-modules (guix build utils))
        (let ((target (string-append (getenv "HOME") "/.config")))
          (mkdir-p target)
          (copy-recursively #$source target)))))

(define home-dotfiles-service-type
  (service-type
   (name 'home-dotfiles)
   (extensions
    (list (service-extension home-activation-service-type dotfiles-activation)))
   (default-value #f)
   (description "Copy a configuration tree into ~/.config as a mutable overlay; preserve files not present in the source.")))
