(setq doom-font (font-spec :family "Fira Code" :size 16 :weight 'semi-bold))
(setq doom-variable-pitch-font (font-spec :family "GT America" :weight 'bold :size 19))

(setq doom-localleader-key "M-SPC"
      doom-leader-alt-key "C-M-SPC"
      doom-localleader-alt-key "S-M-SPC")

(setq user-full-name "Andrew Jarrett"
      user-mail-address "ahrjarrett@gmail.com")
(setq display-line-numbers-type t)

(setq org-directory "~/dev/org/"
      org-bullets-bullet-list '("⁖"))
(require 'org-tempo)

(use-package treemacs
  :config (setq treemacs-is-never-other-window t))

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
  (load-theme 'doom-snazzy t))

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
        ;; centaur-tabs-background-color (face-background 'default)
        centaur-tabs-adjust-buffer-order nil))

(use-package yasnippet
  :config
  (yas-global-mode t)
  :diminish yas-minor-mode)

(use-package flycheck
  :config
  (setcar (memq 'source-inplace (flycheck-checker-get 'typescript-tslint 'command))
        'source-original))

(use-package rjsx-mode
  :mode
  (("\\.tsx'" . rjsx_mode))
  :init
  (add-hook 'rjsx-mode-hook 'prettier-js-mode))

(use-package prettier-js
  :init
  (add-hook 'js2-mode-hook 'prettier-js-mode)
  (add-hook 'rjsx-mode-hook 'prettier-js-mode)
  :config
  (setq prettier-js-args
        '("--trailing-comma" "all"
          "--bracket-spacing"
          "--tab-width" "2"
          "--semi"
          "--double-quote"
          ;; "--jsx-bracket-same-line" "false"
          ;; "--jsx-single-quote" "true"
          "--arrow-parens" "avoid")))

(defun setup-tide-mode ()
  (interactive)
  (tide-setup)
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (setq-default typescript-indent-level 2)
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)
  (company-mode +1)
  ;; aligns annotation to the right hand side
  (setq company-tooltip-align-annotations t))

(use-package tide
  :ensure t
  :after (typescript-mode company flycheck)
  :hook ((typescript-mode . setup-tide-mode)
         (typescript-mode . tide-hl-identifier-mode)
         ;(typescript-mode . prettier-js-mode)
         (before-save . tide-format-before-save)
         (before-save . prettier-js-mode-hook)))

(after! js2-mode
  (defun ~+company-typescript-init-h ()
    (set-company-backend! 'tide-mode '(company-files company-tide :with company-yasnippet company-capf)))
  (add-hook 'tide-mode-hook '~+company-typescript-init-h))

;;BROKEN, last I tried
;; (setq-hook! 'tide-mode-hook
;;   company-backends '((company-files :with company-tide company-yasnippet)))

(tide-setup)

(use-package web-mode
  :hook '((lambda()
          (when (string-equal "tsx" (file-name-extension buffer-file-name))
                    (setup-tide-mode)))))

(add-to-list  'auto-mode-alist '("\\.tsx\\'" . typescript-mode))

;; enable typescript-tslint checker
(flycheck-add-mode 'typescript-tslint 'web-mode)

;;(add-to-list 'exec-path "/usr/local/bin/lein")
(add-to-list 'exec-path "/usr/local/bin/rg")

'(helm-completion-style 'emacs)

;; make BACKSPACE behave like Ivy in Helm (go up a dir)
(after! helm
  (add-hook! 'helm-find-files-after-init-hook
    (map! :map helm-find-files-map
          "<DEL>" #'helm-find-files-up-one-level)))

(load! "bindings" doom-private-dir)

(load! "bindings" doom-private-dir)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("632694fd8a835e85bcc8b7bb5c1df1a0164689bc6009864faed38a9142b97057" default))
 '(package-selected-packages '(helm-ag tide)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
