;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Jacob Shodd"
      user-mail-address "me@jacobshodd.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-nord)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)


;; Here are some additional functions/macros that could help you configure Doom:
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
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; Custom Configurations Starting here:


;; Configuring Multiple Cursors:
(map! "C-+" #'mc/mark-all-like-this)
(map! :map helm-map "TAB" #'helm-execute-persistent-action)
(map! :map helm-map "<tab>" #'helm-execute-persistent-action)
(map! :map helm-map "C-z" #'helm-select-action)

;; Orgmode configuration
;;;; Adding some easier key bindings
(map! :leader
      :desc "Org Capture"
      "g" #'org-capture)

;;;; Setting up agenda files
(after! org (setq org-agenda-files '("~/org/gtd/inbox.org"
                         "~/org/gtd/gtd.org")))

;;;; Adding org journal helper function
(defun org-journal-find-location ()
  ;; Open today's journal, but specify a non-nil prefix argument in order to
  ;; inhibit inserting the heading; org-capture will insert the heading.
  (org-journal-new-entry t)
  (org-narrow-to-subtree)
  (goto-char (point-max)))

;;;; Configuring org capture
(after! org (setq org-capture-templates '(
                                          ("t" "General todo [inbox]" entry
                                           (file+headline "~/org/gtd/inbox.org" "Tasks")
                                           "* TODO %i%?")
                                          ("j" "Journal entry" plain (function org-journal-find-location)
                                           "** %(format-time-string org-journal-time-format)%^{Title}\n%i%?")
                                          )))

;;;; Configure refile targets
(after! org (setq org-refile-targets '(("~/org/gtd/gtd.org" :maxlevel . 3)
                           ("~/org/gtd/someday.org" :level . 1))))

;;;; Configuring TODO keywords
(after! org (setq org-todo-keywords '((sequence "TODO(t)" "WAITING(w)" "|" "DONE(d)" "CANCELLED(c)"))))

;;;; Log timestamp when a task is completed
(after! org (setq org-log-done 'time))

;;;; Create custom agenda command for sprint review
(after! org (setq org-agenda-custom-commands
             '(("s" "Sprint Review"
                agenda ""
               ((org-agenda-start-day "-14d")
                (org-agenda-span 15)
                (org-agenda-archives-mode t)
                (org-agenda-start-with-log-mode '(closed)))))))
