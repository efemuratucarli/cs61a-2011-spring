#lang racket
(require berkeley)

;2. A “perfect number” is defined as a number equal to the sum of all its factors less than
;itself. For example, the first perfect number is 6, because its factors are 1, 2, 3, and 6,
;and 1+2+3=6. The second perfect number is 28, because 1+2+4+7+14=28. What is
;the third perfect number? Write a procedure (next-perf n) that tests numbers starting
;with n and continuing with n+1, n+2, etc. until a perfect number is found. Then you
;can evaluate (next-perf 29) to solve the problem.

;its time complexity is Theta(n)
(define (next-perf n)
  (define (sum-of-factors n k)
    (cond ((> k (/ n 2)) 0)
          ((= k 1) (+ 1 (sum-of-factors n (+ k 1))))
          ((= (remainder n k) 0) (+ k (sum-of-factors n (+ k 1))))
          (else (sum-of-factors n (+ k 1)))))
  (if (equal? (sum-of-factors n 1) n)
      n
      (next-perf (+ n 1)))) ;tail recursion

(next-perf 29) ;which returns 496.

;its time complexity is Theta(sqrt(n)) because when we found a factor we add this factor and (/ n factor) e.g for the input 6 we add 2 and 3 in a one function call.
(define (perf? n)
  (define (iter limit test sum)
    (cond ((> test limit) sum)
	  ((= (remainder n test) 0)
	   (cond ((= test limit) (+ sum test))
		 (else (iter limit (+ test 1) (+ sum test (/ n test))))))
	  (else (iter limit (+ test 1) sum))))
  (= n (iter (sqrt n) 2 1)))

(define (next-perf-better n)
  (cond ((< n 2) (next-perf-better 2))
        ((perf? n) n)
        (else (next-perf-better (+ n 1)))))

(next-perf-better 29) ;which returns 496 as well.