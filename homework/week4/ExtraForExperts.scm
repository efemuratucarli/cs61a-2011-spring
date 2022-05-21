#lang racket
(require berkeley)

(define (cxr-function wd)
  (define (helper-cxr wd)
  (if (empty? wd) (lambda (x) x)
      (lambda (x) ((if (equal? (first wd) 'a) car cdr)
                   ((helper-cxr (bf wd)) x)))))
  (helper-cxr (bf(bl wd))))

;examples
((cxr-function 'cadr) '(i ii iii iv v vi vii)) ;it returns 'ii as expected.
(define sixth (cxr-function 'cadddddr))
(sixth '(i ii iii iv v vi vii)) ;it returns 'vi as expected.