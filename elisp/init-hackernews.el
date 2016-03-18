(add-to-list 'load-path (expand-file-name "git/hackernews/" user-emacs-directory))
(require 'hackernews)

(setq hackernews-top-story-limit 25)


(provide 'init-hackernews)
