;;; pocket-mode-autoloads.el --- automatically extracted autoloads
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "pocket-mode" "pocket-mode.el" (0 0 0 0))
;;; Generated autoloads from pocket-mode.el

(autoload 'pocket-eww-view "pocket-mode" "\


\(fn)" t nil)

(autoload 'pocket-browser-view "pocket-mode" "\


\(fn)" t nil)

(autoload 'pocket-archive "pocket-mode" "\


\(fn)" t nil)

(autoload 'pocket-readd "pocket-mode" "\


\(fn)" t nil)

(autoload 'pocket-archive-or-readd "pocket-mode" "\


\(fn &optional PREFIX)" t nil)

(autoload 'pocket-delete "pocket-mode" "\


\(fn)" t nil)

(autoload 'pocket-add "pocket-mode" "\


\(fn)" t nil)

(autoload 'pocket-delete-or-add "pocket-mode" "\


\(fn &optional PREFIX)" t nil)

(autoload 'pocket-next-page "pocket-mode" "\


\(fn &optional N)" t nil)

(autoload 'pocket-previous-page "pocket-mode" "\


\(fn &optional N)" t nil)

(autoload 'pocket-refresh "pocket-mode" "\


\(fn)" t nil)

(autoload 'pocket-mode "pocket-mode" "\
mode for viewing pocket.com

\(fn)" t nil)

(autoload 'pocket-list "pocket-mode" "\
list paper in pocket.com

\(fn)" t nil)

(defalias 'list-pocket #'pocket-list)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "pocket-mode" '("pocket-")))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; pocket-mode-autoloads.el ends here
