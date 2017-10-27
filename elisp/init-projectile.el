(require 'projectile)
(require 'counsel-projectile)
(projectile-global-mode)

;; Workaround, see https://github.com/bbatsov/projectile/issues/1183
(setq projectile-mode-line
      '(:eval (format " Projectile[%s]"
                      (projectile-project-name))))


(provide 'init-projectile)
