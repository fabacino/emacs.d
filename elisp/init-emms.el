(require 'emms-setup)
(emms-all)
(emms-default-players)

;(setq emms-info-asynchronously nil)
;     (setq emms-playlist-buffer-name "*Music*")
(setq emms-source-file-directory-tree-function 'emms-source-file-directory-tree-find)
(setq emms-source-file-default-directory "~/Music/")
(global-set-key (kbd "<f7>") 'emms-smart-browse)
(setq emms-info-mp3info-program-name "mp3infov2")

;; Add disc number to arguments otherwise the sort order is not
;; correct for albums with multiple discs
(let ((tail (cdr emms-info-mp3find-arguments)))
  (setcar tail (concat (car tail) "info-discnumber=%d\\n"))
  (setcdr emms-info-mp3find-arguments tail))
emms-info-mp3find-arguments

(define-key emms-browser-mode-map (kbd "g") 'fbn/emms-browser-info-reload)
(define-key emms-playlist-mode-map (kbd "g") 'fbn/emms-playlist-info-reload)

(defun fbn/emms-browser-info-reload ()
  (interactive)
  (fbn/emms-info-reload (emms-browser-tracks-at-point)))

(defun fbn/emms-playlist-info-reload ()
  (interactive)
  (fbn/emms-info-reload (list (emms-playlist-track-at))))
  
(defun fbn/emms-info-reload (tracks)
  (mapc (lambda (track)
          (let ((filename (emms-track-name track)))
            (emms-cache-del filename)
            (emms-add-file filename)))
        tracks))


(provide 'init-emms)
