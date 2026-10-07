(define-module (my-packages gemget)
  #:use-module (gnu build-system go)
  #:use-module (gnu packages golang)
  #:use-module (guix git-download)
  #:use-module (guix licenses)
  #:use-module (guix packages))

(define-public gemget
  (package
    (name "gemget")
    (version "1.9.0")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/makew0rld/gemget")
             (commit (string-append "v" version))))
       (file-name (git-file-name name version))
       (sha256
        (base32 "03x9apk73lwyafc4fd2vs033z7vcpk4k0jf97452l7pnlx2v57rz"))))
    (build-system go-build-system)
    (native-inputs
     (list go-github-com-dustin-go-humanize
           go-github-com-makeworld-the-better-one-go-gemini
           go-github-com-makeworld-the-better-one-go-gemini-socks5
           go-github-com-schollz-progressbar-v3
           go-github-com-spf13-pflag))
    (arguments
     (list
      #:install-source? #f
      #:import-path "github.com/makeworld-the-better-one/gemget"))
    (home-page "https://github.com/makew0rld/gemget")
    (synopsis "Command line downloader for the Gemini protocol")
    (description
     "Gemget is a command line downloader for the Gemini protocol.
It works well with streams and can print headers for debugging as well.")
    (license expat)))
