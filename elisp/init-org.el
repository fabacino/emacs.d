(require 'org)

(global-set-key (kbd "<f12>") 'org-agenda)
(setq org-agenda-files (list "~/org"))
(setq org-log-done t)

;; Allow code blocks in these languages to be executed within org files
(require 'ob-emacs-lisp)
(require 'ob-shell)
(require 'ob-python)


(provide 'init-org)
