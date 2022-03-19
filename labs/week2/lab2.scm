#lang racket
(require berkeley)
;Write a procedure substitute that takes three arguments: a sentence, an old word, and a new word. It
;should return a copy of the sentence, but with every occurrence of the old word replaced by the new word.
;For example:
;> (substitute ’(she loves you yeah yeah yeah) ’yeah ’maybe)
;(she loves you maybe maybe maybe)

(define (substitute sent old new)
  (cond ((equal? sent '()) '())
        ((equal? (first sent) old) (se new (substitute (bf sent) old new)))
        (else (se (first sent) (substitute (bf sent) old new)))))  