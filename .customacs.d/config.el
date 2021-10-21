(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)
(package-refresh-contents)
(package-initialize)

(unless (package-installed-p 'use-package)
        (package-install 'use-package))

(use-package evil
  :ensure t ;; install evil if not installed
  :init     ;; tweake evil's configuration before loading it
  (setq evil-want-integration t) ;; optional as its already t by def
  (setq evil-want-keybinding nil)
  (setq evil-vsplit-window-right t)
  (setq evil-split-window-below t)
  (evil-mode))

(use-package evil-collection
  :after evil
        :ensure t
        :config
        (evil-collection-init))

(use-package doom-themes
  :ensure t)
