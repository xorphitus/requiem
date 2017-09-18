(require 'request)

(defun req (url)
  (request
   url
   :headers '(("User-Agent" . "Mozilla/5.0 (compatible; Unagispider/1.0)"))
   :parser 'buffer-string
   :success
   (cl-function
    (lambda (&key data &allow-other-keys)
      (princ "Got: %s" data)))
   :error
   (cl-function
    (lambda (&rest args &key error-thrown &allow-other-keys)
      (princ "Got error: %S" error-thrown)))))

(dotimes (i 10)
  (req "https://blog-sample.herokuapp.com/"))

(sleep-for 3)
