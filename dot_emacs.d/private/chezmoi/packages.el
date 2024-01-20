;;; packages.el --- chezmoi layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2024 Sylvain Benner & Contributors
;;
;; Author: fLock <flock@fedora>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; See the Spacemacs documentation and FAQs for instructions on how to implement
;; a new layer:
;;
;;   SPC h SPC layers RET
;;
;;
;; Briefly, each package to be installed or configured by this layer should be
;; added to `chezmoi-packages'. Then, for each package PACKAGE:
;;
;; - If PACKAGE is not referenced by any other Spacemacs layer, define a
;;   function `chezmoi/init-PACKAGE' to load and initialize the package.

;; - Otherwise, PACKAGE is already referenced by another Spacemacs layer, so
;;   define the functions `chezmoi/pre-init-PACKAGE' and/or
;;   `chezmoi/post-init-PACKAGE' to customize the package as it is loaded.

;;; Code:

(defconst chezmoi-packages
  '(chezmoi)
  "The list of Lisp packages required by the chezmoi layer.

Each entry is either:

1. A symbol, which is interpreted as a package to be installed, or

2. A list of the form (PACKAGE KEYS...), where PACKAGE is the
    name of the package to be installed or loaded, and KEYS are
    any number of keyword-value-pairs.

    The following keys are accepted:

    - :excluded (t or nil): Prevent the package from being loaded
      if value is non-nil

    - :location: Specify a custom installation location.
      The following values are legal:

      - The symbol `elpa' (default) means PACKAGE will be
        installed using the Emacs package manager.

      - The symbol `local' directs Spacemacs to load the file at
        `./local/PACKAGE/PACKAGE.el'

      - A list beginning with the symbol `recipe' is a melpa
        recipe.  See: https://github.com/milkypostman/melpa#recipe-format")


(defun chezmoi/init-chezmoi ()
  (use-package chezmoi
    :init
    (spacemacs/declare-prefix "o c" "chezmoi")

    (spacemacs/set-leader-keys
      "o c w" #'chezmoi-write
      "o c g" #'chezmoi-magit-status
      "o c d" #'chezmoi-diff
      "o c e" #'chezmoi-ediff
      "o c f" #'chezmoi-find
      "o c s" #'chezmoi-write-files
      "o c o" #'chezmoi-open-other
      "o c t" #'chezmoi-template-buffer-display
      "o c c" #'chezmoi-mode)

    (when (equalp dotspacemacs-editing-style 'vim)
      (defun chezmoi--evil-insert-state-enter ()
        "Run after evil-insert-state-entry."
        (chezmoi-template-buffer-display nil (point))
        (remove-hook 'after-change-functions #'chezmoi-template--after-change 1))

      (defun chezmoi--evil-insert-state-exit ()
        "Run after evil-insert-state-exit."
        (chezmoi-template-buffer-display nil)
        (chezmoi-template-buffer-display t)
        (add-hook 'after-change-functions #'chezmoi-template--after-change nil 1))

      (defun chezmoi-evil ()
        (if chezmoi-mode
            (progn
              (add-hook 'evil-insert-state-entry-hook #'chezmoi--evil-insert-state-enter nil 1)
              (add-hook 'evil-insert-state-exit-hook #'chezmoi--evil-insert-state-exit nil 1))
          (progn
            (remove-hook 'evil-insert-state-entry-hook #'chezmoi--evil-insert-state-enter 1)
            (remove-hook 'evil-insert-state-exit-hook #'chezmoi--evil-insert-state-exit 1))))
      (add-hook 'chezmoi-mode-hook #'chezmoi-evil))


    (setq chezmoi-template-display-p t) ;; Display template values in all source buffers.

    (require 'chezmoi-company)
    (add-hook 'chezmoi-mode-hook #'(lambda () (if chezmoi-mode
                                             (add-to-list 'company-backends 'chezmoi-company-backend)
                                           (setq company-backends (delete 'chezmoi-company-backend company-backends)))))

    ;; Turn off ligatures cuz they look bad.
    (add-hook 'chezmoi-mode-hook #'(lambda () (ligature-mode (if chezmoi-mode 0 1))))

    ;; I find this hook useful for my emacs config files generated through org-tangle.
    (defun chezmoi-org-babel-tangle ()
      (when-let ((fle (chezmoi-target-file (buffer-file-name))))
        (chezmoi-write file)))
    (add-hook 'org-babel-post-tangle-hook #'chezmoi-org-babel-tangle)))
