;; Initialize Emacs packages.
(package-initialize)
(setq package-enable-at-startup nil)

;; Load init file in org format.
(org-babel-load-file (expand-file-name "settings.org" user-emacs-directory))

;; Load custom settings.
(let ((custom-file (expand-file-name "custom-settings.org" user-emacs-directory)))
  (when (file-exists-p custom-file)
    (org-babel-load-file custom-file)))
