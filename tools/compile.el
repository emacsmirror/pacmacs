(require 'cask "~/.cask/cask.el")

(let ((bundle (cask-initialize default-directory)))
  (require 'dash)
  (require 'dash-functional)
  (require 'f)
  (require 'bytecomp)
  (let* ((byte-compile-error-on-warn t)
         (load-path (cons (cask-path bundle) (cask-load-path bundle))))
    (when (->> (cask-files bundle)
               (-filter (-lambda (path)
                          (and (f-file? path)
                               (f-ext? path "el"))))
               (-map (-lambda (file)
                       (byte-compile-file file nil)))
               (-any #'null))
      (kill-emacs 1))))
