;; Enables to go to windows explorer from dired (C-RET, M-RET)
(require 'w32-browser)

;; The environment variables TEMP and TMP may contain the username in SFN
;; which can be rather inconvenient, because in this case you have a mix of
;; LFN (almost everything, notable buffer filenames) and SFN (variable
;; `temporary-file-directory). To avoid headaches due to this inconsistency,
;; we use LFN for the variable `temporary-file-directory as well.
(require 's)
(let* ((lfn (getenv "USERNAME"))
       (sfn (concat (substring (upcase lfn) 0 6) "~1")))
  (setq temporary-file-directory (s-replace sfn lfn temporary-file-directory)))


(provide 'init-windows)
