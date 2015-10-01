;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Initial setup
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; This assumes that Cygwin is installed in C:\cygwin (the
;; default) and that C:\cygwin\bin is not already in your
;; Windows Path (it generally should not be).

(setq exec-path (cons "C:/cygwin/bin" exec-path))
(setenv "PATH" (concat "C:\\cygwin\\bin;" (getenv "PATH")))

;;   LOGNAME and USER are expected in many Emacs packages
;;   Check these environment variables.

(if (and (null (getenv "USER"))
	 ;; Windows includes variable USERNAME, which is copied to
	 ;; LOGNAME and USER respectively.
	 (getenv "USERNAME"))
    (setenv "USER" (getenv "USERNAME")))

(if (and (getenv "LOGNAME")
	 ;;  Bash shell defines only LOGNAME
	 (null (getenv "USER")))
    (setenv "USER" (getenv "LOGNAME")))

(if (and (getenv "USER")
	 (null (getenv "LOGNAME")))
    (setenv "LOGNAME" (getenv "USER")))

;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (A) M-x shell: This change M-x shell permanently
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Would call Windows command interpreter. Change it.

(setq shell-file-name "bash")
(setenv "SHELL" shell-file-name)
(setq explicit-shell-file-name shell-file-name)

;; Remove C-m (^M) characters that appear in output

(add-hook 'comint-output-filter-functions
          'comint-strip-ctrl-m)

;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (B) *OR* call following function with M-x my-bash
;; The M-x shell would continue to run standard Windows shell
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun my-bash (&optional buffer)
  "Run Cygwin Bash shell in optional BUFFER; default *shell-bash*."
  (autoload 'comint-check-proc "comint")
  (interactive
   (let ((name "*shell-bash*"))
     (if current-prefix-arg
	 (setq name (read-string
		     (format "Cygwin shell buffer (default %s): " name)
		     (not 'initial-input)
		     (not 'history)
		     name)))
     (list name)))
  (or buffer
      (setq buffer "*shell-bash*"))
  (if (comint-check-proc buffer)
      (pop-to-buffer buffer)
    (let* ((shell-file-name            "bash")
	   (explicit-shell-file-name   shell-file-name)
	   (explicit-sh-args           '("--login" "-i"))
	   (explicit-bash-args         explicit-sh-args)
	   (w32-quote-process-args     ?\"));; Use Cygwin quoting rules.
      (shell buffer)
      ;;  By default Emacs sends "\r\n", but bash wants plain "\n"
      (set-buffer-process-coding-system 'undecided-dos 'undecided-unix)
      ;; With TAB completion, add slash path separator, none to filenames
      (make-local-variable 'comint-completion-addsuffix)
      (setq comint-completion-addsuffix '("/" . ""))
      ;;  This variable is local to buffer
      (setq comint-prompt-regexp "^[ \n\t]*[$] ?"))))

(require 'cygwin-mount)
(cygwin-mount-activate)

;; Info must be initialized before the packages, otherwise the variable
;; Info-directory-list is non-empty which in turn prevents the defaults
;; from Info-default-directory-list to be applied.
(require 'info)
;; When running NTEmacs under Cygwin, the environment variable INFOPATH
;; might be separated by colon (Linux), while the variable path-separator
;; is set to semi-colon (Windows). In this case info cannot be initialized
;; properly unless we temporarily set the separator to the linux-style value.
(let ((path (getenv "INFOPATH"))
      (linux-sep ":")
      (orig-sep path-separator))
  (if (and (not (equal orig-sep linux-sep))
           path
           (equal (substring path -1) linux-sep))
      (progn
        (setq path-separator linux-sep)
        (info-initialize)
        (setq path-separator orig-sep))
    (info-initialize)))
