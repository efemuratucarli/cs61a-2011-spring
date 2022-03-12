;example
(define (sumsq a b)
  (define (square x) (* x x))
  (+ (square a) (square b)))

;evulation steps in order (substitution principle)
((lambda (a b)
   ((lambda (square)
      (+ (square a) (square b)))
    (lambda (x) (* x x))))3 4)

((lambda (square)
      (+ (square 3) (square 4)))
    (lambda (x) (* x x)))

(+ ((lambda (x) (* x x)) 3) ((lambda (x) (* x x)) 4))
(+ (* 3 3) (* 4 4))

;implement the recursive idea with the parameter f(Y combinator)
((lambda (f n) (if (= n 0) 1 (* n (f f (- n 1)))))
 (lambda (f n) (if (= n 0) 1 (* n (f f (- n 1))))) 5)

(let ((f (lambda (f n) (if (= n 0) 1 (* n (f f (- n 1)))))))
  (lambda (x) (f f x)))

;expand let expression
((lambda (f) (lambda (x) (f f x))) (lambda (f n) (if (= n 0) 1 (* n (f f (- n 1)))))) ;this returns factorial function