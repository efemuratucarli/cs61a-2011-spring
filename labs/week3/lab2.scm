#lang racket
(require berkeley)

;Abelson and Sussman claim that this change would not affect the correctness of the computation.
;However, it does affect the efficiency of the computation. Implement one of the ways you devised in
;exercise 1 for reversing the order in which coins are tried, and determine the extent to which the number
;of calls to cc is affected by the revision. Verify your answer on the computer, and provide an explanation.
;Hint: limit yourself to nickels and pennies, and compare the trees resulting from (cc 5 2) for each order.

;original version
;(define (count-change amount) (cc amount 5))
;(define (cc amount kinds-of-coins)
; (cond ((= amount 0) 1)
;       ((or (< amount 0) (= kinds-of-coins 0)) 0)
;       (else (+ (cc amount(- kinds-of-coins 1)) ;to use the coin type or not
;                (cc (- amount(first-denomination kinds-of-coins )) kinds-of-coins)))))
;
;(define (first-denomination kinds-of-coins)
;  (cond ((= kinds-of-coins 1) 1)
;        ((= kinds-of-coins 2) 5)
;        ((= kinds-of-coins 3) 10)
;        ((= kinds-of-coins 4) 25)
;        ((= kinds-of-coins 5) 50)))
;
;(cc 5 2)

;evalution and invoking process
;(cc 5 2)
;  (cc 5 1)
;  (cc 0 2) --> returns 1
;    (cc 5 0) --> returns 0
;    (cc 4 1)
;      (cc 4 0) --> returns 0
;      (cc 3 1)
;        (cc 3 0) --> returns 0
;        (cc 2 1)
;          (cc 2 0) --> returns 0
;          (cc 1 1)
;            (cc 1 0) --> returns 0
;             (cc 0 1) --> returns 1
;13 steps

;alternate version
(define (count-change amount) (cc amount 5))
(define (cc amount kinds-of-coins)
 (cond ((= amount 0) 1)
       ((or (< amount 0) (= kinds-of-coins 0)) 0)
       (else (+ (cc amount(- kinds-of-coins 1)) ;to use the coin type or not
                (cc (- amount(first-denomination kinds-of-coins )) kinds-of-coins)))))

(define (first-denomination kinds-of-coins)
  (cond ((= kinds-of-coins 1) 5)
        ((= kinds-of-coins 2) 1)))
(cc 5 2)
;evalution and invoking process
;(cc 5 2)
; (cc 5 1)
; (cc 4 2)
;   (cc 5 0) --> returns 0
;   (cc 0 1) --> returns 1
;   (cc 4 1)
;   (cc 3 2)
;    (cc 4 0) --> returns 0
;    (cc -1 1) --> returns 0
;    (cc 3 1)
;    (cc 2 2)
;      (cc 3 0) --> returns 0
;      (cc -2 1) --> returns 0
;      (cc 2 1)
;      (cc 1 2)
;        (cc 2 0) --> returns 0
;        (cc -3 1) --> returns 0
;        (cc 1 1)
;        (cc 0 2) --> returns 1
;         (cc 1 0) --> returns 0
;         (cc -4 1) --> returns 0
;21 steps

;we obtain the same answer from both procedure but the original one is more efficient.
;the reason of that consequence is in the original version when we invoke these procedures
;(cc 5 1)
;(cc 0 2) -- returns 1
;we eliminate the idea of using nickels for counting 4 cents. we only use 1 cents for counting 4 cents in the later steps of the process
;But in the alternate version we have to realize a nickel is too big for 4 cents, 3 cents etc which is the reasons of the function calls (cc -1 1)(cc -2 1) (cc -3 1) (cc -4 1)
;there is no negative amount of money in the original version.