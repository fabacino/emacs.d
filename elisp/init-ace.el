(require 'ace-window)
(global-set-key (kbd "C-x o") 'ace-window)
(fbn/global-set-key "M-o" 'ace-window)
(fbn/global-set-key "C-u M-o"
                    (lambda() (interactive)
                      (let ((current-prefix-arg '(4)))
                        (call-interactively 'ace-window)))
                    t)

(setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))
(setq aw-scope 'frame)


(provide 'init-ace)
