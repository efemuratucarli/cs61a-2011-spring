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

(define (square x)
  (* x x))

(define (segment-length segment)
  (sqrt (+ (square (- (x-point (start-segment segment))(x-point (end-segment segment))))
     (square (- (y-point (start-segment segment))(y-point (end-segment segment)))))))
  
;;(define (make-rectangle width-segment height-segment)
;;  (cons width-segment height-segment))
;
;(define (rectangle-perimeter rectangle)
;  (* 2 (+ (segment-length (car rectangle)) (segment-length (cdr rectangle)))))
;
;(define (rectangle-area rectangle)
;  (* (segment-length (car rectangle)) (segment-length (cdr rectangle))))

;alternative definitions which takes into account that angle between two adjacent segment must be 90 degrees (width and height)
(define (make-rectangle base height)
  (cons base height))

(define (base-rectangle rectangle)
  (car rectangle))

(define (height-rectangle rectangle)
  (cdr rectangle))

(define (first-leg rect)
  (if (pair? (cdr rect))
      (car rect)
      (base-rectangle rect)))

(define (second-leg rect)
  (if (pair? (cdr rect))
      (cdr rect)
      (let ((initial-point (start-segment (base-rectangle rect)))
            (ratio (/ (height-rectangle rect)(segment-length (base-rectangle rect))))
            (terminal-point (end-segment (base-rectangle rect))))
            (make-segment initial-point (make-point (- (x-point initial-point) (* ratio (- (y-point terminal-point) (y-point initial-point))))
                                         (+ (y-point initial-point) (* ratio (- (x-point terminal-point) (x-point initial-point)))))))))

(define (rectangle-perimeter rectangle)
  (* 2 (+ (segment-length (first-leg rectangle)) (segment-length (second-leg rectangle)))))

(define (rectangle-area rectangle)
  (* (segment-length (first-leg rectangle)) (segment-length (second-leg rectangle))))

(define z (make-point 2 0))
(define k (make-point 4 0))
(define zk (make-segment z k))
(define c (make-point 2 3))
(define zc (make-segment z c))
(define rectangle_instance (make-rectangle zk zc))
(rectangle-perimeter rectangle_instance) ;this call will return 10 as expected.
(rectangle-area rectangle_instance) ;this call will return 6 as expected
(define rectangle_instance2 (make-rectangle zk 3))
(rectangle-perimeter rectangle_instance2) ;this call will return 10 as expected.
(rectangle-area rectangle_instance2) ;this call will return 6 as expected