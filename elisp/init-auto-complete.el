(require 'auto-complete-config)
(ac-config-default)
(setq ac-auto-start nil)
;(add-to-list 'ac-dictionary-directories "~/.emacs.d/elpa/auto-complete-20150618.1949/dict")
(setq ac-sources '(ac-source-abbrev ac-source-dictionary ac-source-words-in-same-mode-buffers))
;(defun ac-common-setup ()
;  (setq ac-sources '(ac-source-abbrev  ac-source-dictionary ac-source-words-in-same-mode-buffers)))
(define-key ac-mode-map (kbd "M-TAB") 'auto-complete) ; aka C-M-i


(provide 'init-auto-complete)
