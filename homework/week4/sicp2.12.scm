#lang racket
(require berkeley)

(define (make-interval a b) (cons a b))
(define (lower-bound interval) (car interval))
(define (upper-bound interval) (cdr interval))

(define (make-center-percent c p)
  (let ((tolerance (* c p 0.01)))
    (make-interval (- c tolerance) (+ c tolerance))))
        

(define (center i)
  (/ (+ (lower-bound i) (upper-bound i)) 2))

(define (percent i)
  (* 100  (/ (/ (- (upper-bound i) (lower-bound i)) 2)
             (/ (+ (upper-bound i) (lower-bound i)) 2))))

;example
(define z (make-interval 120 200))
(define z-center (center z))
(define z-percentage (percent z))
(make-center-percent z-center z-percentage) ;it returns '(120.0 . 200.0) as expected
(make-center-percent 100 40) ;it returns '(60.0 . 140.0) as expected