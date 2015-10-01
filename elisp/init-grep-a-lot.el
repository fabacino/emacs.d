(require 'grep-a-lot)
(grep-a-lot-setup-keys)

;; Append search string to buffer name
(let ((regexp grep-a-lot-buffer-name-regexp))
  ;; Change regular expression in order to keep grep-a-lot from recognizing its buffers
  (if (equal (substring regexp -1) "$")
      (setq regexp (substring regexp 0 -1)))
  (setq grep-a-lot-buffer-name-regexp (concat regexp ".*$")))
(defmacro fbn/grep-a-lot-advise (func)
  "Advise a grep-like function FUNC to include the search string in its buffer name."
  (let ((name (make-symbol (concat "fbn/" (symbol-name func) "-advise"))))
    `(defadvice ,func (after ,name activate)
       "Append search string used for grep to buffer name"
       (let ((search-string (ad-get-arg 0))
             (grep-buffer (grep-a-lot-last-buffer)))
         (with-current-buffer grep-buffer
           (rename-buffer (concat (buffer-name grep-buffer) "|" search-string)))))))
(fbn/grep-a-lot-advise grep)
(fbn/grep-a-lot-advise lgrep)
(fbn/grep-a-lot-advise rgrep)


(provide 'init-grep-a-lot)
