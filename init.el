;;; Emacs package initialization
(package-initialize)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (solarized-dark)))
 '(custom-safe-themes
   (quote
    ("a27c00821ccfd5a78b01e4f35dc056706dd9ede09a8b90c6955ae6a390eb1c1e" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" default)))
 '(package-selected-packages
   (quote
    (yasnippet w32-browser undo-tree transpose-frame sqlplus solarized-theme smart-mode-line php-mode php-eldoc packed org magit hydra helm-w3m helm-gtags grep-a-lot ggtags geben flycheck fill-column-indicator f epc emms dired+ counsel-projectile ace-window ac-helm)))
 '(vc-handled-backends nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 100 :width normal :foundry "unknown" :family "DejaVu Sans Mono")))))

(add-to-list 'load-path (expand-file-name "elisp/" user-emacs-directory))
(add-to-list 'load-path (expand-file-name "git/comics/" user-emacs-directory))
(add-to-list 'load-path (expand-file-name "git/hackernews/" user-emacs-directory))
(add-to-list 'load-path (expand-file-name "git/swiper/" user-emacs-directory))

;; General settings
(require 'init-base)

;; General packages
(require 'init-ace)
(require 'init-auto-complete)
(require 'init-avy)
(require 'init-comics)
(require 'init-dired)
(require 'init-flycheck)
(require 'init-ggtags)
(require 'init-grep-a-lot)
(require 'init-hackernews)
(require 'init-helm)
(require 'init-ivy)
(require 'init-locate)
(require 'init-magit)
(require 'init-org)
(require 'init-projectile)
(require 'init-undo-tree)
(require 'init-w3m)
(require 'init-yasnippet)
(require 'init-smart-mode-line)

;; Programming
(require 'init-perl)
(require 'init-php)

;; Custom key bindings
(require 'init-custom-keys)

;; Solarized theme
(require 'init-solarized-theme)

;; Custom settings
(load "~/.emacs.d/elisp/custom/init-custom.el")
