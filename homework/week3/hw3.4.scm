#lang racket
(require berkeley)

;Give an algebraic formula relating the values of the parameters b, n, counter, and
;product of the expt and exp-iter procedures given near the top of page 45 of Abelson
;and Sussman. (The kind of answer we’re looking for is “the sum of b, n, and counter times
;product is always equal to 37.”)

(define (expt b n)
  (expt-iter b n 1))
(define (expt-iter b counter product)
  (if (= counter 0)
      product
      (expt-iter b
                 (- counter 1)
                 (* b product))))

;the invariant formula can be --> (b^counter)*product = b^n (this identity is correct for every state of the computatiton)
