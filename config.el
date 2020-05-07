;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;;:::::::::::::::::::::;;
;;::::: TYPOGRASHIT :::::;;
;;
;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;;
(setq doom-font (font-spec :family "FuraCode Nerd Font" :size 16))
(setq doom-variable-pitch-font (font-spec :family "GT America" :weight 'semi-bold :size 19))

;;::::::::::::::::::::::::::;;
;;::::: THEMESLUT SHIT :::::;;
;;
;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;;
(use-package doom-themes
  :preface (defvar region-fg nil) ; this prevents a weird bug with doom themes
  :config
  (setq doom-themes-enable-bold t
        doom-themes-enable-italic t
        doom-themes-treemacs-theme "doom-colors")
  (doom-themes-visual-bell-config)
  (doom-themes-treemacs-config)
  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config))

(use-package kaolin-themes
  :init
  ;; (load-theme 'kaolin-valley-light t)
  (load-theme 'doom-snazzy t)
   :config
   (kaolin-treemacs-theme))


(setq user-full-name "Andrew Jarrett"
      user-mail-address "ahrjarrett@gmail.com")

(setq display-line-numbers-type t)

;;::::::::::::::::::::::;;
;;:::::: NOT SHIT ::::::;;
(setq org-directory "~/Desktop/org/"
      org-bullets-bullet-list '("⁖"))
(require 'org-tempo)
;; BORKED SINCE ORG 9.2!
;;(add-to-list 'org-structure-template-alist
;;             (list "exp" (concat "#+SETUPFILE: https://fniessen.github.io/org-html-themes/setup/theme-bigblow.setup \n"
;;                                ":EXPORT_FILE_NAME: ?\n"
;;                                ":EXPORT_TITLE:\n"
;;                                ":EXPORT_OPTIONS: toc:nil html-postamble:nil num:nil")))

;;:::::::::::::::::::::;;
;;:::::: PKGSHIT ::::::;;
;;
(use-package editorconfig
  :config
  (editorconfig-mode 1))

(use-package centaur-tabs
  :demand
  :config
  (centaur-tabs-mode t)
  (centaur-tabs-headline-match)
  (centaur-tabs-group-by-projectile-project)
  (setq centaur-tabs-set-icons t
        centaur-tabs-style "bar"
        centaur-tabs-set-bar 'right
        x-underline-at-descent-line t
        centaur-tabs-height 32
        centaur-tabs-gray-out-icons 'buffer
        centaur-tabs-set-close-button nil
        centaur-tabs-set-modified-marker t
        centaur-tabs-cycle-scope 'tabs
        centaur-tabs-adjust-buffer-order nil
        ;; centaur-tabs-background-color (face-background 'default)
        ))

;; (use-package hs-lint
;;   :config
;;   (defun my-haskell-mode-hook ()
;;     (local-set-key "\C-cl" 'hs-lint))
;;   (add-hook 'haskell-mode-hook 'my-haskell-mode-hook))

(use-package yasnippet
  :config
  (yas-global-mode t)
  :diminish yas-minor-mode)

(use-package flycheck
  :config
  ;; Fixes issue where Flycheck temp files are picked up by webpack HMR, then crashing when removed, see:
  ;; https://github.com/flycheck/flycheck/issues/1446#issuecomment-381131567
  (setcar (memq 'source-inplace (flycheck-checker-get 'typescript-tslint 'command))
        'source-original))

(use-package rjsx-mode
  :mode(("\\.js\\'" . rjsx-mode)
        ("\\.jsx\\'" . rjsx-mode))
  :init
  (add-hook 'rjsx-mode-hook 'prettier-js-mode))

(use-package prettier-js
  :init
  (add-hook 'js2-mode-hook 'prettier-js-mode)
  (add-hook 'rjsx-mode-hook 'prettier-js-mode)
  :config
  (setq prettier-js-args
        '("--trailing-comma" "all"
          "--bracket-spacing" "false"
          "--tab-width" "2"
          "--no-semi" "true"
          "--single-quote" "true"
          "--no-bracket-spacing" "false"
          "--jsx-bracket-same-line" "false"
          "--jsx-single-quote" "true"
          "--arrow-parens" "avoid")))

;;::::::::::::::::::::::::;;
;;::::::: TYPESCHIT :::::::;;
;;
(defun setup-tide-mode ()
  (interactive)
  (tide-setup)
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (setq-default typescript-indent-level 2)
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)
  (company-mode +1))
;; aligns annotation to the right hand side
(setq company-tooltip-align-annotations t)

;; formats the buffer before saving
(add-hook 'before-save-hook 'tide-format-before-save)
(add-hook 'typescript-mode-hook #'setup-tide-mode)

(load! "bindings" doom-private-dir)

;;::::::::::::::::::::::::::::::::;;
;;::::: WHICH SHIT PATH SHIT :::::;;
;;
(add-to-list 'exec-path "/usr/local/bin/lein")
(add-to-list 'exec-path "/usr/local/bin/rg")

;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c g k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c g d') to jump to their definition and see how
;; they are implemented.
