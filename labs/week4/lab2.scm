#lang racket
(require berkeley)

(define x (cons 4 5))
(define y (cons 'hello 'goodbye))
(define z (cons x y))
(cdr (car z)) ;this expression will return 5
(car (cons 8 3)) ;this expression will return 8
(car z) ;this expression will return (4 . 5)
(car 3) ;this expression will throw an error because the argument of car 3 is not a pair.