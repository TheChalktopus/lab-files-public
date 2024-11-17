;; Set the package installation directory so that packages aren't stored in the
;; ~/.emacs.d/elpa path.
(require 'package)
(setq package-user-dir (expand-file-name "~/Sites/lab-files-site/.packages"))
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))

;; Initialize the package system
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

;; Install dependencies
(package-install 'htmlize)

;; Load the publishing system
(require 'ox-publish)

;; Customize the HTML output
(setq org-html-validation-link nil            ;; Don't show validation link
      org-html-head-include-scripts nil       ;; Use our own scripts
      org-html-head-include-default-style nil ;; Use our own styles
      org-html-head "<link rel=\"stylesheet\" href=\"https://cdn.simplecss.org/simple.min.css\" />")

;; Define the publishing project
(setq org-publish-project-alist
      (list
       (list "org-site:main"
             :recursive t
             :base-directory "~/Sites/lab-files-site/content"
             :publishing-function 'org-html-publish-to-html
             :publishing-directory "~/Sites/lab-files-site/docs"
             :with-author nil           ;; Don't include author name
             :with-creator t            ;; Include Emacs and Org versions in footer
             :with-toc t                ;; Include a table of contents
             :section-numbers nil       ;; Don't include section numbers
             :time-stamp-file nil       ;; Don't include time stamp in file
	     :auto-sitemap t
	     :sitemap-filename "index.org"
	     :sitemap-title   "Index")           
       ))   
;; Generate todo list
(require 'org-agenda)
(org-store-agenda-views)
(setq org-agenda-files '("~/lab-files/"))
(setq org-todo-keywords
      '((sequence "TODO(t)" "INPROG(i)" "NEXT(n)" "|" "DONE(d)" "CANCELLED(x)" )
	(sequence  "CONSUME(c)" "|")
	(sequence "|" "PARTIAL(p)" "FAIL(f)" "|" "SUCCESS(s)")
	)
      )
(setq org-todo-keyword-faces
      '( ("NEXT" . (:foreground "yellow" :weight bold))
			("INPROG" . (:foreground "magenta" :weight bold))
			("CANCELLED" . (:foreground "blue" :weight bold))
			("CONSUME" . "orange")
			("PARTIAL" . (:foreground "yellow" :weight bold))
			("FAIL" . (:foreground "red" :weight bold)))
		)
;;   TODO  DONE for tasks; CONSUME for music, books, movies, etc.
;; PARTIAL FAIL SUCCESS for habits/goals a la CGP grey need to do this


(setq org-priority-default 69)
(setq org-priority-lowest 70)
(setq org-priority-highest 65)
(setq org-agenda-window-setup '(current-window))
(setq org-deadline-warning-days 3)
(setq org-agenda-time-grid '((daily)
 (0 400 600 800 1000 1200 1400 1600 1800 2000 2200 2359)
 " ┄┄┄┄┄ " "┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄"))
(setq org-agenda-current-time-string  "← now ───────────────────────────────────────────────")

(setq org-agenda-sorting-strategy
      '(
	(agenda habit-down time-up priority-up category-keep)
	(todo priority-down category-keep tag-up)
	(tags priority-down category-keep)
	(tags-todo priority-down category-keep)
	(search priority-up category-keep)
	)
      )

(setq org-agenda-custom-commands
	'(
	  ("d" "Lab Tasks"
         (
          (tags-todo "lab"  ((org-agenda-sorting-strategy '(priority-down)))))
         nil
         ("~/Sites/lab-files-site/content/todo.org"))
	 	 ) )
;; Generate the site output
(org-publish-all t)




(message "Build complete!")
