; COMMAND-LINE: --incremental --no-produce-proofs
; EXPECT: sat
; EXPECT: sat
; EXPECT: sat
; EXPECT: sat
; EXPECT: unsat
; EXPECT: sat
(set-logic QF_LRA)
(declare-fun x0 () Real)
(declare-fun x1 () Real)
(declare-fun x2 () Real)
(assert (or (= (+ (* 25 x1 ) (* (- 35) x1 ) ) 3) (> (+ (* 31 x1 ) (* (- 25) x2 ) (* 24 x1 ) (* (- 37) x2 ) ) 37) ))
(assert (or (= (+ (* (- 18) x1 ) (* (- 42) x0 ) (* (- 41) x2 ) ) 18) (= (+ (* (- 34) x2 ) (* 14 x0 ) (* 33 x0 ) (* (- 40) x2 ) ) (- 34)) ))
(assert (or (>= (+ (* (- 45) x1 ) (* (- 21) x1 ) ) 30) (>= (+ (* 6 x2 ) (* (- 32) x0 ) (* (- 38) x0 ) ) 4) ))
(assert (or (not (< (+ (* (- 39) x2 ) (* (- 47) x2 ) ) 23)) (>= (+ (* 12 x2 ) (* 32 x1 ) (* (- 46) x2 ) ) 13) (not (= (+ (* 48 x2 ) (* 26 x1 ) (* 45 x2 ) ) (- 10))) ))
(check-sat)
(push 1)
(assert (or (not (<= (+ (* (- 34) x2 ) (* (- 24) x1 ) ) 39)) (<= (+ (* 34 x1 ) (* (- 35) x0 ) (* (- 13) x1 ) (* 2 x2 ) ) (- 2)) ))
(check-sat)
(push 1)
(assert (or (not (<= (+ (* (- 12) x0 ) (* 37 x1 ) (* (- 30) x0 ) ) (- 43))) (> (+ (* 28 x0 ) (* (- 49) x1 ) ) (- 22)) ))
(check-sat)
(pop 1)
(assert (or (not (>= (+ (* 49 x1 ) (* (- 19) x2 ) ) (- 4))) (not (< (+ (* (- 50) x2 ) (* (- 18) x1 ) ) (- 11))) (not (< (+ (* 43 x0 ) (* 11 x1 ) (* 26 x0 ) (* (- 46) x2 ) ) (- 11))) ))
(assert (or (< (+ (* 38 x0 ) (* (- 19) x1 ) ) (- 31)) (= (+ (* (- 15) x0 ) (* 28 x2 ) (* 9 x2 ) ) (- 43)) ))
(assert (or (>= (+ (* (- 4) x0 ) (* 20 x1 ) (* (- 30) x1 ) (* 17 x0 ) ) (- 13)) (< (+ (* 6 x0 ) (* (- 22) x2 ) (* (- 37) x1 ) (* (- 1) x2 ) ) (- 50)) ))
(assert (or (not (< (+ (* 33 x1 ) (* (- 30) x2 ) (* (- 18) x1 ) ) (- 32))) (> (+ (* 26 x0 ) (* (- 21) x1 ) ) 46) ))
(assert (or (not (<= (+ (* 3 x0 ) (* (- 19) x2 ) (* (- 50) x1 ) (* 31 x2 ) ) 23)) (= (+ (* 46 x0 ) (* 47 x1 ) (* (- 38) x2 ) (* 32 x0 ) ) 30) (<= (+ (* (- 44) x1 ) (* 32 x0 ) (* 29 x1 ) ) 19) ))
(assert (not (= (+ (* (- 21) x1 ) (* (- 4) x0 ) (* 38 x1 ) (* 17 x1 ) ) 35)) )
(assert (or (<= (+ (* (- 42) x1 ) (* 8 x0 ) (* 37 x1 ) ) (- 33)) (not (> (+ (* 40 x0 ) (* 41 x0 ) (* 4 x1 ) (* (- 17) x2 ) ) 33)) ))
(assert (or (not (<= (+ (* (- 26) x2 ) (* 25 x0 ) (* 42 x0 ) (* 40 x2 ) ) 2)) (> (+ (* (- 33) x2 ) (* 18 x2 ) ) 47) ))
(check-sat)
(push 1)
(assert (or (not (>= (+ (* 13 x2 ) (* (- 16) x2 ) (* (- 18) x0 ) ) (- 15))) (not (< (+ (* 1 x0 ) (* 0 x2 ) (* (- 3) x2 ) (* 43 x0 ) ) 30)) (not (> (+ (* 10 x2 ) (* 36 x1 ) ) (- 17))) ))
(assert (or (not (< (+ (* (- 34) x0 ) (* (- 19) x1 ) (* 31 x0 ) (* 11 x1 ) ) 34)) (= (+ (* (- 45) x2 ) (* 48 x2 ) (* (- 43) x1 ) ) (- 44)) (>= (+ (* 16 x2 ) (* 10 x2 ) (* (- 21) x1 ) ) 23) ))
(check-sat)
(pop 1)
(assert (or (< (+ (* 27 x1 ) (* 6 x2 ) ) 13) (not (<= (+ (* 11 x1 ) (* 19 x0 ) (* (- 41) x0 ) (* (- 29) x1 ) ) (- 6))) (not (= (+ (* (- 16) x2 ) (* (- 8) x1 ) ) 2)) ))
(assert (or (= (+ (* (- 48) x1 ) (* (- 26) x1 ) (* (- 30) x0 ) ) 39) (>= (+ (* 21 x1 ) (* 25 x2 ) (* (- 35) x1 ) ) (- 2)) (= (+ (* (- 4) x1 ) (* 46 x0 ) (* 23 x2 ) ) 38) ))
(check-sat)
