(define (product term n next b)
  (if (> n b)
      1
      (* (term n) (product term (next n) next b))))

(define (factorial n)
  (product (lambda (x) x)  1 (lambda (x) (+ x 1)) n))

(define (pi start term)
   (if (<= start 0)
       '(the starting point of number of terms must be a positive integer)
       (* 4 (product (lambda (start)
              (if (even? start) (/ (+ start 2) (+ start 1)) (/ (+ start 1) (+ start 2)))) start add1 term))))