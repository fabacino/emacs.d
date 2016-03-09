(require 'helm-config)
(helm-mode t)
(setq helm-buffers-fuzzy-matching t)
;(setq helm-buffer-max-length 36)
(setq helm-ff-file-name-history-use-recentf t)
(setq helm-move-to-line-cycle-in-source t)
(setq helm-quick-update t)
(setq helm-scroll-amount 8)
(setq helm-split-window-in-side-p t)

;; Keybindings
(global-set-key (kbd "M-x") 'helm-M-x)
;(global-set-key (kbd "C-x b") 'helm-buffers-list)
(global-set-key (kbd "C-x b") 'helm-mini)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
;; Switch TAB und C-z
(define-key helm-map (kbd "TAB") 'helm-execute-persistent-action)
(define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ; make TAB work in terminal
(define-key helm-map (kbd "C-z") 'helm-select-action)
;; C-o is helm-next-source
(define-key helm-map (kbd "M-o") 'helm-previous-source)

;; History functions
(require 'helm-eshell)
(defun fbn/eshell-mode-hook ()
  (define-key eshell-mode-map (kbd "C-c C-l")  'helm-eshell-history))
(add-hook 'eshell-mode-hook 'fbn/eshell-mode-hook)
(define-key shell-mode-map (kbd "C-c C-l") 'helm-comint-input-ring)
(define-key minibuffer-local-map (kbd "C-c C-l") 'helm-minibuffer-history)

;; helm for auto-complete
(require 'ac-helm)
(define-key ac-mode-map (kbd "M-i") 'ac-complete-with-helm)

;; helm-do-grep was considered useless and thus deleted. I still think
;; it is pretty useful, since it is much faster to invoke than doing
;; helm-find-files or friends and select the grep action.
(defun fbn/helm-do-grep ()
  "Preconfigured helm for grep.
Contrarily to Emacs `grep', no default directory is given, but
the full path of candidates in ONLY.
That allow to grep different files not only in `default-directory' but anywhere
by marking them (C-<SPACE>). If one or more directory is selected
grep will search in all files of these directories.
You can also use wildcard in the base name of candidate.
If a prefix arg is given use the -r option of grep (recurse).
The prefix arg can be passed before or after start file selection.
See also `helm-do-grep-1'."
  (interactive)
  (require 'helm-mode)
  (let* ((preselection (buffer-file-name (current-buffer)))
         (only    (helm-read-file-name
                   "Search in file(s): "
                   :marked-candidates t
                   :preselect (if (and preselection
                                       helm-ff-transformer-show-only-basename)
                                  (helm-basename preselection)
                                preselection)))
         (prefarg (or current-prefix-arg helm-current-prefix-arg)))
    (helm-do-grep-1 only prefarg)))

;; helm-multi-occur was deleted as well...
(defun fbn/helm-multi-occur ()
  "Preconfigured helm for multi occur.
With a prefix arg, reverse the behavior of
`helm-moccur-always-search-in-current'.
The prefix arg can be set before calling
`helm-multi-occur-from-isearch' or during the buffer selection."
  (interactive)
  (let ((buf-list (helm-comp-read "Buffers: "
                                   (helm-buffer-list)
                                   :name "Occur in buffer(s)"
                                   :marked-candidates t))
        (helm-moccur-always-search-in-current
         (if (or current-prefix-arg
                  helm-current-prefix-arg)
              (not helm-moccur-always-search-in-current)
            helm-moccur-always-search-in-current)))
    (helm-multi-occur-1 buf-list)))

;; helm-gtags
(require 'helm-gtags)
(require 's)
(setq helm-gtags-ignore-case t)
(setq helm-gtags-auto-update t)
(setq helm-gtags-use-input-at-cursor t)
(setq helm-gtags-maximum-candidates 1000)
(eval-after-load "helm-gtags"
  '(progn
     (define-key helm-gtags-mode-map (kbd "M-.") 'helm-gtags-dwim)
     (define-key helm-gtags-mode-map (kbd "M-]") 'helm-gtags-find-rtag)
     (define-key helm-gtags-mode-map (kbd "C-M-.") 'helm-gtags-select)
     (define-key helm-gtags-mode-map (kbd "C-c M-p") 'helm-gtags-previous-history)
     (define-key helm-gtags-mode-map (kbd "C-c M-n") 'helm-gtags-next-history)
     (define-key helm-gtags-mode-map (kbd "C-c M-?") 'fbn/helm-gtags-show-definition)))

;; Add function to show definition
(defvar fbn/helm-gtags-definitions-first-call t)

;; Error signal if there is only a single definition available
(define-error 'fbn/helm-gtags--error-single-definition "There is only a single definition available")

(defun fbn/helm-gtags-show-definition (tag)
  "Display function definition.
If there is only a single interface available when this function is invoked,
the interface will be displayed in the echo-area. Otherwise a normal helm
buffer is opened."
  (interactive
   (list (helm-gtags--read-tagname 'tag)))
  (setq fbn/helm-gtags-definitions-first-call t)
  (unwind-protect
      (progn
        (advice-add 'helm :around #'fbn/helm/disable-action-at-once-if-one)
        (condition-case data
            (helm-gtags--common '(fbn/helm-source-gtags-definitions) tag)
          (fbn/helm-gtags--error-single-definition
           (let (message-log-max)
             (message "%s" (cadr data))))))
    (advice-remove 'helm #'fbn/helm/disable-action-at-once-if-one)))

(defvar fbn/helm-source-gtags-definitions
  (helm-build-in-buffer-source "Display definitions"
    :init 'fbn/helm-gtags--definitions-init
    :candidate-number-limit helm-gtags-maximum-candidates
    :filtered-candidate-transformer 'fbn/helm-gtags--definitions-transformer
    :real-to-display 'helm-gtags--candidate-transformer
    :persistent-action 'helm-gtags--persistent-action
    :fuzzy-match helm-gtags-fuzzy-match
    :action helm-gtags--find-file-action))

(defun fbn/helm-gtags--definitions-init (&optional input)
  (helm-gtags--exec-global-command 'tag input))

(defun fbn/helm-gtags--definitions-transformer (candidates source)
  "Throw signal if the function interface is the same for all entries."
  (if fbn/helm-gtags-definitions-first-call
      (progn
        (let ((unique-candidates (make-hash-table :test 'equal))
              (unique-value))
          (mapcar (lambda (entry)
                    (let* ((separator ":")
                           (value (cdr entry))
                           (parts (split-string value separator))
                           (removed-parts (s-concat (s-join separator (butlast parts 1)) separator)))
                      (setq value (s-replace removed-parts "" value))
                      (puthash value t unique-candidates)
                      (setq unique-value (s-replace removed-parts "" (car entry))))) candidates)
          (if (eq (hash-table-count unique-candidates) 1)
              (signal 'fbn/helm-gtags--error-single-definition (list (s-trim unique-value)))))))
  (setq fbn/helm-gtags-definitions-first-call nil)
  (car (list candidates)))

(defun fbn/helm/disable-action-at-once-if-one (orig-fun &rest plist)
  "Advice for helm to not execute the action in case there is only one entry available."
  (let ((helm-execute-action-at-once-if-one nil))
    (apply orig-fun plist)))


(provide 'init-helm)
