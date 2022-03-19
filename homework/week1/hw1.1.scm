#lang racket
(require berkeley)

;;Do exercise 1.6, page 25. This is an essay question; you needn’t hand in any computer
;printout, unless you think the grader can’t read your handwriting. If you had trouble
;understanding the square root program in the book, explain instead what will happen if
;you use new-if instead of if in the pigl Pig Latin procedure.

(define (new-if predicate then-clause else-clause)
  (cond (predicate then-clause)
        (else else-clause)))

(define (average x y)
  (/ (+ x y) 2))

(define (square x)
  (* x x))

(define (improve guess x)
  (average guess (/ x guess)))

(define (good-enough? guess x)
  (< (abs (- (square guess) x)) 0.001))

(define (sqrt-iter guess x)
  (new-if (good-enough? guess x)
          guess
          (sqrt-iter (improve guess x) x)))

(define (sqrt x)
  (sqrt-iter 1.0 x))

;answer
;Because of the fact that new-if is a ordinary procedure,we needed to evaluate the argument expression inner sqrt-iter before
;invocation of new-if. Then it will call sqrt-iter repeatedly.Therefore Scheme never finds out that it's time to stop iterating.
;Finally it gives out of memory error.