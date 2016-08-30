(require 'w3m)
(global-set-key (kbd "<f8>") 'w3m-goto-url-new-session)
(setq browse-url-browser-function 'w3m-goto-url-new-session)
(defun fbn/w3m-hook ()
  (local-set-key (kbd "M") 'w3m-view-url-with-browse-url))
(add-hook 'w3m-mode-hook 'fbn/w3m-hook)


(provide 'init-w3m)
