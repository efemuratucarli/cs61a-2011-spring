#lang racket
(require berkeley)
;Find the values of the expressions
;((t s) 0)
;((t (t s)) 0)
;(((t t) s) 0)
;where t is defined as in question 2 above, and s is defined as follows:
;(define (s x)
;  (+ 1 x))

(define (t f)
  (lambda (x) (f (f (f x)))) )

(define (s x)
  (+ 1 x))

;((t s) 0) will be evaluated as follows
;(lambda (x) (s (s (s x))))
;(s (s (s 0))) --> (s (s 1)) --> (s 2) --> the return value of the whole expression will be 3

;((t (t s)) 0) will be evaluated as follows
;(t s) will produce a procedure which add 3 to given argument
;so (t (t s)) can be interpreted as (lambda (x) (3+(3+(3+ x))))
;As a consequence the return value of ((t (t s)) 0) will be 9 

;(((t t) s) 0) will be evaluated as follows
;(t t) will return (lambda (x) (t (t (t x))))
;((lambda (x) (t (t (t x)))) s) will return (t(t(t s)))
;as I said before (t s) will produce a procedure which add 3 to given argument
;so (t (t s)) can be interpreted as (lambda (x) (3+(3+(3+ x)))) which means (t (t s)) produce a procedure which add 9 to given argument
;then (t(t(t s))) can be interpreted as (lambda (x) (9+ (9+ (9+ x))))
;finally the whole expression becomes ((lambda (x) (9+ (9+ (9+ x))))0) so the invocation of this procedure will return 27