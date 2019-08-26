;; PROXY
(setq url-proxy-services
      '(("no_proxy" . "^\\(localhost\\|10.*\\)")
	("http" . "www-proxy.statoil.no:80")
	("https" . "www-proxy.statoil.no:80")))


;; ===================================MELPA===================================
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["black" "red3" "ForestGreen" "yellow3" "blue" "magenta3" "DeepSkyBlue" "gray50"])
 '(beacon-color "#cc6666")
 '(case-fold-search nil)
 '(custom-enabled-themes (quote (sanityinc-tomorrow-bright)))
 '(custom-safe-themes
   (quote
    ("1b8d67b43ff1723960eb5e0cba512a2c7a2ad544ddb2533a90101fd1852b426e" "06f0b439b62164c6f8f84fdda32b62fb50b6d00e8b01c2208e55543a6337433a" "28ec8ccf6190f6a73812df9bc91df54ce1d6132f18b4c8fcc85d45298569eb53" "2e1e2657303116350fe764484e8300ca2e4cf45a73cdbd879bc0ca29cb337147" "8c4acde8417375abc15f41f56d1ddad62e13a4bd886d381ea1a1d4620c932933" "392f19e7788de27faf128a6f56325123c47205f477da227baf6a6a918f73b5dc" default)))
 '(elpy-rpc-python-command "python")
 '(elpy-rpc-timeout 2)
 '(elpy-syntax-check-command "flake8")
 '(elpy-test-discover-runner-command (quote ("pytest" "" "")))
 '(elpy-test-pytest-runner-command (quote ("py.test")))
 '(elpy-test-runner (quote elpy-test-pytest-runner))
 '(fci-rule-color "#373b41")
 '(flycheck-color-mode-line-face-to-color (quote mode-line-buffer-id))
 '(inhibit-startup-screen t)
 '(vc-annotate-background nil)
 '(vc-annotate-color-map
   (quote
    ((20 . "#cc6666")
     (40 . "#de935f")
     (60 . "#f0c674")
     (80 . "#b5bd68")
     (100 . "#8abeb7")
     (120 . "#81a2be")
     (140 . "#b294bb")
     (160 . "#cc6666")
     (180 . "#de935f")
     (200 . "#f0c674")
     (220 . "#b5bd68")
     (240 . "#8abeb7")
     (260 . "#81a2be")
     (280 . "#b294bb")
     (300 . "#cc6666")
     (320 . "#de935f")
     (340 . "#f0c674")
     (360 . "#b5bd68"))))
 '(vc-annotate-very-old-color nil))



;; some settings
(setq load-prefer-newer t)

;; use one of these:
(load "/project/res/etc/emacs-modes/statoil-modes")
;;(load "/private/jriv/work/svn/emacs-modes/statoil-modes-test")

(add-to-list 'load-path "~/.emacs.d/aux")

;; remove trailing whitespace when saving sdsd
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; (global-linum-mode t)
(add-hook 'find-file-hook 'linum-mode)
(setq linum-format "%4d \u2502")

;; git gutter
;;(require 'git-gutter-fringe)
;;(global-git-gutter-mode t)
;;(setq git-gutter-fr:side 'right-fringe)

;; ----------------------------------------------------------C-----------------

;; Tell cc-mode not to check for old-style (K&R) function declarations.
;; This speeds up indenting a lot.
(setq c-recognize-knr-p nil)

;; Change the indentation amount to 4 spaces instead of 2.
(setq-default c-basic-offset 4)

(add-hook 'python-mode-hook
      (lambda ()
        (setq indent-tabs-mode nil)
        (setq tab-width 4)
        (setq python-indent 4)))

(add-hook 'python-mode-hook
          (lambda ()
            (add-to-list 'write-file-functions 'delete-trailing-whitespace)))

(require 'autopep8)

;; Use spaces instead of tabs
(setq-default indent-tabs-mode nil)

;; ----------------------------------------------------------aux---------------
;; backup
(setq backup-directory-alist `(("." . "~/.saves")))
(setq version-control t     ;; Use version numbers for backups.
      kept-new-versions 10  ;; Number of newest versions to keep.
      kept-old-versions 0   ;; Number of oldest versions to keep.
      delete-old-versions t ;; Don't ask to delete excess backup versions.
      backup-by-copying t)  ;; Copy all files, don't rename them.


;; ===================================THEMES===================================

(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
;;(load-theme 'zenburn t)

(load-theme 'ample t t)
(load-theme 'ample-flat t t)
(load-theme 'ample-light t t)
(load-theme 'zenburn t t)
(load-theme 'andreas t t)
(enable-theme 'ample)

;; ===================================ELPY=====================================

(package-initialize)
(elpy-enable)
(setq elpy-rpc-backend "rope")
;; Fixing a key binding bug in elpy
(define-key yas-minor-mode-map (kbd "C-c k") 'yas-expand)
;; Fixing another key binding bug in iedit mode
(define-key global-map (kbd "C-c o") 'iedit-mode)
;; (when (require 'flycheck nil t)
;;   (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
;;   (add-hook 'elpy-mode-hook 'flycheck-mode))
(when (load "flycheck" t t)
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))

;; added april 02, 2019
;;(defun flycheck-python-setup ()
;;  (flycheck-mode))
;;(add-hook 'python-mode-hook #'flycheck-python-setup)

;;(global-flycheck-mode 0)
;;(with-eval-after-load 'flycheck
;;  (add-hook 'flycheck-mode-hook #'flycheck-pycheckers-setup))
;; ===================================STUFF====================================

(defun rst-python-statement-is-docstring (begin)
  "Return true if beginning of statiment is :begin"
  (save-excursion
    (save-match-data
      (python-nav-beginning-of-statement)
      (looking-at-p begin))))

(defun rst-python-front-verify ()
  (rst-python-statement-is-docstring (match-string 0)))

(require 'mmm-mode)

(add-to-list 'mmm-save-local-variables 'adaptive-fill-regexp)
(add-to-list 'mmm-save-local-variables 'fill-paragraph-function)

(mmm-add-classes
 '((rst-python-docstrings
    :submode rst-mode
    :face mmm-comment-submode-face
    :front "u?\\(\"\"\"\\|\'\'\'\\)"
    :front-verify rst-python-front-verify
    :back "~1"
    :end-not-begin t
    :save-matches 1
    ;; :front rst-python-docstrings-find-front
    ;; :back rst-python-docstrings-find-back
    :insert ((?d embdocstring nil @ "u\"\"\"" @ _ @ "\"\"\"" @))
    :delimiter-mode nil)))

(mmm-add-mode-ext-class 'python-mode nil 'rst-python-docstrings)




;;sr-speeddir
(require 'sr-speedbar)
(setq speedbar-show-unknown-files t) ; show all files
(setq speedbar-use-images nil) ; use text for buttons
(setq sr-speedbar-right-side nil) ; put on left side
(setq sr-speedbar-width 20)

;; (require 'column-enforce-mode)
(add-hook 'prog-mode-hook 'column-enforce-mode)
(add-hook 'ipl-mode-hook 'column-enforce-mode)
;; (global-column-enforce-mode t)

(setq column-enforce-column 88)
;;(setq column-enforce-comments nil)

;;(require 'fill-column-indicator)


;; (setq-default
;;  whitespace-line-column 80
;;  whitespace-style       '(face lines-tail))

;;(add-hook 'c-mode-hook #'whitespace-mode)

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "DejaVu Sans Mono" :foundry "unknown" :slant normal :weight bold :height 173 :width normal)))))

(require 'flycheck-yamllint)
(eval-after-load 'flycheck
  '(add-hook 'flycheck-mode-hook 'flycheck-yamllint-setup))

(autoload 'pylint "pylint")
(add-hook 'python-mode-hook 'pylint-add-menu-items)
(add-hook 'python-mode-hook 'pylint-add-key-bindings)

;; ================================F key settings =============================


(global-set-key '[(f1)]          'comment-dwim)

(global-set-key '[(f2)]          'column-number-mode)

(global-set-key '[(f3)]          'whitespace-mode)

(global-set-key '[(f4)]          'find-file-at-point)

(global-set-key '[(f5)]          'hc-toggle-highlight-tabs)
(global-set-key '[(f6)]          'hc-toggle-highlight-trailing-whitespace)

(global-set-key [f7]             'sr-speedbar-toggle)

(global-set-key '[(f8)]          'undo)

(global-set-key '[(f9)]          'elpy-black-fix-code)
(global-set-key '[(ctrl f9)]     'pylint)
(global-set-key '[(shift f9)]    'minimap-mode)
(global-set-key '[(f10)]         'column-enforce-mode)
(global-set-key '[(f11)]         'theme-looper-enable-next-theme)
(global-set-key '[(f12)]         'default-text-scale-increase)
(global-set-key '[(shift f12)]   'default-text-scale-decrease)


;; font cycling
(defcustom xah-font-list nil "A list of fonts for `xah-cycle-font' to cycle from." :group 'font)
(set-default 'xah-font-list
             (cond
              ((string-equal system-type "windows-nt") ; Windows
               '(
                 "Lucida Console-10"
                 "Lucida Sans Unicode-10"
                 ))
              ((string-equal system-type "gnu/linux")
               '(
                 "Monospace-16"
                 "DejaVu Sans Mono-16"
                 "DejaVu Sans Mono-14"
                 "DejaVu Sans Mono-12"
                 "DejaVu Sans Mono:size=17:weight=bold"
                 "Liberation Mono:size=16"
                 ))
              ((string-equal system-type "darwin") ; Mac
               '(
                 "DejaVu Sans Mono-9"
                 "DejaVu Sans-9"
                 "Symbola-13"
                 ))))
(defun xah-cycle-font (@n)
  "Change font in current frame.
Each time this is called, font cycles thru a predefined list of fonts in the variable `xah-font-list' .
If *n is 1, cycle forward.
If *n is -1, cycle backward.
See also `xah-cycle-font-next', `xah-cycle-font-previous'.
URL `http://ergoemacs.org/emacs/emacs_switching_fonts.html'
Version 2015-09-21"
  (interactive "p")
  ;; this function sets a property “state”. It is a integer. Possible values are any index to the fontList.
  (let ($fontToUse $stateBefore $stateAfter )
    (setq $stateBefore (if (get 'xah-cycle-font 'state) (get 'xah-cycle-font 'state) 0))
    (setq $stateAfter (% (+ $stateBefore (length xah-font-list) @n) (length xah-font-list)))
    (setq $fontToUse (nth $stateAfter xah-font-list))
    (set-frame-font $fontToUse t)
    ;; (set-frame-parameter nil 'font ξfontToUse)
    (message "Current font is: %s" $fontToUse )
    (put 'xah-cycle-font 'state $stateAfter)))

(defun xah-cycle-font-next ()
  "Switch to the next font, in current window.
See `xah-cycle-font'."
  (interactive)
  (xah-cycle-font 1))

(defun xah-cycle-font-previous ()
  "Switch to the previous font, in current window.
See `xah-cycle-font'."
  (interactive)
  (xah-cycle-font -1))


(global-set-key '[(ctrl f12)]         'xah-cycle-font)
