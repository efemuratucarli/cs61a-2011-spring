#lang racket
(require berkeley)

;(1)Write a procedure number-of-partitions that computes the number of partitions of its
;nonnegative integer argument.
;recursive process
(define (number-of-partitions n)
  (define (helper n k)
    (cond ((= n 0) 1)
          ((or (= k 0) (< n 0)) 0)
          (else (+ (helper n (- k 1)) (helper (- n k) k)))))
  (helper n n))

;2. Compare the number-of-partitions procedure with the count-change procedure by
;completing the following statement:
;Counting partitions is like making change, where the coins are ...

;Counting partitions is like making change, where the coins are the positive integers

;3. (Much harder!) Now write it to generate an iterative process; every recursive call must
;be a tail call.

;iterative process
(define (number-of-partitions-iter num)
  (define (helper num part next)
    (cond ((= num 0) (next 1))
          ((or (< num 0) (= part 0)) (next 0))
          (else (helper (- num part) part (lambda (result1) (helper num (- part 1) (lambda (result2) (next (+ result1 result2)))))))));tail recursion
   (helper num num (lambda (result) result)))

(number-of-partitions-iter 5)