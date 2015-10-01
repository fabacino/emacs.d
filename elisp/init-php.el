(require 'php-eldoc)
(require 'php-mode)
(defun fbn/php-hook ()
  (c-set-style "stroustrup")
  (c-set-offset 'case-label' 4)
;  (local-set-key (kbd "RET") 'newline-and-indent)
  (local-unset-key (kbd "C-."))
  (php-eldoc-enable)
  (ggtags-mode)
  (flycheck-mode))
(add-hook 'php-mode-hook 'fbn/php-hook)


(provide 'init-php)
