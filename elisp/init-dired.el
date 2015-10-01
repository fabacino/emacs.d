(require 'dired+)

;; Adjust dired functions for locate-mode
;; This does not work out of the box for windows
(when (string-equal system-type "windows-nt")
  (require 'dired)
  (defadvice dired-get-filename (before fbn/dired-get-filename-advise activate)
    "Locate lists full paths, therefore we always want the filename on each line to be
interpreted verbatim."
    (if (equal major-mode 'locate-mode)
        (ad-set-arg 0 'verbatim))))


(provide 'init-dired)
