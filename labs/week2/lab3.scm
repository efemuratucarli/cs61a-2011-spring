#lang racket
(require berkeley)

;Consider a Scheme function g for which the expression
;((g) 1)
;returns the value 3 when evaluated. Determine how many arguments g has. In one word, also describe as
;best you can the type of value returned by g.

;answer
;if (g) is valid expression,then it has to take zero argument. g returns a procedure which can be implemented as follows.
(define (g)
  (lambda (x) (+ x 2)))
((g) 1)