#lang racket
(require berkeley)

;recursive process (from 1 to k)
(define (cont-frac n d k)
  (define (helper-frac x)
    (if (equal? x k)
        (/ (n x) (d x))
    (/ (n x) (+ (d x) (helper-frac (+ x 1))))))
  (helper-frac 1))

(cont-frac (lambda (i) 1.0) (lambda(i) 1.0) 11)

;iterative process (tail recursion) from k to 1
(define (cont-frac-iter n d k)
  (define (helper-iter x current)
    (if (= x 0)
        current
    (helper-iter (- x 1) (/ (n (- x 1))(+ (d (- x 1)) current)))))
  (helper-iter k (/ (n k) (d k))))
 
(cont-frac-iter (lambda (i) 1.0) (lambda (i) 1.0) 15)

(define (phi k) (/ 1 (cont-frac-iter (lambda (i) 1.0) (lambda (i) 1.0) k)))