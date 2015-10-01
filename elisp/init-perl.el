(defun fbn/perl-hook ()
  (cperl-mode)
  (setq cperl-hairy t)
  ;(setq cperl-electric-parens t)
  ;(setq cperl-electric-keywords t)
  ;(setq cperl-auto-newline t)
  ;(setq cperl-electric-lbrace-space t)
  (setq cperl-lazy-help-time 2))
(add-hook 'perl-mode-hook 'fbn/perl-hook)


(provide 'init-perl)
