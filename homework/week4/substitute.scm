#lang racket
(require berkeley)

(define (reverse list)
 (define (iter-reverse in out)
   (if (null? in) out
       (iter-reverse (cdr in) (cons (car in) out)))) ;tail recursion so it is a iterative process
(iter-reverse list nil))

(define (substitute lst old new)
  (define (helper ls ans)
    (cond ((null? ls) ans)
          ((list? (car ls)) (helper (cdr ls) (cons (helper (reverse (car ls)) nil) ans)))
          ((equal? (car ls) old) (helper (cdr ls) (cons new ans)))
          (else (helper (cdr ls) (cons (car ls) ans)))))
  (helper (reverse lst) nil))

;alternative solution
(define (substitute-alternative lst old new)
  (cond ((null? lst) '())
	((equal? lst old) new)
	((pair? lst)
	 (cons (substitute (car lst) old new)
	       (substitute (cdr lst) old new)))
	(else lst)))

;example
(substitute '((lead guitar) (bass guitar) (rhythm guitar) drums) 'guitar 'axe)