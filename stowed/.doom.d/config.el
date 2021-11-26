;;; config.el -*- lexical-binding: t; -*-

(setq user-full-name "Sreedev Kodichath"
      user-mail-address "sreedevpadmakumar@gmail.com")

;; THEME
(setq doom-theme 'doom-outrun-electric)

(setq org-directory "~/org/"
      org-roam-directory "~/org/roam")

(setq display-line-numbers-type 'relative)

(setq doom-font (font-spec :family "JetBrainsMono" :size 28)
      doom-big-font (font-spec :family "JetBrainsMono" :size 42))

(setq evil-escape-key-sequence "jj")
(setq deft-directory "~/data/notes/"
      deft-extensions '("org" "txt")
      deft-recursive t)

(setq display-time-mode 1)

;; TREEMACS PROJECT STRUCT VIEWER WIDTH
(setq treemacs-width 30)

;; ENABLED AUTO BACKUP + AUTO SAVE
(setq auto-save-default t)
   ;; make-backup-files t)

;; DISABLE EXIT CONFIRMATION
(setq confirm-kill-emacs nil)

;; CUSTOM EMACS SPLASH
(remove-hook '+doom-dashboard-functions #'doom-dashboard-widget-shortmenu)
(add-hook! '+doom-dashboard-mode-hook (hide-mode-line-mode 1) (hl-line-mode -1))
(setq-hook! '+doom-dashboard-mode-hook evil-normal-state-cursor (list nil))

;; LIMIT DASHBOARD MENU ITEMS
(setq +doom-dashboard-menu-sections (cl-subseq +doom-dashboard-menu-sections 0 0))

;; SLIGHTLY BETTER DEFAULT BUFFER NAMES
(setq doom-fallback-buffer-name "► Doom"
      +doom-dashboard-name "► Doom"
      doom-fallback-buffer "*dashboard*")
