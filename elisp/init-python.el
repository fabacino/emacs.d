(require 'elpy)
(require 'py-autopep8)

(setq python-indent-offset 4)

;; Python modules needed:
;; - flake8
;; - jedi
;; - autopep8
(elpy-enable)

;; Remove flymake, as we prefer flycheck
(setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
;(elpy-use-ipython)
;(setq python-shell-interpreter-args (concat "--simple-prompt " python-shell-interpreter-args))

(defun fbn/python-hook ()
  (py-autopep8-enable-on-save)
  (flycheck-mode))
(add-hook 'elpy-mode-hook 'fbn/python-hook)


(provide 'init-python)

