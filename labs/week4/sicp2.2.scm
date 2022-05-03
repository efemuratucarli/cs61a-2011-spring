#lang racket
(require berkeley)

(define (make-point x y)
  (cons x y))

(define (x-point point)
  (car point))

(define (y-point point)
  (cdr point))

(define (make-segment initial-point terminal-point)
  (cons initial-point terminal-point))

(define (start-segment segment)
  (car segment))

(define (end-segment segment)
  (cdr segment))

(define (midpoint-segment segment)
  (make-point (/ (+ (x-point (start-segment segment)) (x-point (end-segment segment))) 2) ;x coordinate of the midpoint
              (/ (+ (y-point (start-segment segment)) (y-point (end-segment segment))) 2))) ;y coordinate of the midpoint

(define (print-point p)
  (newline)
  (display "(")
  (display (x-point p))
  (display ",")
  (display (y-point p))
  (display ")"))

;examples
(define z (make-point 3 4))
(define k (make-point 2 -2))
(define line (make-segment z k))
(define midpoint (midpoint-segment line))
(print-point midpoint)