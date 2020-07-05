;;; ~/.doom.d/bindings.el -*- lexical-binding: t; -*-

(map! :map markdown-mode-map "M-p" nil)
(map! :mode typescript-mode "C-SPC" nil)

(map!
      :g "s-l" nil
      :g "s-L" nil
      :g "M-p" nil
      :g "s-h" 'evil-window-left
      :g "s-l" 'evil-window-right
      :g "s-j" 'evil-window-down
      :g "s-k" 'evil-window-up
      :g "s-H" 'evil-window-move-far-left
      :g "s-L" 'evil-window-move-far-right
      :g "s-J" 'evil-window-move-very-bottom
      :g "s-K" 'evil-window-move-very-top
      :g "s-d" 'evil-window-split
      :g "s-D" 'evil-window-vsplit
      :g "s-r" 'evil-window-vsplit
      :g "s-f" 'treemacs
      :g "s-r" 'rjsx-mode
      :g "s-p" 'evil-switch-to-windows-last-buffer
      :g "s-W" '+workspace/close-window-or-workspace
      :g "s-w" 'doom/kill-this-buffer-in-all-windows
      ;; TAB BINDINGS
      :g "M-o" 'centaur-tabs-backward
      :g "M-p" 'centaur-tabs-forward
      :g "s-{" 'centaur-tabs-backward
      :g "s-}" 'centaur-tabs-forward
      :g "<s-escape>" 'centaur-tabs-backward-group)


;; (map! :nv "/" 'swiper)
(map! :nv :map org-mode-map :leader "t v" 'variable-pitch-mode) ;; broken?
(map! :i :map typescript-mode-map "<C-right>" 'company-tide)


;; WHAT SHOULD TAB DO?
;; borrowed from https://github.com/hlissner/doom-emacs-private/blob/master/config.el
(map! :n [tab] (general-predicate-dispatch nil
                 (and (featurep! :editor fold)
                      (save-excursion (end-of-line) (invisible-p (point))))
                 #'+fold/toggle
                 (fboundp 'evil-jump-item)
                 #'evil-jump-item)
      :v [tab] (general-predicate-dispatch nil
                 (and (bound-and-true-p yas-minor-mode)
                      (or (eq evil-visual-selection 'line)
                          (not (memq (char-after) (list ?\( ?\[ ?\{ ?\} ?\] ?\))))))
                 #'yas-insert-snippet
                 (fboundp 'evil-jump-item)
                 #'evil-jump-item))


;; TODO: Remove <SPC+*>
;;       Stop it from calling +default/search-project-for-symbol-at-point
;;       Make it us helm-projectile-ag instead
(map! :n :map doom-leader-map :leader "*" 'helm-projectile-ag)

;;; ORG-MODE MAP:

;; TODO: org-next-visible-heading
;;
;; CURRENT STATE:
;;evil-motion-state-map (
;;evil-backward-sentence-begin
;;
;;
;;evil-motion-state-map )
;;evil-org-forward-sentence
;;
;;map (
;;org-previous-visible-heading
;;map )
;;org-next-visible-heading

;Error in private config: bindings.el, (error Key sequence M-SPC p s starts with non-prefix key M-SPC p)

;; (after! org
;;   (map! :localleader :map org-mode-map
        ;; :desc "Eval Block" "e" 'ober-eval-block-in-repl
        ;; (:prefix "SPC" :desc "Tags" "t" 'org-set-tags
         ;; :desc "Roam Bibtex" "b" 'orb-note-actions
         ;; (:prefix ("p" . "Properties")
         ;;  :desc "Set" "s" 'org-set-property
         ;;  :desc "Delete" "d" 'org-delete-property
         ;;  :desc "Actions" "a" 'org-property-action)
         ;; (:prefix ("i" . "Insert")
         ;; :desc "Link/Image" "l" 'org-insert-link
         ;; :desc "Item" "o" 'org-toggle-item
         ;; :desc "Citation" "c" 'org-ref-helm-insert-cite-link
         ;; :desc "Footnote" "f" 'org-footnote-action
         ;; ;; :desc "Screenshot" "s" 'org-download-screenshot
         ;; :desc "Table" "t" 'org-table-create-or-convert-from-region
         ;; (:prefix ("h" . "Headings")
         ;;  :desc "Normal" "h" 'org-insert-heading
         ;;  :desc "Todo" "t" 'org-insert-todo-heading
         ;;  (:prefix ("s" . "Subheadings")
         ;;   :desc "Normal" "s" 'org-insert-subheading
         ;;   :desc "Todo" "t" 'org-insert-todo-subheading))
         ;; (:prefix ("e" . "Exports")
         ;;  :desc "Dispatch" "d" 'org-export-dispatch))))


