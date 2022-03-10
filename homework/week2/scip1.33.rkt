
(define (filtered-accumulate filter? combiner null-value term a next b)
  (if (> a b)
      null-value
      (if (filter? a)
          (combiner (term a) (filtered-accumulate filter? combiner null-value term (next a) next b))
          (filtered-accumulate filter? combiner null-value term (next a) next b))))

;example
;(a)
;the sum of the squares of the prime numbers in the
;interval a to b (assuming that you have a prime? predicate
;already written)

(define (smallest-div n x)
  (cond ((= x n) x)
        ((= (remainder n x) 0) x)
        (else (smallest-div n (+ x 1)))))

(define (prime? n)
  (if (<= n 1)
      #false
      (= n (smallest-div n 2))))
      
(define (sum-of-squares a b)
  (filtered-accumulate prime? + 0 (lambda (x) (* x x)) a (lambda (x) (+ x 1)) b))

;;(b)
;b. the product of all the positive integers less than n that
;are relatively prime to n (i.e., all positive integers i < n
;such that GCD(i; n) = 1).

(define (gcd a b)
  (if (= b 0)
      a
      (gcd b (remainder a b))))

(define (product-relative-primes a)
  (define (gcd? n)
    (= (gcd a n) 1))
  (filtered-accumulate gcd? * 1 (lambda (x) x) 1 (lambda (x) (+ x 1)) a))