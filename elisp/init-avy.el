(require 'avy)
(global-set-key (kbd "C-c SPC") 'avy-goto-char)
(global-set-key (kbd "C-c C-SPC") 'avy-goto-word-or-subword-1)
(global-set-key (kbd "M-g g") 'avy-goto-line)
(global-set-key (kbd "M-g M-g") 'avy-goto-line)

(define-key isearch-mode-map (kbd "M-g") 'avy-isearch)


(provide 'init-avy)
