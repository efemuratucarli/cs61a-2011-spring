#lang racket
(require berkeley)

(define (substitute2 lst old_items new_items)
  (define (select item old_items new_items)
    (cond ((null? old_items) item)
          ((equal? (car old_items) item) (car new_items))
          (else (select item (cdr old_items) (cdr new_items)))))
  (cond ((null? lst) nil)
        ((pair? lst) (cons (substitute2 (car lst) old_items new_items) (substitute2 (cdr lst) old_items new_items)))
        (else (select lst old_items new_items))))

(substitute2 '((4 calling birds) (3 french hens) (2 turtle doves)) '(1 2 3 4) '(one two three four))
;it returns -> ((four calling birds) (three french hens) (two turtle doves)) as expected