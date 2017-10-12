;;
;; ██████╗   █████╗  ███████╗ ██╗  ██████╗
;; ██╔══██╗ ██╔══██╗ ██╔════╝ ██║ ██╔════╝
;; ██████╔╝ ███████║ ███████╗ ██║ ██║
;; ██╔══██╗ ██╔══██║ ╚════██║ ██║ ██║
;; ██████╔╝ ██║  ██║ ███████║ ██║ ╚██████╗
;; ╚═════╝  ╚═╝  ╚═╝ ╚══════╝ ╚═╝  ╚═════╝
;;

(setq user-full-name "Joy Lobo")
(setq user-mail-address "joylobo0528@gmail.com")

;; Ask "y" or "n" instead of "yes" or "no". Yes, laziness is great.
(fset 'yes-or-no-p 'y-or-n-p)

;; Highlight corresponding parentheses when cursor is on one.
(show-paren-mode t)

;; Highlight tabulations.
(setq-default highlight-tabs t)

;; Show trailing white spaces.
(setq-default show-trailing-whitespace t)

;; Save backup files in a dedicated directory.
(setq backup-directory-alist '(("." . "~/.emacs-saves")))

;; Remove useless whitespace before saving a file.
(add-hook 'before-save-hook 'whitespace-cleanup)
(add-hook 'before-save-hook (lambda() (delete-trailing-whitespace)))

;; Set locale to UTF8.
(set-language-environment 'utf-8)
(set-terminal-coding-system 'utf-8)
(setq locale-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

(require 'package)
;; melpa.
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
					(not (gnutls-available-p))))
	   (url (concat (if no-ssl "http" "https") "://melpa.org/packages/")))
  (add-to-list 'package-archives (cons "melpa" url) t))

(when (< emacs-major-version 24)
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))

(package-initialize)
(add-to-list 'package-archives
			 '("melpa-stable" . "https://stable.melpa.org/packages/") t)

(defun require-package (package &optional min-version no-refresh)
  "Install given PACKAGE, optionally requiring MIN-VERSION.
If NO-REFRESH is non-nil, the available package lists will not be
re-downloaded in order to locate PACKAGE."
  (if (package-installed-p package min-version)
	  t
	(if (or (assoc package package-archive-contents) no-refresh)
		(if (boundp 'package-selected-packages)
			;; Record this as a package the user installed explicitly.
			(package-install package nil)
		  (package-install package))
	  (progn
		(package-refresh-contents)
		(require-package package min-version t)))))

;; exec path from shell.
(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))

;;
;; ██╗   ██╗ ██╗
;; ██║   ██║ ██║
;; ██║   ██║ ██║
;; ██║   ██║ ██║
;; ╚██████╔╝ ██║
;;  ╚═════╝  ╚═╝
;;

;; window.
(set-frame-parameter nil 'fullscreen 'fullboth)
(if (functionp 'tool-bar-mode) (tool-bar-mode 0))
(if (functionp 'scroll-bar-mode) (scroll-bar-mode 0))
(menu-bar-mode -1)
(global-linum-mode)
(setq tab-width 4)

;;disable splash screen and startup message.
(setq inhibit-startup-message t)
(setq initial-scratch-message nil)

;; nyan mode.
(require 'nyan-mode)
(nyan-mode)

;; dracula theme.
(require 'dracula-theme)
(load-theme 'dracula t)

;; neotree.
(require 'neotree)
(require 'all-the-icons)
(setq neo-theme (if (display-graphic-p) 'icons 'arrow))

;;
;;  ██████╗   ██████╗  ██╗       █████╗  ███╗   ██╗  ██████╗
;; ██╔════╝  ██╔═══██╗ ██║      ██╔══██╗ ████╗  ██║ ██╔════╝
;; ██║  ███╗ ██║   ██║ ██║      ███████║ ██╔██╗ ██║ ██║  ███╗
;; ██║   ██║ ██║   ██║ ██║      ██╔══██║ ██║╚██╗██║ ██║   ██║
;; ╚██████╔╝ ╚██████╔╝ ███████╗ ██║  ██║ ██║ ╚████║ ╚██████╔╝
;;  ╚═════╝   ╚═════╝  ╚══════╝ ╚═╝  ╚═╝ ╚═╝  ╚═══╝  ╚═════╝
;;
(require 'go-mode)
(require 'go-autocomplete)
(require 'auto-complete-config)
(ac-config-default)

;;
;;  ██████╗ ██╗   ██╗ ███████╗ ████████╗  ██████╗  ███╗   ███╗
;; ██╔════╝ ██║   ██║ ██╔════╝ ╚══██╔══╝ ██╔═══██╗ ████╗ ████║
;; ██║      ██║   ██║ ███████╗    ██║    ██║   ██║ ██╔████╔██║
;; ██║      ██║   ██║ ╚════██║    ██║    ██║   ██║ ██║╚██╔╝██║
;; ╚██████╗ ╚██████╔╝ ███████║    ██║    ╚██████╔╝ ██║ ╚═╝ ██║
;;  ╚═════╝  ╚═════╝  ╚══════╝    ╚═╝     ╚═════╝  ╚═╝     ╚═╝
;;
(defun open-init-file()
  (interactive)
  (find-file "~/.emacs.d/init.el"))

(defun goto-go-dir()
  (interactive)
  (find-file "~/src/goprojects/src"))

(defun goto-post-dir()
  (interactive)
  (find-file "/Users/joylobo/Google Drive/Documents/posts"))

(defun goto-private-dir()
  (interactive)
  (find-file "/Users/joylobo/Google Drive/Documents/private"))

(defun kill-other-buffers ()
  "Kill all other buffers."
  (interactive)
  (mapc 'kill-buffer (delq (current-buffer) (buffer-list)))
  (neotree))
(global-set-key (kbd "s-K") 'kill-other-buffers)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (go-dlv all-the-icons nyan-mode neotree go-mode go-autocomplete exec-path-from-shell dracula-theme)))
 '(send-mail-function (quote sendmail-send-it)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
