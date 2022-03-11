(define (compose f g)
  (lambda (x) (f(g x))))

;Expectation
;((repeated square 2) 5)
;625

(define (repeated f num)
  (if (= num 0)
      (lambda (x) x)
      (compose f (repeated f (- num 1)))))

(define (square x)
  (* x x))

;evalution step
;((compose square (repeated square 1)) 5)
;(repeated square 1) --> (compose square (repeated f 0))
;(repeated square 0) --> (lambda (x) x)
;(repeated square 1) --> (compose square (lambda (x) x))
;((compose square (compose square (lambda (x) x))) 5)
;(square((compose square (lambda (x) x)) 5))