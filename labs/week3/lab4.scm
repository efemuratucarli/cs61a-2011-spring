#lang racket
(require berkeley)

;Write type-check. Its arguments are a function, a type-checking predicate that returns #t if and only if
;the datum is a legal argument to the function, and the datum.

(define (type-check procedure check? arg)
  (if (check? arg)
      (procedure arg)
      #f))