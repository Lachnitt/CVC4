; COMMAND-LINE: --no-check-unsat-cores
(set-logic QF_UFNIA)
(set-info :status unsat)
(declare-fun c (Int) Int)
(declare-fun a (Int) Int)
(declare-fun b (Int) Int)
(assert (> (a 0) 0))
(assert (= (c 0) (* (a 0) (b 0))))
(assert (not (= (b 0) (div (c 0) (a 0)))))
(check-sat)
