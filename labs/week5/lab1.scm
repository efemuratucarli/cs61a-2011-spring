#lang racket
(require berkeley)

;Exercise 2.25: Give combinations of cars and cdrs that
;will pick 7 from each of the following lists:
;(1 3 (5 7) 9)
;((7))
;(1 (2 (3 (4 (5 (6 7))))))

(define first-list (list 1 3 (list 5 7) 9)) ;(1 3 (5 7) 9)
(define second-list (list (list 7))) ;((7))
(define third-list (list 1 (list 2 (list 3 (list 4 (list 5 (list 6 7))))))) ;(1 (2 (3 (4 (5 (6 7))))))

(car (cdr (car (cdr (cdr first-list)))))
(car (car second-list))
(car (cdr (car (cdr (car (cdr (car (cdr (car (cdr (car (cdr third-list))))))))))))

;Exercise 2.53: What would the interpreter print in response
;to evaluating each of the following expressions?
;
;(list 'a 'b 'c)
;(list (list 'george))
;(cdr '((x1 x2) (y1 y2)))
;(cadr '((x1 x2) (y1 y2)))
;(pair? (car '(a short list)))
;(memq 'red '((red shoes) (blue socks)))
;(memq 'red '(red shoes blue socks))

(list 'a 'b 'c) ;it will return '(a b c)
(list (list 'george)) ;it will return '((george))
(cdr '((x1 x2) (y1 y2))) ;it will return '((y1 y2))
(cadr '((x1 x2) (y1 y2))) ;it will return '(y1 y2)
(pair? (car '(a short list))) ;it will return #f
(memq 'red '((red shoes) (blue socks))) ;it will return #f
(memq 'red '(red shoes blue socks)) ;it will return '(red shoes blue socks)