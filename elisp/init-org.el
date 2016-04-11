(require 'org)

(global-set-key (kbd "<f12>") 'org-agenda)
(setq org-agenda-files (list "~/org"))
(setq org-log-done t)

(global-set-key (kbd "C-c c") 'org-capture)
(setq org-default-notes-file (concat org-directory "/journal.org"))
(setq org-capture-templates
      '(("t" "Todo" entry (file+headline "gtd.org" "Tasks")
         "* TODO %?\n:PROPERTIES:\n:CREATED: %U\n:END:\n\n")
        ("j" "Journal" entry (file nil)
         "* %?\n:PROPERTIES:\n:CREATED: %U\n:END:\n\n")
        ("b" "Bookmark" entry (file+headline "bookmarks.org" "NEW")
         "* %?\n:PROPERTIES:\n:CREATED: %U\n:END:\n\n")))

;; Allow code blocks in these languages to be executed within org files
(require 'ob-emacs-lisp)
(require 'ob-shell)
(require 'ob-python)


(provide 'init-org)
