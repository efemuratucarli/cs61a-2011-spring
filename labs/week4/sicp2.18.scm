#lang racket
(require berkeley)

(define (reverse list)
 (define (iter-reverse in out)
   (if (null? in) out
       (iter-reverse (cdr in) (cons (car in) out)))) ;tail recursion so it is a iterative process
(iter-reverse list nil))