;; .emacs

;;;;;;;;;;;;;;;;;;;;;
;; Package manager ;;
;;;;;;;;;;;;;;;;;;;;;

(require 'package)
(dolist (source '(("melpa" . "http://melpa.milkbox.net/packages/")))
  (add-to-list 'package-archives source t))
(package-initialize)

;; Agda
(load-file (let ((coding-system-for-read 'utf-8))
		(shell-command-to-string "agda-mode locate")))

;; Require list
(require 'agda-input)
(require 'fill-column-indicator)
(require 'tex)
(require 'multiple-cursors)


;;;;;;;;;;;;;;;
;; Variables ;;
;;;;;;;;;;;;;;;

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(agda2-highlight-face-groups (quote default-faces))
 '(agda2-program-args
   (quote
    ("--include-path=." "--include-path=/home/elilob/.cabal/lib/agda-stdlib-0.13/src")))
 '(before-save-hook (quote (whitespace-cleanup)))
 '(column-number-mode t)
 '(fci-rule-column 80)
 '(fci-rule-use-dashes t)
 '(global-linum-mode t)
 '(haskell-process-auto-import-loaded-modules t)
 '(haskell-process-log t)
 '(haskell-process-suggest-remove-import-lines t)
 '(inhibit-startup-screen t)
 '(keyboard-coding-system (quote utf-8-unix))
 '(menu-bar-mode nil)
 '(package-selected-packages
   (quote
    (magit company-ghc ac-haskell-process haskell-mode zenburn-theme markdown-mode multiple-cursors idris-mode fill-column-indicator auctex)))
 '(scroll-bar-mode nil)
 '(show-paren-mode t)
 '(tool-bar-mode nil)
 '(magit-diff-refine-hunk t)
 '(backup-by-copying t)
 '(backup-directory-alist (quote (("" . "~/.save/"))))
 '(tramp-auto-save-directory "~/.save/"))


;; backups
(setq delete-old-versions t
      kept-new-versions 6
      kept-old-versions 2
      version-control t)

;;;;;;;;;;;;;;;;;;
;; Key bindings ;;
;;;;;;;;;;;;;;;;;;

;; Add key combinations for interactive haskell-mode
(eval-after-load 'haskell-mode '(progn
				  (define-key haskell-mode-map (kbd "C-c C-l")
				    'haskell-process-load-or-reload)))

;; Keyboard shortcuts
(global-set-key (kbd "C-M-S-g" ) 'magit-status)
(global-set-key (kbd "C-x C-b") 'ibuffer)
(global-set-key (kbd "C-x <up>") 'windmove-up)
(global-set-key (kbd "C-x <down>") 'windmove-down)
(global-set-key (kbd "C-x <right>") 'windmove-right)
(global-set-key (kbd "C-x <left>") 'windmove-left)
(global-set-key (kbd "C-z") 'undo)

;; Multiple cursors
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)


;;;;;;;;;;;
;; Theme ;;
;;;;;;;;;;;

;; Colors
(defvar zenburn-override-colors-alist
  '(("zenburn-fg+1"     . "#FFFFEF")
    ("zenburn-fg"       . "#DCDCCC")
    ("zenburn-fg-1"     . "#70705E")
    ("zenburn-bg-2"     . "#000000")
    ("zenburn-bg-1"     . "#202020")
    ("zenburn-bg-05"    . "#2D2D2D")
    ("zenburn-bg"       . "#313131")
    ("zenburn-bg+05"    . "#383838")
    ("zenburn-bg+1"     . "#3E3E3E")
    ("zenburn-bg+2"     . "#4E4E4E")
    ("zenburn-bg+3"     . "#5E5E5E")
    ("zenburn-red+1"    . "#E9B0B0")
    ("zenburn-red"      . "#D9A0A0")
    ("zenburn-red-1"    . "#C99090")
    ("zenburn-red-2"    . "#B98080")
    ("zenburn-red-3"    . "#A97070")
    ("zenburn-red-4"    . "#996060")
    ("zenburn-orange"   . "#ECBC9C")
    ("zenburn-yellow"   . "#FDECBC")
    ("zenburn-yellow-1" . "#EDDCAC")
    ("zenburn-yellow-2" . "#DDCC9C")
    ("zenburn-green-1"  . "#6C8C6C")
    ("zenburn-green"    . "#8CAC8C")
    ("zenburn-green+1"  . "#9CBF9C")
    ("zenburn-green+2"  . "#ACD2AC")
    ("zenburn-green+3"  . "#BCE5BC")
    ("zenburn-green+4"  . "#CCF8CC")
    ("zenburn-cyan"     . "#A0EDF0")
    ("zenburn-blue+1"   . "#9CC7FB")
    ("zenburn-blue"     . "#99DDE0")
    ("zenburn-blue-1"   . "#89C5C8")
    ("zenburn-blue-2"   . "#79ADB0")
    ("zenburn-blue-3"   . "#699598")
    ("zenburn-blue-4"   . "#597D80")
    ("zenburn-blue-5"   . "#436D6D")
    ("zenburn-magenta"  . "#E090C7")))
(load-theme 'zenburn t)

;; Font size (12pt)
(set-face-attribute 'default nil :height 120)

;; fci color bar
(setq fci-rule-color "#996060")

;; UTF-8 as default encoding
(set-language-environment "UTF-8")

;;;;;;;;;;;;;;;
;;  company  ;;
;;;;;;;;;;;;;;;
(if (require 'company nil 'noError)
    (add-to-list 'company-backends 'company-ghc)
  (message "[ERROR] company not loaded correctly"))

;;;;;;;;;;;
;; Hooks ;;
;;;;;;;;;;;

;; general-hook
(defun general-hook ()
   (fci-mode)
   (flyspell-mode)
   (set-input-method "Agda"))

;; markdown-hook
(add-hook 'markdown-mode-hook
	  (lambda ()
	    (general-hook)))

;; latex-hook
(add-hook 'LaTeX-mode-hook
	  (lambda ()
	    (general-hook)
	    (tex-pdf-mode)))

;; Compile documents to PDF by default
(TeX-global-PDF-mode t)

;; haskell-hook
(add-hook 'haskell-mode-hook
	  (lambda ()
	    (general-hook)
	    (interactive-haskell-mode)
	    (company-mode)
	    (haskell-indent-mode)
	    (flyspell-prog-mode)))

;; stack's repl
;; (setq haskell-process-type 'stack-ghci)

;; agda-hook
(add-hook 'agda-mode-hook
	  (lambda ()
	    (general-hook)))

;; idris-hook
(add-hook 'idris-mode-hook
	  (lambda ()
	    (flyspell-mode)
	    (set-input-method "Agda")))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;;;;;;;;;;;;;;;
;; Utilities ;;
;;;;;;;;;;;;;;;

;;Auto reload buffer
(defun auto-revert-buffer ()
    "Revert buffer."
    (interactive)
    (revert-buffer))
