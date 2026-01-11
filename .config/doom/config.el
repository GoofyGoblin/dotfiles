;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(setq doom-font (font-spec :family "JetBrainsMonoNL Nerd Font" :size 27)
      doom-variable-pitch-font (font-spec :family "JetBrainsMonoNL Nerd Font" :size 27)
      doom-symbol-font (font-spec :family "JetBrainsMonoNL Nerd Font" :size 27))
(setq evil-insert-state-cursor '(box "darkcyan"))
(setq evil-normal-state-cursor '(box "gray"))
(setq doom-theme 'doom-one)
(setq display-line-numbers-type t)
(setq display-line-numbers-type 'relative)
(setq org-directory "~/org/")
(defun my-weebery-is-always-greater ()
  (let* ((banner '(""))
         (longest-line (apply #'max (mapcar #'length banner))))
    (put-text-property
     (point)
     (dolist (line banner (point))
       (insert (+doom-dashboard--center
                +doom-dashboard--width
                (concat line (make-string (max 0 (- longest-line (length line))) 32)))
               "\n"))
     'face 'doom-dashboard-banner)))
(add-hook 'server-after-make-frame-hook
          (lambda ()
            (force-mode-line-update)))
(setq +doom-dashboard-ascii-banner-fn #'my-weebery-is-always-greater)
(after! evil
  (defun +evil-scroll-down-and-center ()
    (interactive)
    (evil-scroll-down nil)
    (recenter))
  (defun +evil-scroll-up-and-center ()
    (interactive)
    (evil-scroll-up nil)
    (recenter))
  (map!
   :n "C-d" #'+evil-scroll-down-and-center
   :n "C-u" #'+evil-scroll-up-and-center))
(setenv "PATH" (concat "/usr/local/bin:" (getenv "PATH"))) ; Adjust path as necessary
(global-visual-line-mode t)
