(require 'request)

(request
 "https://blog-sample.herokuapp.com/"
 :headers '(("User-Agent" . "Mozilla/5.0 (compatible; Unagispider/1.0)"))
 :parser 'buffer-string
 :success
 (cl-function
  (lambda (&key data &allow-other-keys)
    (princ "Got: %s" data)))
 :error
 (cl-function
  (lambda (&rest args &key error-thrown &allow-other-keys)
    (princ "Got error: %S" error-thrown))))

(sleep-for 3)
