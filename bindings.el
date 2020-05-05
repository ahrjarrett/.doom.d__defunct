;;; ~/.doom.d/bindings.el -*- lexical-binding: t; -*-

;;::::::::::::::::::::::::::;;
;;::::: FINGER-DO SHIT :::::;;
;;
(map! :map markdown-mode-map "M-p" nil)
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
      ;; TABSHAIT
      :g "M-o" 'centaur-tabs-backward
      :g "M-p" 'centaur-tabs-forward
      :g "s-{" 'centaur-tabs-backward
      :g "s-}" 'centaur-tabs-forward
      :g "<s-escape>" 'centaur-tabs-backward-group)


(map! :nv "/" 'swiper)
(map! :nv :map org-mode-map :leader "t v" 'variable-pitch-mode) ;; broken?
