;;; Custom stuff

;; Save backup files in a single folder
(setq backup-directory-alist '((".*" . "~/.bkup")))


;; Exclude unnecessary stuff from grep
(add-to-list 'grep-find-ignored-files "GTAGS")
(add-to-list 'grep-find-ignored-files "GRTAGS")
(add-to-list 'grep-find-ignored-files "GPATH")


;; Show full path of current buffer in main frame
(defun fbn/set-frame-title-format (&optional prefix)
  (interactive "sPrefix: ")
  (setq frame-title-format
        (list (format "%s %%S: %%j" (if prefix prefix (system-name)))
              '(:eval (if (buffer-file-name)
                          (replace-regexp-in-string (concat "c:/cygwin/home/" (getenv "USERNAME") "/") "~/" buffer-file-name)
                        (buffer-name))))))
(fbn/set-frame-title-format)
