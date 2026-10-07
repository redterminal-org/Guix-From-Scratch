(define-module (system common)
  #:use-module (gnu)
  #:use-module (gnu packages)
  #:use-module (gnu services)
  #:use-module (gnu services dbus)
  #:use-module (gnu services networking)
  #:use-module (gnu services sound)
  #:use-module (nongnu packages linux)
  #:export (base-operating-system keyboard-layout))

(define keyboard-layout
  (keyboard-layout "de"))

(define system-packages
  (specifications->packages
   '("curl" "wget" "git" "bat" "eza" "htop" "acpi" "ripgrep"
     "lsof" "tree" "inetutils" "brightnessctl" "jq" "pv" "sshfs"
     "gdu" "wev" "gnupg" "starship" "zfs"
     "wofi" "waybar" "hyprland" "hyprpaper" "xwayland" "dolphin"
     "grim" "slurp" "wl-clipboard" "wtype"
     "libnotify" "swaynotificationcenter"
     "kitty" "yazi" "qutebrowser" "librewolf" "freetube" "neomutt"
     "urlscan" "elinks" "mpv" "zathura" "pipx" "ansible" "python"
     "abook" "zbar" "tmux" "rofimoji" "openssh" "netcat" "coreutils")))

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
    (packages (append system-packages %base-packages))
    (services
     (cons*
      (service network-manager-service-type)
      (service elogind-service-type)
      (service dbus-root-service-type)
      (service pipewire-service-type)
      %desktop-services))))
