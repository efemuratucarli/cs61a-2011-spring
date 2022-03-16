#lang racket
(require berkeley)
;Write a procedure dupls-removed that, given a sentence as input, returns the result of removing duplicate
;words from the sentence. It should work this way:
;> (dupls-removed ’(a b c a e d e b))
;(c a d e b)
;> (dupls-removed ’(a b c))
;(a b c)
;> (dupls-removed ’(a a a a b a a))
;(b a)

(define (dupls-removed sent)
  (cond ((or (equal? (count sent) 1) (equal? (count sent) 0)) sent)
    ((member? (first sent) (bf sent))(dupls-removed (bf sent)))
      (else (se (first sent) (dupls-removed (bf sent))))))