(define (average x y)
  (/ (+ x y) 2))

(define (square x)
  (* x x))

(define (iterative-improvement good-enough? improve)
  (define (iterate guess)
    (if (good-enough? guess)
        guess
        (iterate (improve guess))))
  iterate)

(define (sqrt x)
  ((iterative-improvement (lambda (guess) (< (abs (- (square guess) x)) 0.0001))
                          (lambda (guess) (average guess (/ x guess))))
   1.0))