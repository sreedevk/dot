;;; package.el -*- lexical-binding: t; -*-


(package! straight :pin "3eca39d")
(package! emmet-mode)
(package! cider)
(package! jet :recipe (:host github :repo "ericdallo/jet.el"))
(package! company-org-roam
   :recipe (:host github :repo "jethrokuan/company-org-roam"))
