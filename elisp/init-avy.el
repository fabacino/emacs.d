(require 'avy)
(define-key global-map (kbd "C-c SPC") 'avy-goto-char)
(define-key global-map (kbd "C-c C-SPC") 'avy-goto-word-or-subword-1)
(define-key global-map (kbd "M-g g") 'avy-goto-line)
(define-key global-map (kbd "M-g M-g") 'avy-goto-line)

(define-key isearch-mode-map (kbd "M-g") 'avy-isearch)


(provide 'init-avy)
