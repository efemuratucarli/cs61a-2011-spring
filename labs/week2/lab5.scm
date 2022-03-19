#lang racket
(require berkeley)
;Find the values of the expressions
;((t 1+) 0)
;((t (t 1+)) 0)
;(((t t) 1+) 0)
;where 1+ is a primitive procedure that adds 1 to its argument, and t is defined as follows:
;(define (t f)
;(lambda (x) (f (f (f x)))) )
;Work this out yourself before you try it on the computer!

(define (t f)
  (lambda (x) (f (f (f x)))) )

(define (1+ x)
  (+ x 1))

;((t 1+) 0) will be evaluated as follows
;(t 1+) will return a procedure so the entire expression will become like that ((lambda (x) (1+ (1+ (1+ x))))0)
;then this function call ((lambda (x) (1+ (1+ (1+ x))))0) will return (1+ (1+ (1+ 0))) finally its return value will be 3.

;((t (t 1+)) 0) will be evaluated as follows
;Firstly (t 1+) will be evaluated which will return (lambda (x) (1+ (1+ (1+ x))))
;then (t (lambda (x) (1+ (1+ (1+ x))))) will be evaluated which will return (lambda (x) ((lambda (x) (1+ (1+ (1+ x)))) ((lambda (x) (1+ (1+ (1+ x)))) ((lambda (x) (1+ (1+ (1+ x)))) x))))
;then this expression ((lambda (x) ((lambda (x) (1+ (1+ (1+ x)))) ((lambda (x) (1+ (1+ (1+ x)))) ((lambda (x) (1+ (1+ (1+ x)))) x)))) 0) will be evaluated which will be processed as follows
;(1+ (1+ (1+ x))) this expression will be evaluated in a nested structure three times which will return 9 (Respectively,from deepest procedure call to highest call,it will become 3 --> 6 and finally 9)

;(((t t) 1+) 0) ;will be evaluated as follows
;(t t) will return
;(lambda (x) (t (t (t x)))) then the evaluation process will be as follows
;((lambda (x) (t (t (t x)))) 1+) will return
;(t(t(t 1+)))
;then the entire expression will be reduced as ((t(t(t 1+)))0)
;actually (t 1+) produce a procedure which adds 3 to given argument so it can be named such as 3+
;so the entire expression can be reduced into a simpler form.
;(t (t +1)) can be interpreted as (lambda (x) (3+ (3+ (3+ x))))
;(t (t (t +1))) can be interpreted as (lambda (x) (9+ (9+ (9+ x))))
;((t (t (t +1))) 0) or in other words (((t t) 1+) 0) will return 27