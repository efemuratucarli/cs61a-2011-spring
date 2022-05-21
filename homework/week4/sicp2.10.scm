#lang racket
(require berkeley)
;
;Exercise 2.10: Ben Bitdiddle, an expert systems programmer,
;looks over Alyssa’s shoulder and comments that it is
;not clear what it means to divide by an interval that spans
;zero. Modify Alyssa’s code to check for this condition and
;to signal an error if it occurs.

(define (make-interval a b) (cons a b))
(define (lower-bound interval) (car interval))
(define (upper-bound interval) (cdr interval))

(define (add-interval a b)
  (make-interval (+ (lower-bound a) (lower-bound b))
                 (+ (upper-bound a) (upper-bound b))))

(define (sub-interval a b)
  (add-interval a (make-interval (- (upper-bound b))
                                 (- (lower-bound b)))))

(define (mul-interval x y)
  (let ((p1 (* (lower-bound x) (lower-bound y)))
        (p2 (* (lower-bound x) (upper-bound y)))
        (p3 (* (upper-bound x) (lower-bound y)))
        (p4 (* (upper-bound x) (upper-bound y))))
    (make-interval (min p1 p2 p3 p4)
                   (max p1 p2 p3 p4))))

(define (div-interval x y)
  (if (and (<= (lower-bound y) 0) (>= (upper-bound y) 0))
      (error "can't divide by an interval which spans 0" y)
  (mul-interval
   x
   (make-interval (/ 1.0 (upper-bound y))
                  (/ 1.0 (lower-bound y))))))
;examples
(define z (make-interval 5 9))
(define k (make-interval 3 16))
(div-interval z k)
(define c (make-interval 0 5))
(div-interval z c)