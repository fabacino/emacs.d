(defun fbn/c-hook ()
  (c-set-style "k&r")
  (counsel-gtags-mode)
  (flycheck-mode)
  (local-set-key
   (kbd "<f6>")
   (defhydra hydra-c-style ()
     "style"
     ("8" (lambda () (interactive)
            (setq tab-width 8)
            (setq c-basic-offset 8)) "indent = 8")
     ("4" (lambda () (interactive)
            (setq tab-width 4)
            (setq c-basic-offset 4)) "indent = 4")
     ("t" (lambda () (interactive)
            (setq indent-tabs-mode t)) "use tabs")
     ("s" (lambda () (interactive)
            (setq indent-tabs-mode nil)) "use spaces")
     ("q" nil nil))))
(add-hook 'c-mode-hook 'fbn/c-hook)


(provide 'init-c)
