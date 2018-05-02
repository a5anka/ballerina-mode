(defvar ballerina-mode-hook nil)

(defvar ballerina-mode-map
  (let ((map (make-keymap)))
    (define-key map "\C-j" 'newline-and-indent)
    map)
  "Keymap for Ballerina major mode")

(add-to-list 'auto-mode-alist '("\\.bal\\'" . ballerina-mode))

;;(regexp-opt '("new" "import" "service" "resource" "function" "string" "endpoint" "match"))

(defconst ballerina-font-lock-keywords-1
  (list
   `(,(concat "\\<\\(?:endpoint\\|function\\|import\\|match\\|new\\|"
	     "resource\\|s\\(?:ervice\\|tring\\)\\)\\>") . font-lock-keyword-face))
  "Minimal highlighting expressions for Ballerina mode")

(defvar ballerina-font-lock-keywords ballerina-font-lock-keywords-1
  "Default highlighting expressions for Ballerina mode")

(defun ballerina-indent-line ()
  "Indent current line as ballerina code"
  (interactive)
  (beginning-of-line)
  (if (bobp)
      (progn
	(indent-line-to 0))
    (let ((not-indented t) (cur-inc-indent 0) (cur-dec-indent 0))
      (save-excursion
	(while (re-search-backward "{" nil t 1)
	  (setq cur-inc-indent (+ cur-inc-indent tab-width))))
      (save-excursion
	(while (re-search-backward "}" nil t 1)
	  (setq cur-dec-indent (+ cur-dec-indent tab-width))))
      (if (looking-at "^[ \t]*}")
	  (indent-line-to (- cur-inc-indent cur-dec-indent tab-width))
	  (indent-line-to (- cur-inc-indent cur-dec-indent))))))
  
(defun ballerina-mode ()
  "Major mode for editing Ballerina Language files"
  (interactive)
  (kill-all-local-variables)
  ;;(set-syntax-table wpdl-mode-syntax-table)
  (use-local-map ballerina-mode-map)
  (set (make-local-variable 'font-lock-defaults) '(ballerina-font-lock-keywords))
  (set (make-local-variable 'indent-line-function) 'ballerina-indent-line)
  (set (make-local-variable 'tab-width) 3)
  (set (make-local-variable 'indent-tabs-mode) nil)
  (setq major-mode 'ballerina-mode)
  (setq mode-name "Ballerina")
  (run-hooks 'ballerina-mode-hook))

(provide 'ballerina-mode)

