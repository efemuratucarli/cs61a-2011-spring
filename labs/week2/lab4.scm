#lang racket
(require berkeley)
;For each of the following expressions, what must f be in order for the evaluation of the expression to
;succeed, without causing an error? For each expression, give a definition of f such that evaluating the
;expression will not cause an error, and say what the expression’s value will be, given your definition.
;f
;(f)
;(f 3)
;((f))
;(((f)) 3)

;for f and (f) it can be implemented as follows
(define (f)
  (* 4 4))
f ;its value will be #<procedure:f>
(f) ;its value will be 16.

;for (f 3) it can be implemented as follows
(define (f x)
  (* x x))
(f 3) ;its return value will be 9

;for ((f)) it can be implemented as follows
(define (f)
  (lambda () (* 3 3)))
((f)) ;its return will be 9

;for (((f)) 3) it can be implemented as follows
(define (f)
  (lambda () (lambda (x) (+ x x))))
(((f)) 3) ;its return value will be 6