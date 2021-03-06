;; -*- mode: emacs-lisp -*-
;; This file is loaded by Spacemacs at startup.
;; It must be stored in your home directory.

(defun dotspacemacs/layers ()
  "Configuration Layers declaration.
You should not put any user code in this function besides modifying the variable
values."
  (setq-default
   ;; Base distribution to use. This is a layer contained in the directory
   ;; `+distribution'. For now available distributions are `spacemacs-base'
   ;; or `spacemacs'. (default 'spacemacs)
   dotspacemacs-distribution 'spacemacs
   ;; Lazy installation of layers (i.e. layers are installed only when a file
   ;; with a supported type is opened). Possible values are `all', `unused'
   ;; and `nil'. `unused' will lazy install only unused layers (i.e. layers
   ;; not listed in variable `dotspacemacs-configuration-layers'), `all' will
   ;; lazy install any layer that support lazy installation even the layers
   ;; listed in `dotspacemacs-configuration-layers'. `nil' disable the lazy
   ;; installation feature and you have to explicitly list a layer in the
   ;; variable `dotspacemacs-configuration-layers' to install it.
   ;; (default 'unused)
   dotspacemacs-enable-lazy-installation 'unused
   ;; If non-nil then Spacemacs will ask for confirmation before installing
   ;; a layer lazily. (default t)
   dotspacemacs-ask-for-lazy-installation t
   ;; If non-nil layers with lazy install support are lazy installed.
   ;; List of additional paths where to look for configuration layers.
   ;; Paths must have a trailing slash (i.e. `~/.mycontribs/')
   dotspacemacs-configuration-layer-path '()
   ;; List of configuration layers to load.
   dotspacemacs-configuration-layers
   '(
     (haskell :variables haskell-completion-backend 'lsp)
     lsp
     yaml
     ;;(chinese :variables chinese-enable-fcitx t)
     latex
     sql
     python
     c-c++
     helm
     auto-completion
     better-defaults
     emacs-lisp
     ;; git
     markdown
     org
     (shell :variables
            shell-default-height 30
            shell-default-position 'bottom)
     )
   ;; List of additional packages that will be installed without being
   ;; wrapped in a layer. If you need some configuration for these
   ;; packages, then consider creating a layer. You can also put the
   ;; configuration in `dotspacemacs/user-config'.
   dotspacemacs-additional-packages '()
   ;; A list of packages that cannot be updated.
   dotspacemacs-frozen-packages '()
   ;; A list of packages that will not be installed and loaded.
   dotspacemacs-excluded-packages '()
   ;; Defines the behaviour of Spacemacs when installing packages.
   ;; Possible values are `used-only', `used-but-keep-unused' and `all'.
   ;; `used-only' installs only explicitly used packages and uninstall any
   ;; unused packages as well as their unused dependencies.
   ;; `used-but-keep-unused' installs only the used packages but won't uninstall
   ;; them if they become unused. `all' installs *all* packages supported by
   ;; Spacemacs and never uninstall them. (default is `used-only')
   dotspacemacs-install-packages 'used-only))

(defun dotspacemacs/init ()
  "Initialization function.
This function is called at the very startup of Spacemacs initialization
before layers configuration.
You should not put any user code in there besides modifying the variable
values."
  ;; This setq-default sexp is an exhaustive list of all the supported
  ;; spacemacs settings.
  (setq-default
   ;; 'spacemacs, 'all-the-icons, 'custom, 'vim-powerline or 'vanilla or a list with `car' one of the previous values and properties one of the following: `:separator' or `:separator-scale'
   dotspacemacs-mode-line-theme 'spacemacs
   ;; If non nil ELPA repositories are contacted via HTTPS whenever it's
   ;; possible. Set it to nil if you have no way to use HTTPS in your
   ;; environment, otherwise it is strongly recommended to let it set to t.
   ;; This variable has no effect if Emacs is launched with the parameter
   ;; `--insecure' which forces the value of this variable to nil.
   ;; (default t)
   dotspacemacs-elpa-https t
   ;; Maximum allowed time in seconds to contact an ELPA repository.
   dotspacemacs-elpa-timeout 5
   ;; If non nil then spacemacs will check for updates at startup
   ;; when the current branch is not `develop'. Note that checking for
   ;; new versions works via git commands, thus it calls GitHub services
   ;; whenever you start Emacs. (default nil)
   dotspacemacs-check-for-update nil
   ;; If non-nil, a form that evaluates to a package directory. For example, to
   ;; use different package directories for different Emacs versions, set this
   ;; to `emacs-version'.
   dotspacemacs-elpa-subdirectory nil
   ;; One of `vim', `emacs' or `hybrid'.
   ;; `hybrid' is like `vim' except that `insert state' is replaced by the
   ;; `hybrid state' with `emacs' key bindings. The value can also be a list
   ;; with `:variables' keyword (similar to layers). Check the editing styles
   ;; section of the documentation for details on available variables.
   ;; (default 'vim)
   dotspacemacs-editing-style 'vim
   ;; If non nil output loading progress in `*Messages*' buffer. (default nil)
   dotspacemacs-verbose-loading nil
   ;; Specify the startup banner. Default value is `official', it displays
   ;; the official spacemacs logo. An integer value is the index of text
   ;; banner, `random' chooses a random text banner in `core/banners'
   ;; directory. A string value must be a path to an image format supported
   ;; by your Emacs build.
   ;; If the value is nil then no banner is displayed. (default 'official)
   dotspacemacs-startup-banner 'official
   ;; List of items to show in startup buffer or an association list of
   ;; the form `(list-type . list-size)`. If nil then it is disabled.
   ;; Possible values for list-type are:
   ;; `recents' `bookmarks' `projects' `agenda' `todos'."
   ;; List sizes may be nil, in which case
   ;; `spacemacs-buffer-startup-lists-length' takes effect.
   dotspacemacs-startup-lists '((recents . 5)
                                (projects . 7))
   ;; True if the home buffer should respond to resize events.
   dotspacemacs-startup-buffer-responsive t
   ;; Default major mode of the scratch buffer (default `text-mode')
   dotspacemacs-scratch-mode 'text-mode
   ;; List of themes, the first of the list is loaded when spacemacs starts.
   ;; Press <SPC> T n to cycle to the next theme in the list (works great
   ;; with 2 themes variants, one dark and one light)
   dotspacemacs-themes '(spacemacs-dark spacemacs-light)
   ;; If non nil the cursor color matches the state color in GUI Emacs.
   dotspacemacs-colorize-cursor-according-to-state t
   ;; Default font, or prioritized list of fonts. `powerline-scale' allows to
   ;; quickly tweak the mode-line size to make separators look not too crappy.
   dotspacemacs-default-font '("Source Code Pro"
                               :size 20
                               :weight normal
                               :width normal
                               :powerline-scale 1.1)
   ;; The leader key
   dotspacemacs-leader-key "SPC"
   ;; The key used for Emacs commands (M-x) (after pressing on the leader key).
   ;; (default "SPC")
   dotspacemacs-emacs-command-key "SPC"
   ;; The key used for Vim Ex commands (default ":")
   dotspacemacs-ex-command-key ":"
   ;; The leader key accessible in `emacs state' and `insert state'
   ;; (default "M-m")
   dotspacemacs-emacs-leader-key "M-m"
   ;; Major mode leader key is a shortcut key which is the equivalent of
   ;; pressing `<leader> m`. Set it to `nil` to disable it. (default ",")
   dotspacemacs-major-mode-leader-key ","
   ;; Major mode leader key accessible in `emacs state' and `insert state'.
   ;; (default "C-M-m")
   dotspacemacs-major-mode-emacs-leader-key "C-M-m"
   ;; These variables control whether separate commands are bound in the GUI to
   ;; the key pairs C-i, TAB and C-m, RET.
   ;; Setting it to a non-nil value, allows for separate commands under <C-i>
   ;; and TAB or <C-m> and RET.
   ;; In the terminal, these pairs are generally indistinguishable, so this only
   ;; works in the GUI. (default nil)
   dotspacemacs-distinguish-gui-tab nil
   ;; If non nil `Y' is remapped to `y$' in Evil states. (default nil)
   dotspacemacs-remap-Y-to-y$ nil
   ;; If non-nil, the shift mappings `<' and `>' retain visual state if used
   ;; there. (default t)
   dotspacemacs-retain-visual-state-on-shift t
   ;; If non-nil, J and K move lines up and down when in visual mode.
   ;; (default nil)
   dotspacemacs-visual-line-move-text nil
   ;; If non nil, inverse the meaning of `g' in `:substitute' Evil ex-command.
   dotspacemacs-max-rollback-slots 5
   ;; If non nil, `helm' will try to minimize the space it uses. (default nil)
   dotspacemacs-helm-resize nil
   ;; if non nil, the helm header is hidden when there is only one source.
   ;; (default nil)
   dotspacemacs-helm-no-header nil
   ;; define the position to display `helm', options are `bottom', `top',
   ;; `left', or `right'. (default 'bottom)
   dotspacemacs-helm-position 'bottom
   ;; Controls fuzzy matching in helm. If set to `always', force fuzzy matching
   ;; in all non-asynchronous sources. If set to `source', preserve individual
   ;; source settings. Else, disable fuzzy matching in all sources.
   ;; (default 'always)
   dotspacemacs-helm-use-fuzzy 'always
   ;; If non nil the paste micro-state is enabled. When enabled pressing `p`
   ;; several times cycle between the kill ring content. (default nil)
   dotspacemacs-enable-paste-transient-state nil
   ;; Which-key delay in seconds. The which-key buffer is the popup listing
   ;; the commands bound to the current keystroke sequence. (default 0.4)
   dotspacemacs-which-key-delay 0.4
   ;; Which-key frame position. Possible values are `right', `bottom' and
   ;; `right-then-bottom'. right-then-bottom tries to display the frame to the
   ;; right; if there is insufficient space it displays it at the bottom.
   ;; (default 'bottom)
   dotspacemacs-which-key-position 'bottom
   ;; If non nil a progress bar is displayed when spacemacs is loading. This
   ;; may increase the boot time on some systems and emacs builds, set it to
   ;; nil to boost the loading time. (default t)
   dotspacemacs-loading-progress-bar t
   ;; If non nil the frame is fullscreen when Emacs starts up. (default nil)
   ;; (Emacs 24.4+ only)
   dotspacemacs-fullscreen-at-startup nil
   ;; If non nil `spacemacs/toggle-fullscreen' will not use native fullscreen.
   ;; Use to disable fullscreen animations in OSX. (default nil)
   dotspacemacs-fullscreen-use-non-native nil
   ;; If non nil the frame is maximized when Emacs starts up.
   ;; Takes effect only if `dotspacemacs-fullscreen-at-startup' is nil.
   ;; (default nil) (Emacs 24.4+ only)
   dotspacemacs-maximized-at-startup nil
   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's active or selected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-active-transparency 90
   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's inactive or deselected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-inactive-transparency 90
   ;; If non nil show the titles of transient states. (default t)
   dotspacemacs-show-transient-state-title t
   ;; If non nil show the color guide hint for transient state keys. (default t)
   dotspacemacs-show-transient-state-color-guide t
   ;; If non nil unicode symbols are displayed in the mode line. (default t)
   dotspacemacs-mode-line-unicode-symbols t
   ;; If non nil smooth scrolling (native-scrolling) is enabled. Smooth
   ;; scrolling overrides the default behavior of Emacs which recenters point
   ;; when it reaches the top or bottom of the screen. (default t)
   dotspacemacs-smooth-scrolling t
   ;; Control line numbers activation.
   ;; If set to `t' or `relative' line numbers are turned on in all `prog-mode' and
   ;; `text-mode' derivatives. If set to `relative', line numbers are relative.
   ;; This variable can also be set to a property list for finer control:
   ;; '(:relative nil
   ;;   :disabled-for-modes dired-mode
   ;;                       doc-view-mode
   ;;                       markdown-mode
   ;;                       org-mode
   ;;                       pdf-view-mode
   ;;                       text-mode
   ;;   :size-limit-kb 1000)
   ;; (default nil)
   dotspacemacs-line-numbers nil
   ;; Code folding method. Possible values are `evil' and `origami'.
   ;; (default 'evil)
   dotspacemacs-folding-method 'evil
   ;; If non-nil smartparens-strict-mode will be enabled in programming modes.
   ;; (default nil)
   dotspacemacs-smartparens-strict-mode nil
   ;; If non-nil pressing the closing parenthesis `)' key in insert mode passes
   ;; over any automatically added closing parenthesis, bracket, quote, etc…
   ;; This can be temporary disabled by pressing `C-q' before `)'. (default nil)
   dotspacemacs-smart-closing-parenthesis nil
   ;; Select a scope to highlight delimiters. Possible values are `any',
   ;; `current', `all' or `nil'. Default is `all' (highlight any scope and
   ;; emphasis the current one). (default 'all)
   dotspacemacs-highlight-delimiters 'all
   ;; If non nil, advise quit functions to keep server open when quitting.
   ;; (default nil)
   dotspacemacs-persistent-server nil
   ;; List of search tool executable names. Spacemacs uses the first installed
   ;; tool of the list. Supported tools are `ag', `pt', `ack' and `grep'.
   ;; (default '("ag" "pt" "ack" "grep"))
   dotspacemacs-search-tools '("ag" "pt" "ack" "grep")
   ;; The default package repository used if no explicit repository has been
   ;; specified with an installed package.
   ;; Not used for now. (default nil)
   dotspacemacs-default-package-repository nil
   ;; Delete whitespace while saving buffer. Possible values are `all'
   ;; to aggressively delete empty line and long sequences of whitespace,
   ;; `trailing' to delete only the whitespace at end of lines, `changed'to
   ;; delete only whitespace for changed lines or `nil' to disable cleanup.
   ;; (default nil)
   dotspacemacs-whitespace-cleanup nil
   ))

(defun dotspacemacs/user-init ()
  (setq-default tab-width 4)
  ;; (setq-default dotspacemacs-themes '(manoj-dark))
  (setq-default dotspacemacs-startup-banner '"~/.dotfiles/emacs/banner.png")
  (setq-default dotspacemacs-configuration-layers
                '((auto-completion :variables
                                   auto-completion-enable-snippets-in-popup t)))
  (setq-default dotspacemacs-configuration-layers
                '(latex :variables latex-enable-folding t))
  (setq-default dotspacemacs-configuration-layers
                '(latex :variables latex-enable-magic t))
  (setq-default dotspacemacs-configuration-layers
                '(latex :variables latex-build-command "latex"))
  )

(defun dotspacemacs/user-config ()
  (setq-default indent-tabs-mode nil)
  (setq-default tab-width 4)
  (setq ycmd-force-semantic-completion t)
  (setq x-select-enable-clipboard nil)
  (setq sp-escape-quotes-after-insert nil)
  (setq shell-file-name "bash")

  ;; c style
  (setq c-default-style "linux")
  (setq c-basic-offset 4)
  (setq default-tab-width 4)

  (add-hook 'c-mode-common-hook (lambda() (c-set-offset 'case-label '+)))
  (add-hook 'before-save-hook (lambda () (whitespace-cleanup)))

  (setq haskell-indentation-starter-offset 4)
  (setq haskell-indentation-left-offset 4)
  (setq haskell-indentation-layout-offset 4)
  (setq haskell-indentation-where-pre-offset 4)
  (setq haskell-indentation-where-post-offset 4)

  ;; set powerline
  (setq powerline-default-separator 'slant)

  ;; expand code snippets
  (global-set-key (kbd "C-<return>") 'yas-expand)

  (setq display-buffer-alist '(("\\`\\*e?shell" display-buffer-same-window)))
  ;; C-c to escape
  (defun my-esc (prompt)
    (cond
     ((or (evil-insert-state-p) (evil-normal-state-p) (evil-replace-state-p) (evil-visual-state-p)) [escape])
     (t (kbd "C-g"))))
  ;; (define-key key-translation-map (kbd "C-c") 'my-esc)
  ;; (define-key evil-operator-state-map (kbd "C-c") 'keyboard-quit)
  ;; (set-quit-char "C-c")

  (setq org-startup-latex-with-latex-preview t)
  (evil-define-key 'normal global-map (kbd "C-l") 'org-toggle-latex-fragment)
  (evil-define-key 'insert global-map (kbd "C-l") 'yas-expand)
  (evil-define-key 'normal global-map (kbd "L") 'evil-end-of-line)
  (evil-define-key 'normal global-map (kbd "H") 'evil-first-non-blank)
  (evil-define-key 'visual global-map (kbd "H") 'evil-first-non-blank)
  (evil-define-key 'visual global-map (kbd "L") 'evil-end-of-line)
  (evil-define-key 'normal global-map (kbd "C-x p") (kbd "\" + p"))
  ;; (evil-set-initial-state 'shell-mode 'emacs)
  ;; force completion
  (evil-define-key 'insert global-map (kbd "C-d") 'completion-at-point)

  (global-set-key (kbd "<f3>") 'neotree-toggle)

  ;; Format code
  (defun F()
    (interactive)
    (let ((format-command "clang-format -i -style=\"{BasedOnStyle: Google, IndentWidth: 4}\""))
      (save-excursion
        (shell-command-to-string (format "%s %s" format-command buffer-file-name))
        (message "format done"))))

  ;; compile
  (defun C()
    (interactive)
    (save-buffer)
    (let ((fn (file-name-nondirectory buffer-file-name))
          (fn-ex (downcase (file-name-extension buffer-file-name)))
          (command nil))
      (cond
       ;; c
       ((or (find fn-ex '("c") :test #'equal)
            (find major-mode '(c-mode)))
        (setq command (format "%s %s" "gcc -Wall -o /tmp/now" fn)))
       ;; c++
       ((or (find fn-ex '("cpp" "cc" "c++") :test #'equal)
            (find major-mode '(c++-mode)))
        (setq command (format "%s %s" "g++ -Wall -o /tmp/now" fn)))
       ;; java
       ((or (find fn-ex '("java") :test #'equal)
            (find major-mode '(java-mode)))
        (setq command (format "%s %s" "javac" fn)))
       ;; asm
       ((or (find fn-ex '("asm" "s") :test #'equal)
            (find major-mode '(asm-mode)))
        (setq command (format "%s %s" "nasm -f bin -o /tmp/now" fn)))
       ;; cs
       ((or (find fn-ex '("cs") :test #'equal)
            (find major-mode '()))
        (setq command (format "%s %s" "mcs" fn)))
       ((or (find fn-ex '("hs") :test #'equal)
            (find major-mode '(haskell-mode)))
        (setq command (format "%s %s" "ghc -o /tmp/now" fn)))
       )
      (if (not (null command))
        (let ((command (read-from-minibuffer "Compile command: " command)))
          (compile command)))
      )
    )
  ;; run
  (defun R()
    (interactive)
    (save-buffer)
    (let ((fn (file-name-nondirectory buffer-file-name))
          (fn-ex (downcase (file-name-extension buffer-file-name)))
          (command nil))
      (cond
       ;; run compiled result
       ((or (find fn-ex '("c" "cpp" "c++" "cc" "asm" "s") :test #'equal)
            (find major-mode '(c-mode c++-mode asm-mode)))
        (setq command "/tmp/now"))
       ;; haskell
       ((or (find fn-ex '("hs") :test #'equal)
            (find major-mode '(haskell-mode)))
        (setq command (format "%s %s" "runhaskell" buffer-file-name))
        )
       ;; python
       ((or (find fn-ex '("py") :test #'equal)
            (find major-mode '(python-mode)))
        (setq command (format "%s %s" "python3" buffer-file-name)))
       ;; shell
       ((or (find fn-ex '("sh") :test #'equal)
            (find major-mode '(shell-script-mode)))
        (setq command (format "%s %s" "bash" buffer-file-name)))
       )
      (if (not (null command))
        (let ((command (read-from-minibuffer "Run command: " command)))
          (compile command t)))
      )
    )

  (set-variable 'ycmd-server-command '("/usr/bin/python3.8" "-u" "/home/angel/.dotfiles/.vim/vimfiles/YouCompleteMe/third_party/ycmd/ycmd"))
  (set-variable 'ycmd-global-config "/home/angel/.config/ycmd/ycmd_conf.py")
  (add-hook 'c++-mode-hook 'ycmd-mode)
  (add-hook 'python-mode-hook 'ycmd-mode)

  ;; latex privew size
  (require 'org)
  (setq org-format-latex-options (plist-put org-format-latex-options :scale 1.8))
  ;; (sp-local-pair 'org-mode "$" "$")
  )

;; Do not write anything past this comment. This is where Emacs will
;; auto-generate custom variable definitions.
(defun dotspacemacs/emacs-custom-settings ()
  "Emacs custom settings.
This is an auto-generated function, do not modify its content directly, use
Emacs customize menu instead.
This function is called at the very end of Spacemacs initialization."
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(lsp-ui lsp-python-ms lsp-pyright lsp-origami origami lsp-latex helm-lsp flycheck-ycmd flycheck-rtags flycheck-pos-tip pos-tip flycheck-haskell dap-mode posframe lsp-treemacs bui ccls yasnippet-snippets yapfify yaml-mode xterm-color ws-butler writeroom-mode visual-fill-column winum vterm volatile-highlights vi-tilde-fringe uuidgen unfill undo-tree treemacs-projectile treemacs-persp treemacs-icons-dired treemacs-evil treemacs pfuture toc-org terminal-here symon symbol-overlay string-inflection sql-indent sphinx-doc spaceline-all-the-icons all-the-icons memoize spaceline powerline shell-pop restart-emacs rainbow-delimiters pytest pyim pyim-basedict xr pyenv-mode py-isort popwin pippel pipenv pyvenv pip-requirements persp-mode password-generator paradox pangu-spacing overseer org-superstar org-rich-yank org-projectile org-category-capture org-present org-pomodoro alert log4e gntp org-mime org-download org-cliplink org-brain open-junk-file nameless mwim multi-term move-text mmm-mode markdown-toc macrostep lsp-haskell lsp-mode markdown-mode spinner ht dash-functional lorem-ipsum live-py-mode link-hint indent-guide importmagic epc ctable concurrent hungry-delete htmlize hlint-refactor hl-todo hindent highlight-parentheses highlight-numbers parent-mode highlight-indentation helm-xref helm-themes helm-swoop helm-rtags helm-pydoc helm-purpose window-purpose imenu-list helm-projectile helm-org-rifle helm-org helm-mode-manager helm-make helm-ls-git helm-hoogle helm-flx helm-descbinds helm-company helm-c-yasnippet helm-ag haskell-snippets google-translate google-c-style golden-ratio gnuplot gh-md fuzzy flycheck-package package-lint flycheck-elsa flx-ido flx find-by-pinyin-dired fancy-battery eyebrowse expand-region evil-visualstar evil-visual-mark-mode evil-unimpaired evil-tutor evil-textobj-line evil-surround evil-org evil-numbers evil-nerd-commenter evil-matchit evil-lisp-state evil-lion evil-indent-plus evil-iedit-state evil-goggles evil-exchange evil-escape evil-ediff evil-cleverparens smartparens evil-args evil-anzu anzu eval-sexp-fu eshell-z eshell-prompt-extras esh-help emr iedit projectile paredit list-utils elisp-slime-nav editorconfig dumb-jump disaster devdocs define-word dante lcr haskell-mode cython-mode cpp-auto-include company-ycmd ycmd request-deferred request deferred company-rtags rtags company-reftex company-cabal company-c-headers company-auctex company-anaconda company column-enforce-mode cmm-mode clean-aindent-mode clang-format chinese-conv centered-cursor-mode blacken auto-yasnippet yasnippet auto-highlight-symbol auto-compile packed auctex-latexmk auctex attrap flycheck pkg-info epl anaconda-mode pythonic f dash s aggressive-indent ace-window ace-pinyin pinyinlib ace-link ace-jump-helm-line helm avy helm-core ac-ispell auto-complete popup which-key use-package pcre2el org-plus-contrib hydra lv hybrid-mode font-lock+ evil goto-chg dotenv-mode diminish bind-map bind-key async)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
)
