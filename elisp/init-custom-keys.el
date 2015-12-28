;; Custom key bindings
(let ((prefix-command "C-c f "))
  (global-set-key (kbd (concat prefix-command "a")) 'helm-apropos)
  (global-set-key (kbd (concat prefix-command "b")) 'helm-resume)
  (global-set-key (kbd (concat prefix-command "f")) 'helm-for-files)
  (global-set-key (kbd (concat prefix-command "i")) 'helm-semantic-or-imenu)
  (global-set-key (kbd (concat prefix-command "l")) 'helm-locate)
  (global-set-key (kbd (concat prefix-command "o")) 'helm-occur)
  (global-set-key (kbd (concat prefix-command "m")) 'helm-man-woman)
  (global-set-key (kbd (concat prefix-command "r")) 'helm-recentf)
  (global-set-key (kbd (concat prefix-command "x")) 'helm-register)
  (global-set-key (kbd (concat prefix-command "SPC")) 'helm-all-mark-rings)
  (global-set-key (kbd (concat prefix-command "TAB")) 'helm-lisp-completion-at-point)
  (global-set-key (kbd (concat prefix-command "/")) 'helm-find))

;; Use C-h as backspace
(global-set-key (kbd "C-h") 'backward-delete-char-untabify)
(global-set-key (kbd "C-c h") 'help-command)

;; Use C-w as backspace kill word
(global-set-key (kbd "C-w") 'backward-kill-word)
(global-set-key (kbd "C-x C-k") 'kill-region)


(provide 'init-custom-keys)
