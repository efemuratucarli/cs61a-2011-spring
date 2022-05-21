#lang racket
(require berkeley)

(define (square-list items)
  (define (iter things answer)
    (if (null? things)
        answer
        (iter (cdr things)
              (cons (square (car things)) answer))))
  (iter items nil))

;it will return the squared-list in the reverse order because
;the code "(iter (cdr things) (cons (square (car things)) answer))))" will stick the squared number to the end of the list
;so in other words the code will build up the desired list from right to left which means in the end it will be reversed.

(define (square-list-vol2 items)
  (define (iter things answer)
    (if (null? things)
        answer
        (iter (cdr things)(cons answer (square (car things))))))
  (iter items nil))

;this version also does not return the desired answer because
;it will not create a list structure. The failure starts from putting 1 onto the empty list (() . 1) and the all structure fails in a similar manner.

(define (reverse list)
 (define (iter-reverse in out)
   (if (null? in) out
       (iter-reverse (cdr in) (cons (car in) out)))) ;tail recursion so it is a iterative process
(iter-reverse list nil))

(define (square-list-correct-version items)
  (define (iter things answer)
     (if (null? things)
        answer
        (iter (cdr things)
              (cons (square (car things)) answer))))
  (reverse (iter items nil)))