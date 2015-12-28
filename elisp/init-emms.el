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



(let* ((file "/home/fbn/Music/Japan/Oda Kazumasa/1991 - oh! yeah!/01 - sora ga taka sugiru.mp3")
       (track (emms-track 'file file)))
  track
  )



(defun emms-browser-track-artist-and-title-format (bdata fmt)
  (concat
   "%i"
   (let ((track (emms-browser-format-elem fmt "T")))
     (if (and track (not (string= track "0")))
         "%T. "
       ""))
   "%n"))

(defvar emms-browser-info-title-format
  'fbn/emms-browser-info-track-format)


(defun fbn/emms-browser-info-track-format (bdata fmt)
  "Advice for helm to not execute the action in case there is only one entry available."
  (print bdata)
  (print fmt)
  (emms-browser-track-artist-and-title-format bdata fmt))

  (let ((helm-execute-action-at-once-if-one nil))
    (apply orig-fun plist)))

;;; filter-returnアドバイス
(defun advice:filter-return (x)
  (intern (format "%s:filter-return" x)))
(advice:reset)
(advice-add 'advice:1 :filter-return 'advice:filter-return)
(advice:start)
;; => (:return original:filter-return :route
;;             ((original 256)))


;(advice-add 'emms-browser-track-artist-and-title-format :around #'fbn/emms-browser-track-format)
;(advice-add 'emms-browser-track-artist-and-title-format :filter-return #'fbn/emms-browser-track-format)
;(advice-remove 'emms-browser-track-artist-and-title-format #'fbn/emms-browser-track-format)





(defvar emms-browser-info-title-format "%i%n (%f)")
(makunbound 'emms-browser-info-title-format)
emms-browser-default-format
"%i%n"
  
      (metadata) (info-artist . "小田和正") (info-title . "空が高すぎる") (info-album . "Oh! Yeah!") (info-tracknumber . "01") (info-year . "1991") (info-genre . "JPop") (info-playing-time . 222) (info-mtime 21813 49332 200000 0)))



((*track* (type . file) (name . "/home/fbn/Music/Japan/Oda Kazumasa/1991 - oh! yeah!/01 - sora ga taka sugiru.mp3") (metadata) (info-artist . "小田和正") (info-title . "空が高すぎる") (info-album . "Oh! Yeah!") (info-tracknumber . "01") (info-year . "1991") (info-genre . "JPop") (info-playing-time . 222) (info-mtime 21813 49332 200000 0)))


