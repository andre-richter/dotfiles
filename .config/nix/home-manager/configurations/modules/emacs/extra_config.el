;; Load color Theme
(load-theme 'lush t)

;; Font size
(set-face-attribute 'default nil :height 140)

(setq-default fill-column 100)
(setq-default show-trailing-whitespace t)

;; No startup message
(setq inhibit-startup-message t)

;; No menubar
(menu-bar-mode -1)

;; Show line numbers...
(global-linum-mode 1)

;; Add a single space between line number and buffer
(setq linum-format "%d ")

;; Shows column numbers
(column-number-mode 1)

;; Shows matching parenthesis
(show-paren-mode 1)

;; Scroll line by line when reaching window edges with arrow keys
(setq scroll-step 1 scroll-conservatively 10000)

;; Multiple cursors settings
(require 'multiple-cursors)
(global-set-key (kbd "C-t") 'mc/mark-next-like-this)

;; Auto close parens
(electric-pair-mode 1)

;; Show file full path in title bar
(setq-default frame-title-format
(list '((buffer-file-name " %f"
  (dired-directory
    dired-directory
    (revert-buffer-function " %b"
      ("%b - Dir:  " default-directory)))))))

;; Delete trailing whitespace on save
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; Don't save backup files in working directory
(setq backup-directory-alist '(("." . "~/.emacs-backups"))
      backup-by-copying t    ; Don't delink hardlinks
      version-control t      ; Use version numbers on backups
      delete-old-versions t  ; Automatically delete excess backups
      kept-new-versions 20   ; how many of the newest versions to keep
      kept-old-versions 5    ; and how many of the old
      )

;; In emacs nw mode, CTRL+Backspace produces C-h. Also, make it delete, not kill, the last word.
(defun my-delete-word (arg)
  (interactive "p")
  (delete-region
   (point)
   (progn
     (forward-word arg)
     (point))))
(defun backward-delete-word (arg)
  (interactive "p")
  (my-delete-word (- arg)))
(global-set-key (kbd "C-h") 'backward-delete-word)
