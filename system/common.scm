(define-module (system common)
  #:use-module (gnu)
  #:use-module (gnu packages)
  #:use-module (gnu services)
  #:use-module (gnu services dbus)
  #:use-module (gnu services guix)
  #:use-module (gnu services networking)
  #:use-module (gnu services sound)
  #:use-module (home daniel)
  #:use-module (home root)
  #:use-module (my-packages ly)
  #:use-module (services ly)
  #:use-module (nongnu packages linux)
  #:export (base-operating-system keyboard-layout))

(define keyboard-layout
  (keyboard-layout "de"))

(define system-packages
  (specifications->packages
   '("curl" "wget" "git" "neovim" "bat" "eza" "fd" "fzf" "htop" "acpi" "ripgrep"
     "lsof" "tree" "tree-sitter-cli" "inetutils" "brightnessctl" "jq" "pv" "sshfs"
     "gdu" "wev" "gnupg" "starship" "zfs"
     "wofi" "waybar" "hyprland" "hyprpaper" "xwayland" "dolphin"
     "grim" "slurp" "wl-clipboard" "wtype"
     "libnotify" "swaynotificationcenter"
     "kitty" "yazi" "qutebrowser" "librewolf" "freetube" "neomutt"
     "urlscan" "elinks" "mpv" "zathura" "pipx" "ansible" "python" "pyright"
     "abook" "zbar" "tmux" "rofimoji" "openssh" "netcat" "coreutils"
     "gcc" "gitui" "nodejs" "par"
     "qt5ct" "qt6ct" "kvantum")))

(define base-operating-system
  (operating-system
    (locale "de_DE.utf8")
    (timezone "Europe/Berlin")
    (keyboard-layout keyboard-layout)
    (users
     (cons
      (user-account
       (name "daniel")
       (comment "Main user")
       (group "users")
       (home-directory "/home/daniel")
       (supplementary-groups '("wheel" "netdev" "audio" "video" "input")))
      %base-user-accounts))
    (packages (append (list ly) system-packages %base-packages))
    (services
     (cons
      (service guix-home-service-type
               `(("daniel" ,daniel-home-environment)
                 ("root" ,root-home-environment)))
      (cons
       (service ly-service-type)
       (modify-services %desktop-services
         (delete mingetty-service-type)
         (delete gdm-service-type)
         (delete sddm-service-type)))))))