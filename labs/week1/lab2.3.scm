#lang racket
(require berkeley)

;Define a procedure that takes three numbers as arguments and returns the sum of the squares of the two
;larger numbers.

(define (sum-squares x y z)
  (define (square a) (* a a))
  (define (sumsq b c) (+ (square b) (square c)))
  (cond ((and (<= x y) (<= x z)) (sumsq z y))
         ((and (<= y z) (<= y x)) (sumsq x z))
         (else (sumsq x y))))