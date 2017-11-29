;; Custom key bindings
;  (fbn/global-set-key "a" 'helm-apropos t)
(fbn/global-set-key "b" 'helm-resume t)
;  (fbn/global-set-key "f" 'helm-for-files t)
(fbn/global-set-key "i" 'counsel-imenu t)
;  (fbn/global-set-key "l" 'helm-locate t)
;  (fbn/global-set-key "o" 'helm-occur t)
(fbn/global-set-key "m" 'helm-man-woman t)
;  (fbn/global-set-key "r" 'helm-recentf t)
(fbn/global-set-key "x" 'helm-register t)
(fbn/global-set-key "SPC" 'helm-all-mark-rings t)
(fbn/global-set-key "TAB" 'helm-lisp-completion-at-point t)
;  (fbn/global-set-key "/" 'helm-find t)

;; Use C-h as backspace
(global-set-key (kbd "C-h") 'backward-delete-char-untabify)
(global-set-key (kbd "C-c h") 'help-command)
(global-set-key (kbd "C-<f1>") 'help-command)

;; Use C-w as backspace kill word
(global-set-key (kbd "C-w") 'backward-kill-word)
(global-set-key (kbd "C-x C-k") 'kill-region)

;;; Hydras
(require 'hydra-examples)
;; Find/search stuff
(global-set-key
 (kbd "<f2>")
 (defhydra hydra-find (:exit t)
   "
^Find^          ^Search^
^^^^^^^^--------------------------
_f_: files         _g_: rgrep     
_l_: locate        _d_: lgrep     
_p_: projectile    _o_: occur     
_r_: recent        ^ ^            
_/_: find          ^ ^            
"
   ("f" helm-for-files nil)
   ("l" counsel-locate nil)
   ("p" counsel-projectile nil)
   ("r" helm-recentf nil)
   ("/" helm-find nil)
   ("g" (lambda () (interactive)
          (let ((current-prefix-arg '(4)))
            (call-interactively 'fbn/helm-do-grep))) nil)
   ("d" fbn/helm-do-grep nil)
   ("G" rgrep nil)
   ("D" lgrep nil)
   ("o" helm-occur nil)
   ("O" fbn/helm-multi-occur nil)
   ("q" nil nil)))

;; Help
(global-set-key
 (kbd "<f1>")
 (defhydra hydra-help (:exit t)
   "
Help
---------------------------------------------------------------------------------------------------------
_a_: apropos           _i_: info                     _r_: emacs manual      _C-a_: about emacs           
_b_: bindings          _I_: input method             _s_: syntax            _C-c_: copying               
_c_: key briefly       _k_: key                      _S_: lookup symbol     _C-d_: emacs debugging       
_C_: coding system     _K_: key command node         _t_: tutorial          _C-e_: external packages     
_d_: apropos doc       _l_: lossage                  _v_: variable          _C-f_: emacs FAQ             
_e_: echo messages     _L_: language environment     _w_: where is          _C-m_: order manuals         
_f_: function          _m_: mode                     _._: local help        _C-o_: distribution          
_F_: command node      _n_: emacs news               _?_: help              _C-p_: emacs problems        
_g_: gnu project       _p_: find package             ^ ^                    _C-t_: emacs todo            
_h_: hello file        _P_: package                  ^ ^                    _C-w_: no-warranty           
"
   ("a" helm-apropos nil)
   ("b" counsel-descbinds nil)
   ("c" describe-key-briefly nil)
   ("C" describe-coding-system nil)
   ("d" apropos-documentation nil)
   ("e" view-echo-area-messages nil)
   ("f" counsel-describe-function nil)
   ("F" Info-goto-emacs-command-node nil)
   ("g" describe-gnu-project nil)
   ("h" view-hello-file nil)
   ("i" info nil)
   ("I" describe-input-method nil)
   ("k" describe-key nil)
   ("K" Info-goto-emacs-key-command-node nil)
   ("l" view-lossage nil)
   ("L" describe-language-environment nil)
   ("m" describe-mode nil)
   ("n" view-emacs-news nil)
   ("p" finder-by-keyword nil)
   ("P" describe-package nil)
   ("r" info-emacs-manual nil)
   ("s" describe-syntax nil)
   ("S" info-lookup-symbol nil)
   ("t" help-with-tutorial nil)
   ("v" counsel-describe-variable nil)
   ("w" where-is nil)
   ("." display-local-help nil)
   ("?" help-for-help nil)
   ("C-a" about-emacs nil)
   ("C-c" describe-copying nil)
   ("C-d" view-emacs-debugging nil)
   ("C-e" view-external-packages nil)
   ("C-f" view-emacs-FAQ nil)
   ("C-m" view-order-manuals nil)
;   ("C-n" view-emacs-news nil)
   ("C-o" describe-distribution nil)
   ("C-p" view-emacs-problems nil)
   ("C-t" view-emacs-todo nil)
   ("C-w" describe-no-warranty nil)
   ("q" nil nil)))

;; Zoom
(global-set-key
 (kbd "<f9>")
 (defhydra hydra-font ()
   "font"
   ("u" (lambda () (interactive)
          (text-scale-increase 0.5)) "size up")
   ("d" (lambda () (interactive)
          (text-scale-decrease 0.5)) "size down")
   ("t" variable-pitch-mode "toggle width")
   ("r" (lambda () (interactive)
          (text-scale-set 0)
          (if (bound-and-true-p buffer-face-mode)
              (variable-pitch-mode))) "reset" :exit t)
   ("j" fbn/set-jp-font "jp font")
   ("q" nil nil)))

;; Window
(global-set-key
 (kbd "C-M-o")
 (defhydra hydra-window (:color red
                        :columns nil)
   "window"
   ("j" windmove-left)
   ("k" windmove-down)
   ("i" windmove-up)
   ("l" windmove-right)
   ("J" hydra-move-splitter-left nil)
   ("K" hydra-move-splitter-down nil)
   ("I" hydra-move-splitter-up nil)
   ("L" hydra-move-splitter-right nil)
   ("v" (lambda () (interactive)
          (split-window-right)
          (windmove-right))
    "vert")
   ("x" (lambda () (interactive)
          (split-window-below)
          (windmove-down))
    "horz")
   ("t" transpose-frame "'")
   ("o" delete-other-windows "one" :exit t)
   ("a" ace-window "ace")
   ("s" ace-swap-window "swap")
   ("d" ace-delete-window "del")
   ("f" ace-maximize-window "ace-one" :exit t)
   ("b" ido-switch-buffer "buf")
   ("m" bookmark-jump "bmk")
   ("u" winner-undo "undo")
   ("r" winner-redo "redo")
   ("q" nil nil)))


(provide 'init-custom-keys)
