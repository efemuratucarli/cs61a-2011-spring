#lang racket
(require berkeley)

(define (vowel? wd)
  (member? wd '(a A e E u U i I o O)))

(define (plural wd)
  (if (and (equal? (last wd)'y) (not (vowel? (last (butlast wd)))))
      (word (bl wd) 'ies)
      (word wd 's)))