#lang racket
(require berkeley)

;Exercise 1.38: In 1737, the Swiss mathematician Leonhard
;Euler published a memoir De Fractionibus Continuis, which
;included a continued fraction expansion for e 􀀀 2, where
;e is the base of the natural logarithms. In this fraction, the
;Ni are all 1, and the Di are successively 1, 2, 1, 1, 4, 1, 1,
;6, 1, 1, 8, : : :. Write a program that uses your cont-frac
;procedure from Exercise 1.37 to approximate e, based on
;Euler’s expansion.

;recursive process (from 1 to k)
(define (cont-frac n d k)
  (define (helper-frac x)
    (if (> x k)
        0
    (/ (n x) (+ (d x) (helper-frac (+ x 1))))))
  (helper-frac 1))

(cont-frac (lambda (i) 1.0) (lambda(i) (if (= (remainder (+ i 1) 3) 0)
                                           (+ (* (/ 2 3) i) (/ 2 3))
                                           1.0)) 10)

(define (e k) (+ 2 (cont-frac (lambda (i) 1.0) (lambda(i) (if (= (remainder (+ i 1) 3) 0)
                                           (+ (* (/ 2 3) i) (/ 2 3))
                                           1.0)) k)))