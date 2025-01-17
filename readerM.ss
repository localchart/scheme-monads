(library (monad readerM)
         (export readerM
                 unit-reader
                 bind-reader
                 run-reader
                 ask-reader
                 local-reader
                 lookup-reader
                 walk-reader)
         (import (chezscheme)
                 (monad core))

(define unit-reader
  (lambda (a)
    (lambda (e) a)))

(define bind-reader
  (lambda (m f)
    (lambda (e)
      (let ((a (m e)))
        (let ((m^ (f a)))
          (m^ e))))))

(define run-reader
  (lambda (m e)
    (m e)))

(define ask-reader
  (lambda ()
    (lambda (e) e)))

(define local-reader
  (lambda (f m)
    (lambda (e)
      (m (f e)))))

(define lookup-reader
  (lambda (x)
    (lambda (e)
      (cond
        ((assq x e) => cdr)
        (else #f)))))

(define walk-reader
  (lambda (x)
    (lambda (e)
      (cond
       ((assq x e) => cdr)
       (else x)))))

(define-monad readerM
  unit-reader
  bind-reader
  mzero-err
  mplus-err
  lift-err)

)