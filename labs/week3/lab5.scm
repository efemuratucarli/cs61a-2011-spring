#lang racket
(require berkeley)

;It should take two arguments, a function and a type-checking predicate, and return a new function that
;returns #f if its argument doesn’t satisfy the predicate.
(define (make-safe fn pred)
  (lambda (x) (if (pred x)
                  (fn x)
                  #f)))
(define safe-sqrt (make-safe sqrt number?))