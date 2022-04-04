#lang racket
(require berkeley)

;Modify the cc procedure so that its kinds-of-coins parameter, instead of being an integer, is a
;sentence that contains the values of the coins to be used in making change. The coins should be tried in the
;sequence they appear in the sentence. For the count-change procedure to work the same in the revised
;program as in the original, it should call cc as follows:
;(define (count-change amount)
;  (cc amount ’(50 25 10 5 1)) )

(define (count-change amount) (cc amount '(50 25 10 5 1)))
(define (cc amount sent)
 (cond ((= amount 0) 1)
       ((or (< amount 0) (equal? sent '())) 0)
       (else (+ (cc amount(bf sent)) ;to use the coin type or not
                (cc (- amount(first sent)) sent)))))