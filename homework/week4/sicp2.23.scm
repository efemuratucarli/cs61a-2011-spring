#lang racket
(require berkeley)

(define (for-each proc items)
 (define (helper-for proc items return-value)
   (cond ((equal? (cdr items) nil) (proc (car items)))
         (else (helper-for proc (cdr items) (proc (car items))))))
   (helper-for proc items 0))

;;alternative solution
(define (for-each-alternative proc items)
  (cond ((null? items) #t)
	(else (proc (car items))
	      (for-each-alternative proc (cdr items)))))