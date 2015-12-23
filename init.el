;;; Initialize cygwin and friends if we are on a windows system
(if (string-equal system-type "windows-nt")
    (load "~/.emacs.d/elisp/init-cygwin.el"))

;;; Emacs package initialization
(package-initialize)

(add-to-list 'load-path (expand-file-name "elisp" user-emacs-directory))

;; General settings
(require 'init-base)

;; General packages
(require 'init-ace)
(require 'init-auto-complete)
(require 'init-dired)
(require 'init-flycheck)
(require 'init-ggtags)
(require 'init-grep-a-lot)
(require 'init-helm)
(require 'init-locate)
(require 'init-magit)
(require 'init-org)
(require 'init-projectile)
(require 'init-undo-tree)
(require 'init-w3m)
(require 'init-yasnippet)

;; Programming
(require 'init-perl)
(require 'init-php)

;; Custom key bindings
(require 'init-custom-keys)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (solarized-dark)))
 '(custom-safe-themes (quote ("8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" default)))
 '(vc-handled-backends nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 100 :width normal :foundry "unknown" :family "DejaVu Sans Mono")))))

;; Solarized theme
(require 'init-solarized-theme)

;; Custom settings
(load "~/.emacs.d/elisp/custom/init-custom.el")