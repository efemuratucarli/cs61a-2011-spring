
;Exercise 1.40: Define a procedure cubic that can be used
;together with the newtons-method procedure in expressions
;of the form
;(newtons-method (cubic a b c) 1)
;to approximate zeros of the cubic x3 + ax2 + bx + c.

(define (deriv g)
  (lambda (x) (/ (- (g (+ x dx)) (g x)) dx)))

(define dx 0.00001)

(define (newton-transform g)
  (lambda (x) (- x (/ (g x) ((deriv g) x)))))

(define (newtons-method g guess)
  (fixed-point (newton-transform g) guess))

(define (cubic a b c)
  (lambda (x) (+ (* x x x) (* a x x) (* b x) c)))