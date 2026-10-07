(define-module (services ly)
  #:use-module (gnu)
  #:use-module (gnu services)
  #:use-module (gnu services configuration)
  #:use-module (gnu services shepherd)
  #:use-module (gnu system pam)
  #:use-module (gnu packages bash)
  #:use-module (gnu packages linux)
  #:use-module (my-packages ly)
  #:use-module (guix gexp)
  #:export (ly-configuration ly-configuration? ly-configuration-ly
            ly-configuration-tty ly-service-type))

(define-configuration/no-serialization ly-configuration
  (ly (package ly) "The Ly display manager package.")
  (tty (string "tty2") "The virtual terminal on which Ly runs."))

(define (ly-pam-service _config)
  (list (unix-pam-service "ly"
                          #:login-uid? #t
                          #:allow-empty-passwords? #f)))

(define (ly-shepherd-service config)
  (let* ((package (ly-configuration-ly config))
         (tty (ly-configuration-tty config))
         (device (string-append "/dev/" tty)))
    (list
     (shepherd-service
      (documentation "Run the Ly display manager.")
      (provision (list 'display-manager
                       (symbol-append 'term- (string->symbol tty))))
      (requirement '(user-processes host-name udev virtual-terminal elogind pam))
      (start
       #~(make-forkexec-constructor
          (list #$(file-append bash-minimal "/bin/sh")
                "-c"
                (string-append
                 "exec " #$(file-append util-linux "/bin/setsid")
                 " -c " #$(file-append package "/bin/ly")
                 " < " #$device " > " #$device " 2>&1")))
      (stop #~(make-kill-destructor))))))

(define ly-service-type
  (service-type
   (name 'ly)
   (extensions
    (list (service-extension shepherd-root-service-type ly-shepherd-service)
          (service-extension pam-root-service-type ly-pam-service)))
   (default-value (ly-configuration))
   (description
    "Run Ly as the system display manager on a dedicated virtual terminal.")))
