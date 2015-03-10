;;(setq warning-minimum-level :emergency)
(let ((default-directory "~/.emacs.d/"))
  (normal-top-level-add-subdirs-to-load-path))

(require 'package)
(dolist (source '(("marmalade" . "http://marmalade-repo.org/packages/")
                  ("elpa" . "http://tromey.com/elpa/")
                  ("gnu" . "http://elpa.gnu.org/packages/")
                  ("org" . "http://orgmode.org/elpa/")
                  ("melpa" . "http://melpa.milkbox.net/packages/")))
	(add-to-list 'package-archives source t))
(package-initialize)

(when (not package-archive-contents)
      (package-refresh-contents))

(defvar my-packages
  '(auto-complete ecb evil evil-leader evil-nerd-commenter evil-surround
		  evil-visualstar fic-mode go-autocomplete go-eldoc go-mode
		  go-projectile golint helm helm-projectile monokai-theme
		  smart-tab undo-tree scheme-complete cider ac-cider
		  haskell-mode company-ghc company company-go rust-mode) 
  "A list of packages to ensure are installed at launch.")

(dolist (p my-packages)
	(when (not (package-installed-p p))
	      (package-install p)))

;; Font family
(set-default-font "DejaVu Sans Mono Bold")
;; Font size 
(set-face-attribute 'default nil :height 95)

;;Theme
(load-theme 'monokai t)

;; Line numbers
(require 'linum)
(global-linum-mode t)

;; Highlight TODO
(require 'fic-mode)
(add-hook 'prog-mode-hook 'turn-on-fic-mode)

;; Tab
(setq indent-tabs-mode nil)
(setq tab-width 4)
;; C mode indentation
(require 'cc-mode)
(c-add-style "my-c-style"
	     '("k&r"
	       (c-basic-offset . 4)
	       (indent-tabs-mode . nil)
	       (c-tab-always-indent . t)
	       (c-offsets-alist . ((substatement-open . 0)))))
(defun my-c-mode-hook ()
  (c-set-style "my-c-style"))
(add-hook 'c-mode-common-hook 'my-c-mode-hook)

;; Code completion 
(require 'company)
(add-hook 'after-init-hook 'global-company-mode)
(eval-after-load 'company
  '(progn
     (define-key company-active-map (kbd "TAB") 'company-select-next)
     (define-key company-active-map [tab] 'company-select-next)))

;; Go support
(require 'company-go)
(defun my-go-mode-hook () 
  (add-hook 'before-save-hook 'gofmt-before-save t) 
  (setq-default tab-width 4)
  (setq-default indent-tabs-mode t)) 
(add-hook 'go-mode-hook 'my-go-mode-hook t)

;; Helm
(require 'helm-config)
(require 'helm-grep)

;; The default "C-x c" is quite close to "C-x C-c", which quits Emacs.
;; Changed to "C-c h". Note: We must set "C-c h" globally, because we
;; cannot change `helm-command-prefix-key' once `helm-config' is loaded.
(global-set-key (kbd "C-c h") 'helm-command-prefix)
(global-unset-key (kbd "C-x c"))

(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action)  
(define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) 
(define-key helm-map (kbd "C-z")  'helm-select-action)

(when (executable-find "curl")
      (setq helm-google-suggest-use-curl-p t))

(setq helm-quick-update                     t 
      helm-split-window-in-side-p           t
      helm-buffers-fuzzy-matching           t
      helm-move-to-line-cycle-in-source     t
      helm-ff-search-library-in-sexp        t
      helm-scroll-amount                    8
      helm-ff-file-name-history-use-recentf t)

(helm-mode 1)

(require 'helm-projectile)
(helm-projectile-on)
(projectile-global-mode)

;; ecb
(require 'ecb)
(require 'ecb-autoloads)
(setq ecb-examples-bufferinfo-buffer-name nil)
(setq ecb-layout-name "left5")
(custom-set-variables
 '(ecb-options-version "2.40"))
(custom-set-faces)

;; auto pair
(electric-pair-mode 1)

;; Show Paren mode
(show-paren-mode 1)

;; browse-url mode configuration
(setq browse-url-browser-function 'browse-url-generic
      browse-url-generic-program "google-chrome")

;; MIT-scheme config

(setq scheme-program-name
      (concat
       "/usr/bin/mit-scheme "
       "--library " "/usr/lib/x86_64-linux-gnu/mit-scheme "
       "-heap 100000"))

;; generic scheme completeion
(require 'scheme-complete)
(autoload 'scheme-smart-complete "scheme-complete" nil t)
(autoload 'scheme-get-current-symbol-info "scheme-complete" nil t)
(setq lisp-indent-function 'scheme-smart-indent-function)

;; mit-scheme documentation
(require 'mit-scheme-doc)

;; Special keys in scheme mode. Use <tab> to indent scheme code to the
;; proper level, and use M-. to view mit-scheme-documentation for any
;; symbol. 
(eval-after-load  
 'scheme
 '(define-key scheme-mode-map "\t" 'scheme-complete-or-indent))

(eval-after-load  
 'cmuscheme
 '(define-key inferior-scheme-mode-map "\t" 'scheme-complete-or-indent))

;; Haskell
(setenv "PATH" (concat (getenv "PATH") ":~/.cabal/bin"))
    (setq exec-path (append exec-path '("~/.cabal/bin")))
(autoload 'ghc-init "ghc" nil t)
(autoload 'ghc-debug "ghc" nil t)
(add-hook 'haskell-mode-hook (lambda () (ghc-init)))
(add-to-list 'company-backends 'company-ghc)
(add-hook 'haskell-mode-hook 'turn-on-haskell-simple-indent)

;; Rust
(setq racer-rust-src-path "/usr/local/src/rust/src")
(setq racer-cmd "~/rust/racer/target/release/racer")
(add-to-list 'load-path "~/rust/racer/editors")
(eval-after-load "rust-mode" '(require 'racer))

;; Evil mode
(require 'evil)
(evil-mode nil)

(require 'evil-leader)
(global-evil-leader-mode)
(evil-leader/set-leader "<SPC>")

(require 'evil-surround)
(global-evil-surround-mode 1)

;; ;; Evil mappings

;; Esc key for quitting
(defun minibuffer-keyboard-quit ()
  ;;   "Abort recursive edit.
  ;; In Delete Selection mode, if the mark is active, just deactivate it;
  ;; then it takes a second \\[keyboard-quit] to abort the minibuffer."
  (interactive)
  (if (and delete-selection-mode transient-mark-mode mark-active)
      (setq deactivate-mark  t)
      (when (get-buffer "*Completions*") (delete-windows-on "*Completions*"))
      (abort-recursive-edit)))
;; (define-key evil-normal-state-map [escape] 'keyboard-quit)
;; (define-key evil-visual-state-map [escape] 'keyboard-quit)
;; (define-key minibuffer-local-map [escape] 'minibuffer-keyboard-quit)
;; (define-key minibuffer-local-ns-map [escape] 'minibuffer-keyboard-quit)
;; (define-key minibuffer-local-completion-map [escape] 'minibuffer-keyboard-quit)
;; (define-key minibuffer-local-must-match-map [escape] 'minibuffer-keyboard-quit)
;; (define-key minibuffer-local-isearch-map [escape] 'minibuffer-keyboard-quit)

;; Redifine M-x
(define-key evil-normal-state-map (kbd ";") 'execute-extended-command)

;; ibuffer
(evil-leader/set-key "f" 'buffer-menu)

;; Projectile
(evil-leader/set-key "p" 'helm-projectile-find-file)

;; Org Mode
(require 'org)
(evil-leader/set-key "oa" 'org-agenda)
(evil-leader/set-key "os" 'org-store-link)

;; Nerd commenter
(global-set-key (kbd "M-;") 'evilnc-comment-or-uncomment-lines)
(global-set-key (kbd "C-c l") 'evilnc-quick-comment-or-uncomment-to-the-line)
(global-set-key (kbd "C-c c") 'evilnc-copy-and-comment-lines)
(global-set-key (kbd "C-c p") 'evilnc-comment-or-uncomment-paragraphs)
(global-evil-leader-mode)
(evil-leader/set-key
 "ci" 'evilnc-comment-or-uncomment-lines
 "cl" 'evilnc-quick-comment-or-uncomment-to-the-line
 "ll" 'evilnc-quick-comment-or-uncomment-to-the-line
 "cc" 'evilnc-copy-and-comment-lines
 "cp" 'evilnc-comment-or-uncomment-paragraphs
 "cr" 'comment-or-uncomment-region
 "cv" 'evilnc-toggle-invert-comment-line-by-line
 "\\" 'evilnc-comment-operator)

;; Scheme evil mappings
(evil-leader/set-key
 "sd" 'mit-scheme-doc-lookup)

;; (eval-after-load  
;;  'scheme
;;  '(define-key scheme-mode-map (kbd "M-.") 'mit-scheme-doc-lookup))

;; (eval-after-load  
;;  'cmuscheme
;;  '(define-key inferior-scheme-mode-map (kbd "M-.")
;;     'mit-scheme-doc-lookup))
