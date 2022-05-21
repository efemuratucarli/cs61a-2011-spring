#lang racket
(require berkeley)

(define (same-parity x . ls)
 (define (helper lst ans)
   (cond ((null? lst) ans)
         ((equal? (even? (car lst)) (even? x)) (helper (cdr lst) (append ans (cons (car lst) nil))))
         (else (helper (cdr lst) ans))))
  (helper ls (cons x nil)))

(define (same-parity-alternative x . ls)
  (define (helper numlist)
    (cond ((null? numlist) nil)
	  ((equal? (even? x) (even? (car numlist)))
	   (cons (car numlist) (helper (cdr numlist))))
	  (else (helper (cdr numlist)))))
  (cons x (helper ls)))