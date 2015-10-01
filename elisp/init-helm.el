(require 'helm-config)
(helm-mode t)
(setq helm-buffers-fuzzy-matching t)
;(setq helm-buffer-max-length 36)
(setq helm-ff-file-name-history-use-recentf t)
(setq helm-move-to-line-cycle-in-source t)
(setq helm-quick-update t)
(setq helm-scroll-amount 8)
(setq helm-split-window-in-side-p t)

;; Keybindings
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "M-y") 'helm-show-kill-ring)
;(global-set-key (kbd "C-x b") 'helm-buffers-list)
(global-set-key (kbd "C-x b") 'helm-mini)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
;; Switch TAB und C-z
(define-key helm-map (kbd "TAB") 'helm-execute-persistent-action)
(define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ; make TAB work in terminal
(define-key helm-map (kbd "C-z") 'helm-select-action)
;; C-o is helm-next-source
(define-key helm-map (kbd "M-o") 'helm-previous-source)

;; History functions
(require 'helm-eshell)
(defun fbn/eshell-mode-hook ()
  (define-key eshell-mode-map (kbd "C-c C-l")  'helm-eshell-history))
(add-hook 'eshell-mode-hook 'fbn/eshell-mode-hook)
(define-key shell-mode-map (kbd "C-c C-l") 'helm-comint-input-ring)
(define-key minibuffer-local-map (kbd "C-c C-l") 'helm-minibuffer-history)

;; helm-swoop: Switch from I-search to helm with M-i
(require 'helm-swoop)

;; helm for projectile
(require 'helm-projectile)


(provide 'init-helm)
