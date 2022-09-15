#lang racket
(require berkeley)

;Exercise 2.27: Modify your reverse procedure of Exercise
;2.18 to produce a deep-reverse procedure that takes a list
;as argument and returns as its value the list with its elements
;reversed and with all sublists deep-reversed as well.
;For example,
;(define x (list (list 1 2) (list 3 4)))
;x
;((1 2) (3 4))
;(reverse x)
;((3 4) (1 2))
;(deep-reverse x)
;((4 3) (2 1))

;reverse procedure
(define (reverse list)
 (define (iter-reverse in out)
   (if (null? in) out
       (iter-reverse (cdr in) (cons (car in) out)))) ;tail recursion so it is a iterative process
(iter-reverse list nil))

;deep-reverse procedure
(define (deep-reverse list)
  (define (iter-reverse in out)
   (cond ((null? in) out)
         ((pair? (car in)) (iter-reverse (cdr in)(cons (deep-reverse (car in)) out)))
         (else (iter-reverse (cdr in) (cons (car in) out)))))
  (iter-reverse list nil))

(define l1 (list 1 2 3))
(define l2 (list (list 1 2) 2 3))
(define l3 (list (list 2 3 4 (list 1 2)) 2 3))

;deep-reverse version2
(define (deep-reverse2 list)
  (if (pair? list) (map deep-reverse2 (reverse list))
      list))