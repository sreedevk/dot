;;; package.el -*- lexical-binding: t; -*-

(package! emmet-mode)
(package! cider)
(unpin! org-roam)
(package! org-roam-ui)
(package! org-present)
(package! visual-fill-column)
(package! ef-themes)
(package! ledger-mode)
(package! copilot
  :recipe (:host github :repo "zerolfx/copilot.el" :files ("*.el" "dist")))
