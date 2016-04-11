;; Windows specific settings
(if (string-equal system-type "windows-nt")
    (require 'init-windows))

;; General settings
(defalias 'yes-or-no-p 'y-or-n-p)
(blink-cursor-mode 0)
(column-number-mode)
(global-auto-revert-mode)
(icomplete-mode)
(show-paren-mode)
(menu-bar-mode 0)
(tool-bar-mode 0)
(scroll-bar-mode 0)
(winner-mode)

(setq confirm-kill-emacs 'y-or-n-p)
(setq display-buffer-reuse-frames t)
(setq-default indent-tabs-mode nil)
(setq tab-width 4)

(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
;(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))

;; Enable disabled commands
(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)

;; Add abbrev from expansion: C-x a g
;; Add abbrev from abbreviation: C-x a i g
(setq-default abbrev-mode t)

;; Use hydra for better organisation of keybindings
(require 'hydra)

;; ediff configuration
(require 'ediff)
(setq ediff-window-setup-function 'ediff-setup-windows-plain)
(setq ediff-split-window-function 'split-window-horizontally)

;; Use ibuffer for listing buffers
(defalias 'list-buffers 'ibuffer)
(setq ibuffer-formats (quote ((mark modified read-only " " (name 36 36 :left :elide) " " (size 9 -1 :right) " " (mode 20 20 :left :elide) " " filename-and-process) (mark " " (name 16 -1) " " filename))))

;; Use ido
;; ido-mode is left diabled since helm has support for ido
(setq ido-enable-flex-matching nil)
(setq ido-everywhere nil)

;; Use recentf
(recentf-mode t)
(setq recentf-max-saved-items 100)

;; Use transpose-frame
(require 'transpose-frame)

;; Use uniquifiy
(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward)

;; Use windmove to move around windows more naturally
(if (string-equal system-type "windows-nt")
  (progn
    (windmove-default-keybindings 'meta)
    (global-set-key (kbd "<apps> s") 'windmove-left)
    (global-set-key (kbd "<apps> e") 'windmove-up)
    (global-set-key (kbd "<apps> d") 'windmove-down)
    (global-set-key (kbd "<apps> f") 'windmove-right))
  (progn
    (windmove-default-keybindings 'super)
    (global-set-key (kbd "C-s-j") 'windmove-left)
    (global-set-key (kbd "C-s-i") 'windmove-up)
    (global-set-key (kbd "C-s-k") 'windmove-down)
    (global-set-key (kbd "C-s-l") 'windmove-right)))

(defun goto-previous-occurrence ()
  "Backward search word/char at point."
  (interactive)
  (execute-kbd-macro [?\C-r ?\C-w ?\C-r return]))
(global-set-key (kbd "M-p") 'goto-previous-occurrence)

(defun goto-next-occurrence ()
  "Forward search word/char at point."
  (interactive)
  (execute-kbd-macro [?\C-s ?\C-w ?\C-s return ?\M-b]))
(global-set-key (kbd "M-n") 'goto-next-occurrence)

(defun push-mark-no-activate ()
  "Pushes `point' to `mark-ring' and does not activate the region.
Equivalent to \\[set-mark-command] when \\[transient-mark-mode] is disabled."
  (interactive)
  (push-mark (point) t nil)
  (message "Pushed mark to ring"))
(global-set-key (kbd "C-,") 'push-mark-no-activate)

(defun jump-to-mark ()
  "Jumps to the local mark, respecting the `mark-ring' order.
This is the same as using \\[set-mark-command] with the prefix argument."
  (interactive)
  (set-mark-command 1))
(global-set-key (kbd "C-.") 'jump-to-mark)

(defun kill-this-buffer ()
  "Kill current buffer."
  (interactive) 
  (kill-buffer (current-buffer)))
(global-set-key (kbd "C-x k") 'kill-this-buffer)

(defun create-temporary-file ()
  "Create temporary file."
  (interactive)
  (let* ((index 0)
         (tmp-file (make-temp-file "emacs_")))
    (while (get-buffer (concat "tmp" (number-to-string index)))
      (incf index))
    (find-file tmp-file)
    (rename-buffer (concat "tmp" (number-to-string index)))))
(global-set-key (kbd "<f5>") 'create-temporary-file)

(defun fbn/frame-title-buffer-name (name)
  "Modify buffer name for main frame title."
  name)

(defun fbn/set-frame-title-format (&optional prefix)
  "Set format used for main frame title.
If PREFIX is not given, the variable `system-name' is used. For buffers
associated with a file the full path is shown. Modifications can be made
through the function `fbn/frame-title-buffer-name'."
  (interactive "sPrefix: ")
  (setq frame-title-format
        (list (format "%s %%S: %%j" (if prefix prefix (system-name)))
              '(:eval (if (buffer-file-name)
                          (fbn/frame-title-buffer-name buffer-file-name)
                        (buffer-name))))))
(fbn/set-frame-title-format)

;; Use mozc for japanese input
;(set-language-environment "Japanese")
;(if (featurep 'mozc)
;    (progn
;      (require 'mozc)
;      (setq default-input-method "japanese-mozc")))

;; Use japanese font for kanji
;; Unfortunately, setting the font does not work when emacs is used in daemon
;; mode. We therefore use a function, so we can call it later in case the font
;; has not been set correctly.
(defun fbn/set-jp-font ()
  (interactive)
  (set-fontset-font "fontset-default" 'japanese-jisx0208
                    (font-spec :family "Source Han Sans JP" :size 14)))
(fbn/set-jp-font)


(provide 'init-base)
