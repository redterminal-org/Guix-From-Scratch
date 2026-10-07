# mutt-abook-gpg
![Drone CI badge](https://drone.envs.net/api/badges/dan/mutt-abook-gpg/status.svg)  

**Mirror**: https://github.com/dan-envs/mutt-abook-gpg from/to
https://git.envs.net/dan/mutt-abook-gpg

With this setup you can receive new GPG keys from within Mutt or NeoMutt with
the "abook" TUI program. With the provided macros you can store new addresses
to the address book and fetch the public keys from all contacts, if they're
available from either WKD (Web Key Directory) or hkps://keys.openpgp.org.

(Neo)Mutt is set up, that you can encrypt/decrypt/sign/verify emails from within
(Neo)Mutt automatically.

This repository is actually made for the **envs.net** pubnix users to
set up their Mutt accounts with GPG support, but everyone can use it, if they
want and contributions are highly appreciated.

## Be careful
**Read this README in full and be sure that you have understood!**

   **DANGER**: All information except 'name' and 'email' are **deleted**
   from the address book when using the `'<CTRL>+k'` macro in NeoMutt or
   Mutt. The 'notes' field is used to store information, if a GnuPG/OpenPGP
   public key has been found for the contact. So you best start with a fresh
   address book or make a backup of your existing address book:

   `cp ~/.abook/addressbook ~/.abook/addressbook.orig`

# Setup
1. Setup your '~/.gnupg/gpg.conf' as follows:

```
auto-key-locate wkd,keyserver
keyserver hkps://keys.openpgp.org/
trust-model tofu
auto-key-retrieve
```

2. Run the following command to initialize the repo. This is a non destructive
   command, which doesn't delete any keys. It just creates the files needed by
   GnuPG, if they're not already present:

  `gpg --list-keys`

  You can also generate a new GnuPG key with the following commands, if you
  don't already have one:

  `gpg --gen-key` for a simple setup for your email address

  `gpg --full-gen-key` for a more advanced setup and appending a comment to your
  key. However, I recommend going with the defaults for the key algorithms.

3. Clone this repository to `~/.abook'`:
   If you have an existing `~/.abook/'`, move it to some save location and copy
   your `addressbook` file back to this directory after the clone. The clone
   will fail, if the directory exists.

   `git clone https://git.envs.net/dan/mutt-abook-gpg.git ~/.abook`

## Setup for Mutt
**Note**: You have to source the `abook-before-v0.6.2.mutt.rc`, if you're on a
version of "abook" before v0.6.2 (for example when you're running Debian
"Trixie").

**Note for 'envs.net' shell users**: This is especially the case for envs.net
shell users yet! Debian "Trixie" at the moment only supports "abook v0.6.1". If
"abook" is updated on the envs.net server, the 'source' line in your `~/.muttrc`
has to be updated as well. 

**DANGER**: If you source the wrong file for your "abook" version, you'll
lose all your contacts, so take care if your "abook" version gets updated
from a version before v0.6.2 to >= v0.6.2. If your contacts are lost, check
for the right file to source into your `~/.muttrc` and copy a backup in your
`~/.abook/` directory back to `~/.abook/addressbook`.

Add the following line to your `~/.muttrc`:

For abook since v0.6.2: `source ~/.abook/abook.mutt.rc`  
For abook before v0.6.2: `source ~/.abook/abook-before-v0.6.2.mutt.rc`

### Set up Mutt to use GPG for signing/encryption
Delete your previous GPG configuration and replace it with the following in your
`~/.muttrc`:

```
source ~/.gpg.rc
set pgp_default_key="<your email address from your key>"
set pgp_sign_as="<your email address from your key>"
set pgp_timeout=3600
set pgp_autosign=yes
set pgp_replysign=yes
set pgp_verify_sig=yes
set pgp_replyencrypt=yes
set pgp_self_encrypt=yes
set crypt_protected_headers_write=yes
set crypt_protected_headers_subject="(PGP message)"
```

### How to operate with Mutt
Every time you add a new entry to your address book with `'<SHIFT>+a'`, you have
to run `'<CTRL>+k'`, if you want to check if a key for the new address is
available.

**Note**: 8 backups of the address book are kept, when using the script through
the `'<CTRL>+k'` macro. A backup is done every time you refresh your keys with
this macro.

**Start Mutt with the following command**: `mutt`  
**Add an email address to abook**: `'<SHIFT>+a'`  
**Refresh public GPG/OpenPGP keys for all contacts**: `'<CTRL>+k'`  
**Query addressbook**: `'<SHIFT>+q'`

## Setup for NeoMutt
**Note**: You have to source the `abook-before-v0.6.2.neomutt.rc`, if you're
on a version of "abook" before v0.6.2 (for example when you're running Debian
"Trixie").

**DANGER**: If you source the wrong file for your "abook" version, you'll lose
all your contacts, so take care if your "abook" version gets updated from a
version before v0.6.2 to >= v0.6.2. If your contacts are lost, check for the
right file to source into your `~/config/mutt/muttrc` and copy a backup in your
`~/.abook/` directory back to `~/.abook/addressbook`.

Add the following line to your `~/.config/mutt/muttrc`:

For abook since v0.6.2: `source ~/.abook/abook.neomutt.rc`  
For abook before v0.6.2: `source ~/.abook/abook-before-v0.6.2.neomutt.rc`

Create an alias in your '.bashrc' or '.zsh' for `mutt`:

`alias mutt="neomutt"`

The alias is needed to send mail from your "abook" (command `abook`) TUI
directly with the `'m'` key.

### Set up NeoMutt to use GPG for signing/encryption
Delete your previous GPG configuration and replace it with the following in your
`~/.config/mutt/muttrc`:

```
# GPG
#source gpg.rc
set pgp_default_key = "<your email address from your key>"
set pgp_sign_as = "<your email address from your key>"
set postpone_encrypt = yes
set pgp_self_encrypt = yes
set pgp_timeout = 3600
set crypt_use_gpgme = yes
set crypt_autopgp = yes
set crypt_protected_headers_subject = "(PGP message)"
set crypt_auto_sign = yes
set pgp_auto_decode
set pgp_use_gpg_agent = yes
```

### How to operate with NeoMutt
Every time you add a new entry to your address book with `'<SHIFT>+a'`, you have
to run `'<CTRL>+k'`, if you want to check if a key for the new address is
available.

**Note**: 8 backups of the address book are kept, when using the script through
the `'<CTRL>+k'` macro. A backup is done every time you refresh your keys with
this macro.

**Start NeoMutt with the following command**: `mutt` or `neomutt`  
**Add an email address to abook**: `'<SHIFT>+a'`  
**Refresh public GPG/OpenPGP keys for all contacts**: `'<CTRL>+k'`  
**Query email contacts**: Press `'<TAB>'` when asked for an email address.

# This is a WIP. Any help appreciated.
This is still a work in progress. So there may occur problems, which you may be
able to resolve yourself, but please give me a hint what's wrong.

However: It should be already useable. If you find a bug or have any problems,
open an issue on the issue tracker or send mail directly to
[dan@envs.net](mailto:dan@envs.net).

**Pull Requests are welcome!**

