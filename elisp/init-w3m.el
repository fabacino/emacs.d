(require 'w3m)
(require 'w3m-search)

(global-set-key (kbd "<f8>") 'w3m-goto-url-new-session)
(setq browse-url-browser-function 'w3m-goto-url-new-session)

;; Use startpage to search things.
(add-to-list 'w3m-search-engine-alist
             '("startpage" "https://www.startpage.com/do/search" utf-8 "query=%s"))
(setq w3m-search-default-engine "startpage")

(defun fbn/w3m-hook ()
  (local-set-key (kbd "M") 'w3m-view-url-with-browse-url))
(add-hook 'w3m-mode-hook 'fbn/w3m-hook)

(defun fbn/w3m-rename-buffer (url)
  "Put url and title into the buffer name."
  (let ((name (concat "w3m - " w3m-current-title " [" w3m-current-url "]")))
    (rename-buffer name t)))
(add-hook 'w3m-display-hook 'fbn/w3m-rename-buffer)


(provide 'init-w3m)
