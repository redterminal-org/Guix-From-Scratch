(define-module (home services private-data)
  #:use-module (gnu home services)
  #:use-module (gnu packages)
  #:use-module (gnu packages gnupg)
  #:use-module (gnu packages ssh)
  #:use-module (gnu packages networking)
  #:use-module (gnu packages freedesktop)
  #:use-module (guix gexp)
  #:export (home-private-data-service-type))

;; This is intentionally a small Guix-native wrapper. The actual prompt/copy
;; policy mirrors the Nix module: one marker, Wofi prompts, SSH_ASKPASS, and
;; mutable ~/.ssh/.password-store/.local/share/rogallo data.

(define ssh-askpass
  (program-file
   "guix-ssh-askpass"
   #~(begin
       (let ((wofi #$(file-append wofi "/bin/wofi")))
         (format #t "~a\n" (getenv "SSH_ASKPASS_PROMPT"))
         (execl "/bin/sh" "sh" "-c"
                (string-append "printf '\\n' | " wofi
                               " --dmenu --password --prompt \"SSH password\" --cache-file /dev/null"))))))

(define private-data-script
  (program-file
   "import-private-data"
   #~(begin
       (use-modules (ice-9 popen) (ice-9 rdelim) (guix build utils))
       (define home (getenv "HOME"))
       (define marker (string-append home "/.local/state/.guix-private-data-import-marker"))
       (define tmpdir (string-append home "/.cache/guix-private-data"))
       (define wofi #$(file-append wofi "/bin/wofi"))
       (define notify #$(file-append libnotify "/bin/notify-send"))
       (define scp #$(file-append openssh "/bin/scp"))
       (define gpg #$(file-append gnupg "/bin/gpg"))
       (define nc #$(file-append netcat "/bin/nc"))
       (define (prompt text)
         (let* ((p (open-input-pipe
                    (string-append "printf '\\n' | " wofi
                                   " --dmenu --prompt \"" text
                                   "\" --cache-file /dev/null")))
                (v (read-line p)))
           (close-pipe p)
           (if (eof-object? v) "" v)))
       (define (note title body)
         (system* notify "-a" "Guix" title body))
       (unless (file-exists? marker)
         (mkdir-p (dirname marker))
         (let ((remote (prompt "Secrets Import per SSH: '<user>@<server>' or '<ENTER>' for no import")))
           (if (string-null? remote)
               (begin
                 (note "Private data" "No secrets imported. You will not be asked again.")
                 (call-with-output-file marker (lambda (p) (display "" p)))
                 (chmod marker #o600))
               (let ((at (string-rindex remote #\@)))
                 (if (not at)
                     (note "Private data error" "Invalid SSH destination. Expected user@server.")
                     (let* ((user (substring remote 0 at))
                            (host (substring remote (+ at 1)))
                            (path (prompt "Secrets path on server")))
                       (if (string-null? path)
                           (note "Private data error" "No secrets path was provided.")
                           (begin
                             (false-if-exception (delete-file-recursively tmpdir))
                             (mkdir-p tmpdir)
                             (if (not (zero? (system* nc "-z" "-w" "3" host "22")))
                                 (note "Private data error" "Server is not reachable; try again next login.")
                                 (begin
                                   (setenv "SSH_ASKPASS" #$ssh-askpass)
                                   (setenv "SSH_ASKPASS_REQUIRE" "force")
                                   (if (not (zero? (system* scp "-o" "BatchMode=no"
                                                                  "-o" "StrictHostKeyChecking=accept-new"
                                                                  "-r" (string-append user "@" host ":" path "/.")
                                                                  tmpdir)))
                                       (note "Private data error" "Could not download private data. No marker was set.")
                                       (if (or (not (file-exists? (string-append tmpdir "/gnupg/secret.asc")))
                                               (not (file-exists? (string-append tmpdir "/gnupg/public.asc")))
                                               (not (file-is-directory? (string-append tmpdir "/ssh")))
                                               (not (file-is-directory? (string-append tmpdir "/password-store")))
                                               (not (file-is-directory? (string-append tmpdir "/rogallo"))))
                                           (note "Private data error" "Downloaded private-data layout is incomplete.")
                                           (begin
                                             (system* gpg "--batch" "--import" (string-append tmpdir "/gnupg/secret.asc"))
                                             (system* gpg "--batch" "--import" (string-append tmpdir "/gnupg/public.asc"))
                                             (mkdir-p (string-append home "/.ssh"))
                                             (copy-recursively (string-append tmpdir "/ssh") (string-append home "/.ssh"))
                                             (mkdir-p (string-append home "/.password-store"))
                                             (copy-recursively (string-append tmpdir "/password-store") (string-append home "/.password-store"))
                                             (mkdir-p (string-append home "/.local/share/rogallo"))
                                             (copy-recursively (string-append tmpdir "/rogallo") (string-append home "/.local/share/rogallo"))
                                             (call-with-output-file marker (lambda (p) (display "" p)))
                                             (chmod marker #o600)
                                             (note "Private data" "Secrets imported successfully."))))))))))))))))))

(define home-private-data-service-type
  (service-type
   (name 'home-private-data)
   (extensions
    (list (service-extension home-activation-service-type (const private-data-script))))
   (default-value #f)
   (description "Import private user data once over SSH during Home activation.")))
