(define-module (my-packages todo-txt-cli)
  #:use-module (gnu build-system gnu)
  #:use-module (gnu packages bash)
  #:use-module (guix download)
  #:use-module (guix licenses)
  #:use-module (guix packages))

(define-public todo-txt-cli
  (package
    (name "todo-txt-cli")
    (version "2.14.0")
    (source
     (origin
       (method url-fetch)
       (uri "https://github.com/todotxt/todo.txt-cli/releases/download/v2.14.0/todo.txt_cli-2.14.0.tar.gz")
       (sha256
        (base32 "ogtqh3f7pgqwh4nktobr47va4ybwzw5qn7p4nnodkavwe7x3q46q"))))
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
              (install-file "todo.sh"
                            (string-append #$output "/bin/todo.sh"))
              (install-file "todo.cfg"
                            (string-append #$output "/share/todo.txt-cli"))
              (install-file "todo_completion"
                            (string-append
                             #$output
                             "/share/bash-completion/completions/todo.sh"))))))))
    (inputs
     (list bash-minimal))
    (home-page "https://github.com/todotxt/todo.txt-cli")
    (synopsis "Command-line interface for managing todo.txt files")
    (description
     "Todo.txt CLI is a simple and extensible shell script for managing
tasks stored in the todo.txt format.")
    (license gpl3+)))
