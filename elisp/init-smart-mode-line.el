(require 'smart-mode-line)
(sml/setup)
(rich-minority-mode 1)

;; Do not show global modes
(add-to-list 'rm-blacklist " Helm")
(add-to-list 'rm-blacklist " Undo-Tree")
(add-to-list 'rm-blacklist " yas")


(provide 'init-smart-mode-line)
