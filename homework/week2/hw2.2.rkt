(define (every f sent)
  (if (empty? sent) '()
      (se (f (first sent)) (every f (bf sent)))))

(define (square x)
  (* x x))

(every square '(1 2 3 4)) ;returns '(1 4 9 16) as expected
(every first '(nowhere man)) ;returns '(n m) as expected