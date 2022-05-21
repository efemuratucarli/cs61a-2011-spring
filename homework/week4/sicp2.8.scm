#lang racket
(require berkeley)

(define (make-interval a b) (cons a b))
(define (lower-bound interval) (car interval))
(define (upper-bound interval) (cdr interval))

(define (add-interval a b)
  (make-interval (+ (lower-bound a) (lower-bound b))
                 (+ (upper-bound a) (upper-bound b))))

(define (sub-interval a b)
  (add-interval a (make-interval (- (upper-bound b))
                                 (- (lower-bound b)))))

;examples
(define z (make-interval 5 9))
(define k (make-interval 3 16))
(sub-interval z k)