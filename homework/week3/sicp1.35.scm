#lang racket
(require berkeley)

;Exercise 1.35: Show that the golden ratio ϕ (Section 1.2.2)
;is a fixed point of the transformation x 7! 1 + 1=x, and
;use this fact to compute ϕ by means of the fixed-point
;procedure.

(define tolarence 0.0001)
(define (fixed-point f first-guess)
  (define (close-enough v1 v2)
    (< (abs (- v1 v2)) tolarence))
  (define (try guess)
    ((lambda (next) (if (close-enough guess next)
                        next
                        (try next))) (f guess)))
  (try first-guess))

(define (g x)
  (+ 1 (/ 1 x)))

(fixed-point g 1)