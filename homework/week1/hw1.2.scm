#lang racket
(require berkeley)

;Write a procedure squares that takes a sentence of numbers as its argument and
;returns a sentence of the squares of the numbers:

;> (squares ’(2 3 4 5))
;(4 9 16 25)

;first reduce problem into a similar smaller problem then solve it recursively.

(define (squares nums)
  (if (empty? nums)
      '()
      (se (square (first nums))
          (squares (bf nums)))))