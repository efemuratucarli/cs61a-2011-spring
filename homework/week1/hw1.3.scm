#lang racket
(require berkeley)

;Write a procedure switch that takes a sentence as its argument and returns a sentence
;in which every instance of the words I or me is replaced by you, while every instance of
;you is replaced by me except at the beginning of the sentence, where it’s replaced by I.
;(Don’t worry about capitalization of letters.) Example:
;> (switch ’(You told me that I should wake you up))
;(i told you that you should wake me up)

(define (switch stc)
  (se (switch-first (first stc))
      (switch-rest (bf stc))))

(define (switch-first wd)
  (cond ((equal? wd 'you) 'I)
	((equal? wd 'I) 'you)
	((equal? wd 'me) 'you)
	(else wd) ))

(define (switch-rest sent)
  (if (empty? sent)
      '()
      (se (switch-one (first sent))
	  (switch-rest (bf sent)) )))

(define (switch-one wd)
  (cond ((equal? wd 'you) 'me)
	((equal? wd 'I) 'you)
	((equal? wd 'me) 'you)
	(else wd) ))
  