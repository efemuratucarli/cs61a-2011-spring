#lang racket
(require berkeley)

;Identify two ways to change the program to reverse the order in which coins are tried, that is, to change
;the program so that pennies are tried first, then nickels, then dimes, and so on.

;original program which is found in SICP
;(define (count-change amount) (cc amount 5))
;(define (cc amount kinds-of-coins)
; (cond ((= amount 0) 1)
;       ((or (< amount 0) (= kinds-of-coins 0)) 0)
;       (else (+ (cc amount(- kinds-of-coins 1)) ;to use the coin type or not
;                (cc (- amount(first-denomination kinds-of-coins)) kinds-of-coins)))))
;
;(define (first-denomination kinds-of-coins)
;  (cond ((= kinds-of-coins 1) 1)
;        ((= kinds-of-coins 2) 5)
;        ((= kinds-of-coins 3) 10)
;        ((= kinds-of-coins 4) 25)
;        ((= kinds-of-coins 5) 50)))

;new version reverse order
(define (count-change amount) (cc amount 5))
(define (cc amount kinds-of-coins)
 (cond ((= amount 0) 1)
       ((or (< amount 0) (= kinds-of-coins 0)) 0)
       (else (+ (cc amount(- kinds-of-coins 1)) ;to use the coin type or not
                (cc (- amount(first-denomination kinds-of-coins )) kinds-of-coins)))))

(define (first-denomination kinds-of-coins)
  (cond ((= kinds-of-coins 1) 50)
        ((= kinds-of-coins 2) 25)
        ((= kinds-of-coins 3) 10)
        ((= kinds-of-coins 4) 5)
        ((= kinds-of-coins 5) 1)))

;another alternative
(define (count-change amount) (cc amount 1))
(define (cc amount kinds-of-coins)
 (cond ((= amount 0) 1)
       ((or (< amount 0) (> kinds-of-coins 5)) 0)
       (else (+ (cc amount(+ kinds-of-coins 1)) ;to use the coin type or not
                (cc (- amount(first-denomination kinds-of-coins )) kinds-of-coins)))))

(define (first-denomination kinds-of-coins)
  (cond ((= kinds-of-coins 1) 1)
        ((= kinds-of-coins 2) 5)
        ((= kinds-of-coins 3) 10)
        ((= kinds-of-coins 4) 25)
        ((= kinds-of-coins 5) 50)))