#lang racket
(require berkeley)
;Eva Lu Ator types to the interpreter the expression
;(car ''abracadabra)
;To her surprise, the interpreter prints back quote. Explain.

(car ''abracadabra)

;First of all, 'something is an abbreviation for (quote something)
;with quoting we construct data objects from various symbols
;in this problem ''abracadabra is an abbreviation for (quote (quote abracadabra))
;so the entire expression becomes (car (quote (quote abracadabra)))
;According to evaluation rules, the symbol car evaluates to a function
;The inner quote doesn't get evaluated, it's just a symbol, with no particular meaning.
;so the actual argument of the outer quote becomes (quote abracadabra) and the return value of outer
;quote is a datum which is like a list and that list is an actual argument to car and the car returns the first element of that list namely
;quote