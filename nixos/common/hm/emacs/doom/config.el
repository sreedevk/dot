;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!

(setq user-full-name "Sreedev Kodichath"
      user-mail-address (rot13 "ferrqricnqznxhzne@tznvy.pbz"))

(setq doom-theme 'doom-feather-dark
      doom-font (font-spec :family "IosevkaTerm Nerd Font" :size 28)
      doom-variable-pitch-font (font-spec :family "IosevkaTerm Nerd Font" :size 28)
      doom-big-font (font-spec :family "IosevkaTerm Nerd Font" :size 40))

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

(display-time-mode 1)

(map! "C-c C-a" #'emmet-expand-line)
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

(evil-global-set-key 'motion "j" 'evil-next-visual-line)
(evil-global-set-key 'motion "k" 'evil-previous-visual-line)

(setq fancy-splash-image (concat doom-user-dir "emacs.png"))
(setq +doom-dashboard-banner-padding '(7 . 3))

(set-frame-parameter (selected-frame) 'alpha '(85 . 50))
(add-to-list 'default-frame-alist '(alpha . (85 . 50)))
(setq which-key-idle-delay 0.8)

(after! visual-fill-column
  (setq visual-fill-column-width 110
        visual-fill-column-center-text t))

(eval-after-load "org-present"
  '(progn
     (add-hook 'org-present-mode-hook
               (lambda ()
                 (visual-fill-column-mode 1)
                 (visual-line-mode 1)
                 (org-present-big)
                 (org-display-inline-images)
                 (org-present-hide-cursor)
                 (org-present-read-only)))
     (add-hook 'org-present-mode-quit-hook
               (lambda ()
                 (visual-fill-column-mode 0)
                 (visual-line-mode 0)
                 (org-present-small)
                 (org-remove-inline-images)
                 (org-present-show-cursor)
                 (org-present-read-write)))))
