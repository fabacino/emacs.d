(require 'org)

;; Common settings for org-mode
(global-set-key (kbd "<f12>") 'org-agenda)
(setq org-directory "~/org")
(setq org-agenda-files (list "~/org"))
(setq org-log-done t)
(setq org-clock-out-remove-zero-time-clocks t)

;; Settings for org-capture
(global-set-key (kbd "C-c c") 'org-capture)
(setq org-default-notes-file (concat org-directory "/journal.org"))
(setq org-capture-templates
      '(("t" "Todo" entry (file+headline "gtd.org" "Tasks")
         "* TODO %?\n:PROPERTIES:\n:CREATED: %U\n:END:\n")
        ("c" "Calendar" entry (file+headline "gtd.org" "Calendar")
         "* %?\nSCHEDULED: %^T\n")
        ("j" "Journal" entry (file nil)
         "* %?\n:PROPERTIES:\n:CREATED: %U\n:END:\n")
        ("b" "Bookmark" entry (file+headline "bookmarks.org" "NEW")
         "* %?\n:PROPERTIES:\n:CREATED: %U\n:END:\n")))

;; Allow code blocks in these languages to be executed within org files
(require 'ob-emacs-lisp)
(require 'ob-shell)
(require 'ob-python)

;; Punch-in/-out functionality
(setq bh/keep-clock-running nil)

(defun bh/punch-in (arg)
  "Start continuous clocking and set the default task to the
selected task.  If no task is selected set the Organization task
as the default task."
  (interactive "p")
  (setq bh/keep-clock-running t)
  (if (equal major-mode 'org-agenda-mode)
      ;; We're in the agenda
      (let* ((marker (org-get-at-bol 'org-hd-marker))
             (tags (org-with-point-at marker (org-get-tags-at))))
        (if (and (eq arg 4) tags)
            (org-agenda-clock-in '(16))
          (bh/clock-in-organization-task-as-default)))
    ;; We are not in the agenda
    (save-restriction
      (widen)
      ; Find the tags on the current task
      (if (and (equal major-mode 'org-mode) (not (org-before-first-heading-p)) (eq arg 4))
          (org-clock-in '(16))
        (bh/clock-in-organization-task-as-default)))))

(defun bh/punch-out ()
  (interactive)
  (setq bh/keep-clock-running nil)
  (when (org-clock-is-active)
    (org-clock-out))
  (org-agenda-remove-restriction-lock))

(defun bh/clock-in-default-task ()
  (save-excursion
    (org-with-point-at org-clock-default-task
      (org-clock-in))))

(defvar bh/organization-task-id "9e54cd1c-8098-4b5f-aed4-92360869c8ed")

(defun bh/clock-in-organization-task-as-default ()
  (interactive)
  (org-with-point-at (org-id-find bh/organization-task-id 'marker)
    (org-clock-in '(16))))

(defun bh/clock-out-maybe ()
  (when (and bh/keep-clock-running
             (not org-clock-clocking-in)
             (marker-buffer org-clock-default-task)
             (not org-clock-resolving-clocks-due-to-idleness))
    (bh/clock-in-default-task)))

(add-hook 'org-clock-out-hook 'bh/clock-out-maybe 'append)

(define-key org-mode-map (kbd "C-c i") 'bh/punch-in)
(define-key org-mode-map (kbd "C-c o") 'bh/punch-out)


(provide 'init-org)
