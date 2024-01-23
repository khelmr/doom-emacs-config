;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

(after! evil
  (setq evil-vsplit-window-right t
        evil-split-window-below t))

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
(setq doom-font (font-spec :family "JetBrainsMono Nerd Font Mono" :size 16 :weight 'normal)
      doom-variable-pitch-font (font-spec :family "Noto Sans" :size 20 :weight 'normal)
      doom-symbol-font (font-spec :family "JuliaMono" :weight 'normal)
      doom-serif-font (font-spec :family "Noto Serif" :weight 'normal)
      )
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

(setq doom-emoji-font "Twitter Color Emoji")

(after! emojify
  (setq emojify-emoji-set "twemoji-v2"))

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)

(add-hook! visual-line-mode (setq display-line-numbers-type 'visual))

(after! doom-modeline
  (setq doom-modeline-major-mode-icon t
        doom-modeline-height 20)
  )

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'catppuccin)

(use-package! catppuccin-theme
  :init
  (setq catppuccin-flavor 'macchiato) ;; set to macchiato
  )

(use-package! modus-themes
  :config
  ;; Add all your customizations prior to loading the themes
  (setq modus-themes-italic-constructs t
        modus-themes-bold-constructs nil)

  ;; Maybe define some palette overrides, such as by using our presets
  (setq modus-themes-common-palette-overrides
        modus-themes-preset-overrides-intense))

(defadvice! prompt-for-buffer (&rest _)
  :after '(evil-window-split evil-window-vsplit)
  (consult-buffer))

(setq-default fill-column 120)

(use-package! zoom
  :defer t
  :config
  (setq zoom-size '(0.618 . 0.618)))

(use-package! olivetti
  :defer t
  :config
  (setq olivetti-style 'fancy)
  )

(use-package! auto-olivetti
  :defer t
  :hook (doom-first-buffer . auto-olivetti-mode)
  :config
  (add-to-list 'auto-olivetti-enabled-modes 'org-agenda-mode)
  )

;; (add-hook! doom-init-ui-hook #'spacious-padding-mode)
(spacious-padding-mode)
;; (use-package! spacious-padding
;;   :init
;;   (setq spacious-padding-widths
;;       '(
;;         :internal-border-width 15
;;         :header-line-width 4
;;         :mode-line-width 6
;;         ;; :tab-width 4
;;         :right-divider-width 30
;;         :scroll-bar-width 8
;;          ))
;;   )

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/Documents/Org/")

(after! org
  (setq org-highlight-latex-and-related '(native latex script entities)
        org-ellipsis "…"
        )
  )

(add-hook! (org-mode) #'mixed-pitch-mode)

(use-package! org-modern
  :config
  (setq org-modern-hide-stars nil
        org-modern-star '("◉" "○" "✸" "✿" "◈" "◇" )
        org-modern-todo-faces '(("[-]" :inherit +org-todo-active)
                                ("STRT" :inherit +org-todo-active)
                                ("[?]" :inherit +org-todo-onhold)
                                ("WAIT" :inherit +org-todo-onhold)
                                ("HOLD" :inherit +org-todo-onhold)
                                ("PROJ" :inherit +org-todo-project)
                                ("NO" :inherit +org-todo-cancel)
                                ("KILL" :inherit +org-todo-cancel))
        )
                )
(after! org
  (global-org-modern-mode))

(use-package! org-appear
  :hook (org-mode . org-appear-mode)
  )

(use-package! org-fragtog
  :hook (org-mode . org-fragtog-mode)
  )

(use-package! org-agenda
  :after org
  :config
  ;; appearance
  (setq org-agenda-span 3
        org-agenda-start-day "+0d"
        org-agenda-skip-timestamp-if-done t
        org-agenda-skip-deadline-if-done t
        org-agenda-skip-scheduled-if-done t
        org-agenda-skip-timestamp-if-deadline-is-shown t
        org-agenda-skip-deadline-prewarning-if-scheduled t
        org-agenda-current-time-string ""
        org-agenda-time-grid '((daily) () "" "")
        org-agenda-hide-tags-regexp ".*"
        org-agenda-block-separator nil
        )
  ;; add agenda views here
  )

(use-package! org-super-agenda
  :after org-agenda
  )

(add-hook! org-agenda-finalize-entries #'org-super-agenda-mode)

(use-package! org-timeblock
  :defer t)

(use-package! org-ql
  :defer t
  :commands org-ql-find)

(use-package! doct
  :commands doct)

(after! org-roam
  (setq org-roam-directory (concat org-directory "Notes/")))

(after! org-contacts
  (setq org-contacts-files (concat org-directory "contacts.org")))

(after! tree-sitter
  (setq treesit-font-lock-level 4))

(use-package! xenops
  :hook (latex-mode . xenops-mode))
