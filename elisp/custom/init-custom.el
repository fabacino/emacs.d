;;; Custom stuff

;; Save backup files in a single folder
(setq backup-directory-alist '((".*" . "~/.bkup")))


;; Exclude unnecessary stuff from grep
(add-to-list 'grep-find-ignored-files "GTAGS")
(add-to-list 'grep-find-ignored-files "GRTAGS")
(add-to-list 'grep-find-ignored-files "GPATH")


;; Shorten path to home directory
(defun fbn/frame-title-buffer-name (name)
  "Modify buffer name for main frame title."
  (replace-regexp-in-string (concat "/home/" (getenv "USER") "/") "~/" name))
