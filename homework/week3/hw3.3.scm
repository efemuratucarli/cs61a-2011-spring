#lang racket
(require berkeley)

;Explain the effect of interchanging the order in which the base cases in the cc procedure
;on page 41 of Abelson and Sussman are checked. That is, describe completely the set of
;arguments for which the original cc procedure would return a different value or behave
;differently from a cc procedure coded as given below, and explain how the returned values
;would differ.
;(define (cc amount kinds-of-coins)
    ;(cond ((or (< amount 0) (= kinds-of-coins 0)) 0)
           ;((= amount 0) 1)
           ;(else ... ) ) ) ; as in the original version

;original version
(define (cc amount kinds-of-coins)
  (cond ((= amount 0) 1)
	((or (< amount 0) (= kinds-of-coins 0)) 0)
	(else ...)))

;interchanging the order of base cases
(define (cc amount kinds-of-coins)
    (cond ((or (< amount 0) (= kinds-of-coins 0)) 0)
           ((= amount 0) 1)
           (else ... ) ) ) ; as in the original version

;in the original version the first base case provides an return value for the event amount equals to 0 (just like in probabilty)
;and the second base case provides an return value for the event that amount is less than 0 or kinds-of-coins is 0
;the only way the second test can be satisfied is if KINDS-OF-COINS is also zero. With the original version, (cc 0 0) will return 1
;whereas with the reordered version (cc 0 0) will return 0 but the correct answer to (cc 0 0) has to be 1 because there is only one way to count zero cents which is using no coins.
;so the original order of the base cases is correct.