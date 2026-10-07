(define-module (system hosts grumpy)
  #:use-module (gnu)
  #:use-module (gnu services networking)
  #:use-module (nongnu packages linux)
  #:use-module (nongnu system linux-initrd)
  #:use-module (system common))

(operating-system
  (inherit base-operating-system)
  (host-name "grumpy")
  (kernel linux)
  (initrd microcode-initrd)
  (firmware
   (cons* i915-firmware
          iwlwifi-firmware
          sof-firmware
          %base-firmware))
  (file-systems
   (cons*
    (file-system
      (device (file-system-label "EFI"))
      (mount-point "/boot/efi")
      (type "vfat"))
    (file-system
      (device (file-system-label "GUIX"))
      (mount-point "/")
      (type "ext4"))
    %base-file-systems))
  (swap-devices
   (list (swap-space (target (file-system-label "SWAP")))))
  (bootloader
   (bootloader-configuration
    (bootloader grub-efi-bootloader)
    (targets (list "/boot/efi"))
    (keyboard-layout keyboard-layout)))
  (services
   (cons*
    (service network-manager-service-type)
    (service wpa-supplicant-service-type)
    (operating-system-user-services base-operating-system))))
