(define-module (my-packages mcfly)
  #:use-module (guix build-system gnu)
  #:use-module (guix download)
  #:use-module (guix licenses)
  #:use-module (guix packages))

(define-public mcfly
  (package
    (name "mcfly")
    (version "0.9.4")
    (source
     (origin
       (method url-fetch)
       (uri "https://github.com/cantino/mcfly/releases/download/v0.9.4/mcfly-v0.9.4-x86_64-unknown-linux-musl.tar.gz")
       (sha256
        (base32 "jkldwybmih6jcni5pg9qg0dwkhqb8kd88saaf321il6j02d0k8w1"))))
    (build-system gnu-build-system)
    (arguments
     (list
      #:tests? #f
      #:phases
      #~(modify-phases %standard-phases
          (delete 'configure)
          (delete 'build)
          (delete 'check)
          (replace 'install
            (lambda _
              (let ((binary (car (find-files "." "^mcfly$"))))
                (install-file binary
                              (string-append #$output "/bin/mcfly"))))))))
    (home-page "https://github.com/cantino/mcfly")
    (synopsis "Fly through your shell history")
    (description
     "McFly replaces the default Ctrl-R shell history search with an intelligent
search engine that takes working directory and recent command context into
account.")
    (license expat)))
