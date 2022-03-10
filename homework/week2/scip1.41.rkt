
;Exercise 1.41: Define a procedure double that takes a procedure
;of one argument as argument and returns a procedure
;that applies the original procedure twice. For example,
;if inc is a procedure that adds 1 to its argument, then
;(double inc) should be a procedure that adds 2. What
;value is returned by
;(((double (double double)) inc) 5)

(define (double g)
  (lambda (x) (g(g x))))

;example
((double add1) 1) ;returns 3 as expected.

;What value is returned by
;(((double (double double)) inc) 5)

;the return value will be 21.
;double modifies a function into a function which will be applied twice
;(double double) turns a function into one that will be applied four times.
;(double (double double)) makes a function that applies (double double)
;twice -- that is, make a function that applies the argument function
;16 times.