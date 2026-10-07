(define-module (my-packages ly)
  #:use-module (gnu build-system zig)
  #:use-module (gnu packages linux)
  #:use-module (gnu packages pkg-config)
  #:use-module (gnu packages xorg)
  #:use-module (guix download)
  #:use-module (guix licenses)
  #:use-module (guix packages))

(define clap-source
  (origin
    (method url-fetch)
    (uri "https://github.com/Hejsil/zig-clap/archive/fc1e5cc3f6d9d3001112385ee6256d694e959d2f.tar.gz")
    (file-name "zig-clap-0.11.0.tar.gz")
    (sha256 (base32 "komfa3kahgjtieedzznkytjbx5j7nugokq3hw3fszpdpnsny4hqq"))))

(define termbox2-source
  (origin
    (method url-fetch)
    (uri "https://github.com/AnErrupTion/termbox2/archive/c7f241e8888ce243e1748b05c26a42fcfaaad936.tar.gz")
    (file-name "zig-termbox2.tar.gz")
    (sha256 (base32 "hxqgz5mmxnzjpcizq6fxwxkr4ysj56vnbq7isbrmyx6e5r3phu5q"))))

(define translate-c-source
  (origin
    (method url-fetch)
    (uri "https://codeberg.org/ziglang/translate-c/archive/7a1a9fdc4ab00835748a6657ecbb835e3d5d45f7.tar.gz")
    (file-name "zig-translate-c.tar.gz")
    (sha256 (base32 "57ob53aclu2mstxybt6hhe3ptit2hsnz2vg56pofpaadaxqxeevq"))))

(define zigini-source
  (origin
    (method url-fetch)
    (uri "https://github.com/AshAmetrine/zigini/archive/a665d081dda42664a96da2840ea09c5ccf9d0692.tar.gz")
    (file-name "zig-ini-0.5.0.tar.gz")
    (sha256 (base32 "14n0nz3wqsws14301wadiw2agfn2cg0lyhi72wqip15rr4dhfzp8"))))

(define-public ly
  (package
    (name "ly")
    (version "1.4.1")
    (source
     (origin
       (method url-fetch)
       (uri "https://github.com/fairyglade/ly/archive/refs/tags/v1.4.1.tar.gz")
       (sha256 (base32 "c37f6b6mpirzgceawfgzawedmrgnys2xjuobizrj624y52h3xk4q"))))
    (build-system zig-build-system)
    (native-inputs (list pkg-config))
    (inputs (list linux-pam libxcb))
    (arguments
     (list
      #:install-source? #f
      #:tests? #f
      #:zig-release-type "safe"
      #:zig-build-flags #~(list "-Ddefault_tty=2" "-Dfallback_tty=2")
      #:zig-inputs
      (list (cons "clap" clap-source)
            (cons "termbox2" termbox2-source)
            (cons "translate_c" translate-c-source)
            (cons "zigini" zigini-source))))
    (home-page "https://codeberg.org/fairyglade/ly")
    (synopsis "Lightweight TUI display manager")
    (description
     "Ly is a lightweight TUI display manager for Linux and BSD. It provides
a terminal-based login screen for graphical X11 and Wayland sessions.")
    (license wtfpl)))
