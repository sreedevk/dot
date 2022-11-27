;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!

(setq user-full-name "Sreedev Kodichath"
      user-mail-address "sreedevpadmakumar@gmail.com")

(setq doom-theme 'doom-ayu-dark
      doom-font (font-spec :family "JetBrainsMono" :size 16)
      doom-variable-pitch-font (font-spec :family "JetBrainsMono" :size 16)
      doom-big-font (font-spec :family "JetBrainsMono" :size 24))

(after! doom-themes
  (setq doom-themes-enable-bold t)
  (setq doom-themes-enable-italic t))

(custom-set-faces!
  '(font-lock-comm :slant italic)
  '(font-lock-keyword-face :slant italic))

(setq org-directory "~/Data/org")
(setq org-agenda-files "~/Data/org/agenda")

(setq text-scale-mode-step 1.05)
(setq-default line-spacing 1)
(setq standard-indent 2)
(setq-default tab-width 2)

(setq calendar-date-style 'iso)
(setq display-line-numbers-type 'relative)
(setq display-time-mode 1)
(setq treemacs-width 30)
(setq auto-save-default t)
(setq confirm-kill-emacs nil)
(setq doom-scratch-initial-major-mode 'lisp-interaction-mode)
(setq-default evil-escape-key-sequence "jj")
(setq-default evil-escape-delay 0.5)

(setq doom-fallback-buffer-name "► Doom"
      +doom-dashboard-name "► Doom"
      doom-fallback-buffer "*dashboard*")

(map! "C-c a" #'emmet-expand-line)
(map! :leader
      (:prefix-map ("=" . "calc")
                   "=" #'calc-dispatch
                   "l" #'literate-calc-minor-mode
                   "c" #'calc
                   "q" #'quick-calc
                   "g" #'calc-grab-region
                   "G" #'calc-grab-rectangle)
      (:prefix-map ("t" . "toggle")
                   "v" 'git-gutter-mode
                   "h" #'hl-line-mode))

(delete-selection-mode 1)

(evil-global-set-key 'motion "j" 'evil-next-visual-line)
(evil-global-set-key 'motion "k" 'evil-previous-visual-line)

(set-frame-parameter (selected-frame) 'alpha '(85 . 50))
(add-to-list 'default-frame-alist '(alpha . (85 . 50)))
(setq which-key-idle-delay 0.8)
