#lang racket
(require berkeley)

(define (twenty-one strategy)
  (define (play-dealer customer-hand dealer-hand-so-far rest-of-deck)
    (cond ((> (best-total dealer-hand-so-far) 21) 1)
	  ((< (best-total dealer-hand-so-far) 17)
	   (play-dealer customer-hand
			(se dealer-hand-so-far (first rest-of-deck))
			(bf rest-of-deck)))
	  ((< (best-total customer-hand) (best-total dealer-hand-so-far)) -1)
	  ((= (best-total customer-hand) (best-total dealer-hand-so-far)) 0)
	  (else 1)))

  (define (play-customer customer-hand-so-far dealer-up-card rest-of-deck)
    (cond ((> (best-total customer-hand-so-far) 21) -1)
	  ((strategy customer-hand-so-far dealer-up-card)
	   (play-customer (se customer-hand-so-far (first rest-of-deck))
			  dealer-up-card
			  (bf rest-of-deck)))
	  (else
	   (play-dealer customer-hand-so-far
			(se dealer-up-card (first rest-of-deck))
			(bf rest-of-deck)))))

  (let ((deck (make-deck)))
    (play-customer (se (first deck) (first (bf deck)))
		   (first (bf (bf deck)))
		   (bf (bf (bf deck))))) )

(define (make-ordered-deck)
  (define (make-suit s)
    (every (lambda (rank) (word rank s)) '(A 2 3 4 5 6 7 8 9 10 J Q K)) )
  (se (make-suit 'H) (make-suit 'S) (make-suit 'D) (make-suit 'C)) )

(define (make-deck)
  (define (shuffle deck size)
    (define (move-card in out which)
      (if (= which 0)
	  (se (first in) (shuffle (se (bf in) out) (- size 1)))
	  (move-card (bf in) (se (first in) out) (- which 1)) ))
    (if (= size 0)
	deck
    	(move-card deck '() (random size)) ))
  (shuffle (make-ordered-deck) 52) )

(define (best-total hand)
  (define (best-total-helper hand total)
     (cond ((equal? hand '()) total)
           ((member? (bl (first hand)) '(A a)) (let ((updated-sum (+ 11 (best-total-helper (bf hand) total))))
                                                 (if (> updated-sum 21) (- updated-sum 10) updated-sum)))
           ((member? (bl (first hand)) '(k q j K Q J)) (best-total-helper (bf hand) (+ total 10)))
           (else (best-total-helper (bf hand) (+ total (bl (first hand)))))))
(best-total-helper hand 0))

(define (check-expect comparison test expected)
  (if (comparison test expected) '(Testing successful)
      '(Testing unsuccessful)))

(check-expect equal? (best-total '(ad 8s)) 19)
(check-expect equal? (best-total '(ad 8s 5h)) 14)
(check-expect equal? (best-total '(ad as 9h)) 21)
(check-expect equal? (best-total '(js 5h)) 15)
(check-expect equal? (best-total '(10s 5h)) 15)
(check-expect equal? (best-total '(5s ad)) 16)
(check-expect equal? (best-total '(10s 9d ad)) 20)
(check-expect equal? (best-total '(ad as ah)) 13)
(check-expect equal? (best-total '(10s 10s 2c)) 22) ;bust(go over 21)

;2
(define (stop-at-17 hand dealer-up-card)
  (< (best-total hand) 17))

;path complete and boundary case (glass-box test)
(check-expect equal? (stop-at-17 '(ad 8s) '8s) #f)
(check-expect equal? (stop-at-17 '(ad 8s 5h) '8s) #t)
(check-expect equal? (stop-at-17 '(ad 6s) '8s) #f)

;3
(define (play-n strategy n)
  (define (helper win loss n)
    (cond ((= n 0) (- win loss))
          ((= (twenty-one strategy) 1) (helper (+ win 1) loss (- n 1)))
          ((= (twenty-one strategy 0)) (helper win loss (- n 1)))
          (else (helper win (- loss 1) (- n 1)))))
  (helper 0 0 n))

;4
(define (dealer-sensitive customer-hand up-card)
  (cond ((>= (best-total customer-hand) 17) #f)
        ((and (or (equal? (first up-card) 'a) (and (number? (first up-card)) (> (butlast up-card) 6))
             (member? (first up-card) '(k q j K Q J)))(< (best-total customer-hand) 17)) #t)
        ((and (and (number? (first up-card)) (<= (butlast up-card) 6)) (< (best-total customer-hand) 12)) #t)
        (else #f)))


(check-expect equal? (dealer-sensitive '(ac 5s) 'as) #t)
(check-expect equal? (dealer-sensitive '(ac 5s) 'ks) #t)
(check-expect equal? (dealer-sensitive '(ac) 'ac) #t)
(check-expect equal? (dealer-sensitive '(ac) '10s) #t)
(check-expect equal? (dealer-sensitive '(ac) 'ks) #t)
(check-expect equal? (dealer-sensitive '(ac) '7s) #t)
(check-expect equal? (dealer-sensitive '(ac) '2s) #t)
(check-expect equal? (dealer-sensitive '(ac) '4s) #t)
(check-expect equal? (dealer-sensitive '(ac) '6s) #t)
(check-expect equal? (dealer-sensitive '(5s ac) '2s) #f) ;17 > customer hand > 12 but 2 <= dealer's up card <= 6 therefore stop taking
(check-expect equal? (dealer-sensitive '(8s ac) '8s) #f) ;customer hand > 17 so stop taking

;5
(define (stop-at n)
  (lambda (hand dealer-up-card) (< (best-total hand) n)))

(check-expect equal? ((stop-at 17) '(as 6c) '2c) #f)
(check-expect equal? ((stop-at 19) '(as 6c) '2c) #t)
(check-expect equal? ((stop-at 20) '(9s 10c) '2c) #t)

;6
(define (valentine hand dealer-up-card)
  (define (helper new-hand dealer-up-card initial-hand)
    (cond ((empty? new-hand) ((stop-at 17) initial-hand dealer-up-card))
          ((or (equal? (last (first new-hand)) 'h) (equal? (last (first new-hand)) 'H)) ((stop-at 19) initial-hand dealer-up-card))
          (else (helper (bf new-hand) dealer-up-card initial-hand))))
  (helper hand dealer-up-card hand))

(check-expect equal? (valentine '(ad 2c 5h) '3s) #t)
(check-expect equal? (valentine '(ad 2c 6h) '3s) #f)
(check-expect equal? (valentine '(ad 2c 5c) '3s) #f)
(check-expect equal? (valentine '(ad 2c 2c) '3s) #t)

;7
(define (suit-function suit true-strategy false-strategy)
  (define (general hand dealer-up-card)
  (define (helper new-hand dealer-up-card initial-hand)
    (cond ((empty? new-hand) (false-strategy initial-hand dealer-up-card))
          ((equal? (last (first new-hand)) suit) (true-strategy initial-hand dealer-up-card))
          (else (helper (bf new-hand) dealer-up-card initial-hand))))
  (helper hand dealer-up-card hand))
  (lambda (hand dealer-up-card)
    (general hand dealer-up-card)))

(define (valentine_vol2 hand dealer-up-card)
  ((suit-function 'h (stop-at 19) (stop-at 17)) hand dealer-up-card))

(check-expect equal? (valentine_vol2 '(ad 2c 5h) '3s) #t)
(check-expect equal? (valentine_vol2 '(ad 2c 7h) '3s) #f)
(check-expect equal? (valentine_vol2 '(10d 2c 5c) '3s) #f)
(check-expect equal? (valentine_vol2 '(ad 2c 2c) '3s) #t)

;8
(define (majority strategy1 strategy2 strategy3)
  (lambda (hand dealer-up-card)
    (cond ((and (strategy1 hand dealer-up-card) (strategy2 hand dealer-up-card)) #t)
           ((and (strategy2 hand dealer-up-card) (strategy3 hand dealer-up-card)) #t)
           ((and (strategy1 hand dealer-up-card) (strategy3 hand dealer-up-card)) #t)
           (else #f))))

(check-expect equal? ((majority stop-at-17 dealer-sensitive valentine) '(ad 3s) '2s) #t) ;stop-at-17 and valentine return true for the given arguments '(ad 3s) '2s so the entire majority strategy returns a procedure which returns true for the given arguments '(ad 3s) '2s
(check-expect equal? ((majority stop-at-17 dealer-sensitive valentine) '(ad 6s) '2s) #f) ;all the strategies, which are arguments of majority procedure, return false for the given arguments '(ad 6s) '2s so the entire majority strategy returns a procedure which returns false for the given arguments '(ad 6s) '2s
(check-expect equal? ((majority stop-at-17 dealer-sensitive valentine) '(ad 6h) '2s) #f) ;stop-at-17 and dealer-sensitive return false for the given arguments '(ad 6h) '2s so the entire majority strategy returns a procedure which returns false for the given arguments '(ad 6h) '2s

;9
(define (reckless strategy)
  (lambda (hand dealer-up-card)
    (cond ((strategy hand dealer-up-card) #t)
          ((and (not (strategy hand dealer-up-card)) (strategy (butlast hand) dealer-up-card)) #t)
          (else #f))))

(check-expect equal? ((reckless stop-at-17) '(ad 6d) '3s) #t)
(check-expect equal? ((reckless stop-at-17) '(ad 6d 2s) '3s) #f)

(twenty-one (reckless dealer-sensitive))
(twenty-one valentine)