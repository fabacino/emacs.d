(require 'org)
(require 'org-id)

;; Common settings for org-mode
(global-set-key (kbd "<f12>") 'org-agenda)
(setq org-directory "~/git/org")
(setq org-agenda-files (list org-directory
                             (concat org-directory "/home")
                             (concat org-directory "/office")))
(setq org-log-done t)
(setq org-clock-out-remove-zero-time-clocks t)
(setq org-goto-interface 'outline-path-completion)
(setq org-outline-path-complete-in-steps nil)
(setq org-agenda-clockreport-parameter-plist
      '(:link t :maxlevel 5 :fileskip0 t :narrow 80 :formula %))

;; Settings for org-capture
(global-set-key (kbd "C-c c") 'org-capture)
(setq org-default-notes-file (concat org-directory "/journal.org"))
(setq org-capture-templates
      '(("b" "Bookmark" entry (file+headline "bookmarks.org" "NEW")
         "* %c%?\n:PROPERTIES:\n:CREATED: %U\n:END:\n")

        ("h" "Home")
        ("ht" "Todo" entry (file+headline "home/gtd.org" "Tasks")
         "* TODO %?\n:PROPERTIES:\n:CREATED: %U\n:END:\n")
        ("hc" "Calendar" entry (file+headline "home/gtd.org" "Calendar")
         "* %?\n%^T\n")
        ("hj" "Journal" entry (file "home/journal.org")
         "* %?\n:PROPERTIES:\n:CREATED: %U\n:END:\n")
        ("hr" "Read")
        ("hrb" "Book" entry (file+headline "home/read.org" "Books")
         "* NEW %?\n:PROPERTIES:\n:CREATED: %U\n:END:\n")
        ("hre" "E-Book" entry (file+headline "home/read.org" "E-Books")
         "* NEW %?\n:PROPERTIES:\n:CREATED: %U\n:END:\n")
        ("hw" "Watch")
        ("hwa" "Anime" entry (file+headline "home/watch.org" "Anime")
         "* NEW %?\n:PROPERTIES:\n:CREATED: %U\n:END:\n")
        ("hwd" "Dorama" entry (file+headline "home/watch.org" "Dorama")
         "* NEW %?\n:PROPERTIES:\n:CREATED: %U\n:END:\n")
        ("hwm" "Movie" entry (file+headline "home/watch.org" "Movies")
         "* NEW %?\n:PROPERTIES:\n:CREATED: %U\n:END:\n")
        ("hws" "Series" entry (file+headline "home/watch.org" "Series")
         "* NEW %?\n:PROPERTIES:\n:CREATED: %U\n:END:\n")

        ("o" "Office")
        ("ot" "Todo" entry (file+headline "office/gtd.org" "Tasks")
         "* TODO %?\n:PROPERTIES:\n:CREATED: %U\n:END:\n")
        ("oc" "Calendar" entry (file+headline "office/gtd.org" "Calendar")
         "* %?\n%^T\n")
        ("oj" "Journal" entry (file  "office/journal.org")
         "* %?\n:PROPERTIES:\n:CREATED: %U\n:END:\n")
        ("ok" "Concept" entry (file+headline "office/gtd.org" "Tasks")
         "* TODO %? %(org-set-tags-to \":CONCEPT:\")\n:PROPERTIES:\n:CREATED: %U\n:END:\n")
        ("ot" "Deadline" entry (file+headline "office/gtd.org" "Calendar")
         "* TODO %? %^T %(org-set-tags-to \":DEADLINE_:\")\n")
        ("od" "Development" entry (file+headline "office/gtd.org" "Tasks")
         "* TODO %? %(org-set-tags-to \":DEV:\")\n:PROPERTIES:\n:CREATED: %U\n:END:\n")
        ("ol" "Implementation" entry (file+headline "office/gtd.org" "Tasks")
         "* TODO %? %(org-set-tags-to \":IMPLEMENTATION:\")\n:PROPERTIES:\n:CREATED: %U\n:END:\n")
        ("oi" "Internal" entry (file+headline "office/gtd.org" "Tasks")
         "* TODO %? %(org-set-tags-to \":INTERNAL:\")\n:PROPERTIES:\n:CREATED: %U\n:END:\n")
        ("om" "Meeting" entry (file+headline "office/gtd.org" "Calendar")
         "* TODO %? %^T %(org-set-tags-to \":MEETING:\")\n")
        ("op" "Pull request" entry (file+headline "office/gtd.org" "Tasks")
         "* TODO %? %(org-set-tags-to \":PULLREQUEST:\")\n:PROPERTIES:\n:CREATED: %U\n:END:\n")
        ("os" "Support" entry (file+headline "office/gtd.org" "Tasks")
         "* TODO %? %(org-set-tags-to \":SUPPORT:\")\n:PROPERTIES:\n:CREATED: %U\n:END:\n")))

;; Allow code blocks in these languages to be executed within org files
(require 'ob-emacs-lisp)
(require 'ob-shell)
(require 'ob-python)

(defun fbn/org-remove-inherited-tags ()
  "Remove inherited tags from the headline at point."
  (interactive)
  (let ((current-tags (org-get-tags))
        inherited-tags)
    ;; Get inherited tags.
    (org-set-tags-to nil)
    (setq inherited-tags
          (mapcar
           #'(lambda (x)
               (if (text-properties-at 0 x)
                   (substring-no-properties x)
                 nil))
           (org-get-tags-at)))
    (org-set-tags-to current-tags)
    ;; Remove tags already inherited.
    (dolist (tag (org-get-tags))
      (when (member tag inherited-tags)
        (org-toggle-tag tag 'off)))))

(defun fbn/org-remove-all-inherited-tags ()
  "Remove inherited tags from all the headlines."
  (interactive)
  (save-excursion
    (goto-char (point-min))
    (let ((start-pos (or (and (org-at-heading-p)
                              (point))
                         (outline-next-heading))))
      (while start-pos
        (fbn/org-remove-inherited-tags)
        (setq start-pos (outline-next-heading))))))

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
