;;; pocket-api-autoloads.el --- automatically extracted autoloads
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "pocket-api" "pocket-api.el" (0 0 0 0))
;;; Generated autoloads from pocket-api.el

(autoload 'pocket-api-clear-auth "pocket-api" "\


\(fn)" t nil)

(autoload 'pocket-api-authorize "pocket-api" "\


\(fn)" t nil)

(autoload 'pocket-api-get "pocket-api" "\
Gets things from your pocket.

\(fn &key (OFFSET 0) (COUNT 10))" nil nil)

(autoload 'pocket-api-add "pocket-api" "\
Add URL-TO-ADD to your pocket.

\(fn URL-TO-ADD)" t nil)

(autoload 'pocket-api-archive "pocket-api" "\
Archive item which specified by ITEM_ID

\(fn ITEM_ID)" t nil)

(autoload 'pocket-api-readd "pocket-api" "\
Readd item which specified by ITEM_ID

\(fn ITEM_ID)" t nil)

(autoload 'pocket-api-favorite "pocket-api" "\
Favorite item which specified by ITEM_ID

\(fn ITEM_ID)" t nil)

(autoload 'pocket-api-unfavorite "pocket-api" "\
Unfavorite item which specified by ITEM_ID

\(fn ITEM_ID)" t nil)

(autoload 'pocket-api-delete "pocket-api" "\
Delete item which specified by ITEM_ID

\(fn ITEM_ID)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "pocket-api" '("pocket-api-")))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; pocket-api-autoloads.el ends here
