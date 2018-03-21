; COMMAND-LINE: --rewrite-rules
;;; From a verification condition generated by why3. The original program
;; can be found at http://toccata.lri.fr/gallery/vstte10_max_sum.en.html .
;; The problem has been modified by doubling the size of the arrays
;; (* **)
;;    VSTTE'10 competition http://www.macs.hw.ac.uk/vstte10/Competition.html **)
;;    Problem 1: maximum /\ sum of an array **)

;;    Author: Jean-Christophe Filliatre (CNRS) **)
;;    Tool:   Why3 (see http://why3.lri.fr/) **)
;; *\) **)

;; Particularly the assertion in the test case that the sum s = 90

;;; this is a prelude for CVC4
(set-logic AUFNIRA)
;;; this is a prelude for CVC4 integer arithmetic
(declare-sort uni 0)

(declare-sort deco 0)

(declare-sort ty 0)

(declare-fun sort (ty uni) deco)

(declare-fun int () ty)

(declare-fun real () ty)

(declare-fun bool () ty)

(declare-fun True () uni)

(declare-fun False () uni)

(declare-fun match_bool (deco deco deco) uni)

;; match_bool_True
  (assert
  (forall ((a ty))
  (forall ((z uni) (z1 uni))
  (= (sort a (match_bool (sort bool True) (sort a z) (sort a z1))) (sort a z)))))

;; match_bool_False
  (assert
  (forall ((a ty))
  (forall ((z uni) (z1 uni))
  (= (sort a (match_bool (sort bool False) (sort a z) (sort a z1))) (sort a
                                                                    z1)))))

(declare-fun index_bool (deco) Int)

;; index_bool_True
  (assert (= (index_bool (sort bool True)) 0))

;; index_bool_False
  (assert (= (index_bool (sort bool False)) 1))

;; bool_inversion
  (assert
  (forall ((u uni))
  (or (= (sort bool u) (sort bool True)) (= (sort bool u) (sort bool False)))))

(declare-fun tuple0 () ty)

(declare-fun Tuple0 () uni)

;; tuple0_inversion
  (assert (forall ((u uni)) (= (sort tuple0 u) (sort tuple0 Tuple0))))

;; CompatOrderMult
  (assert
  (forall ((x Int) (y Int) (z Int))
  (=> (<= x y) (=> (<= 0 z) (<= (* x z) (* y z))))))

(declare-fun ref (ty) ty)

(declare-fun mk_ref (deco) uni)

(declare-fun contents (deco) uni)

;; contents_def
  (assert
  (forall ((a ty))
  (forall ((u uni))
  (= (sort a (contents (sort (ref a) (mk_ref (sort a u))))) (sort a u)))))

;; ref_inversion
  (assert
  (forall ((a ty))
  (forall ((u uni))
  (= (sort (ref a) u) (sort (ref a)
                      (mk_ref (sort a (contents (sort (ref a) u)))))))))

(declare-fun map (ty ty) ty)

(declare-fun get (deco deco) uni)

(declare-fun set (deco deco deco) uni)

;; Select_eq
  (assert
  (forall ((m (Array Int Int)))
  (forall ((a1 Int) (a2 Int))
  (forall ((b Int))
  (! (=> (= a1 a2) (= (select (store m a1 b) a2) b)) :pattern ((select (store m a1 b) a2)) )))))

;; Select_eq
  (assert
  (forall ((a ty) (b ty))
  (forall ((m uni))
  (forall ((a1 uni) (a2 uni))
  (forall ((b1 uni))
  (! (=> (= (sort a a1) (sort a a2))
     (= (sort b
        (get
        (sort (map a b) (set (sort (map a b) m) (sort a a1) (sort b b1)))
        (sort a a2))) (sort b b1))) :pattern ((sort b
                                              (get
                                              (sort (map a b)
                                              (set (sort (map a b) m)
                                              (sort a a1) (sort b b1)))
                                              (sort a a2)))) ))))))

;; Select_neq
  (assert
  (forall ((m (Array Int Int)))
  (forall ((a1 Int) (a2 Int))
  (forall ((b Int))
  (! (=> (not (= a1 a2)) (= (select (store m a1 b) a2) (select m a2))) :pattern ((select (store m a1 b) a2)) )))))

;; Select_neq
  (assert
  (forall ((a ty) (b ty))
  (forall ((m uni))
  (forall ((a1 uni) (a2 uni))
  (forall ((b1 uni))
  (! (=> (not (= (sort a a1) (sort a a2)))
     (= (sort b
        (get
        (sort (map a b) (set (sort (map a b) m) (sort a a1) (sort b b1)))
        (sort a a2))) (sort b (get (sort (map a b) m) (sort a a2))))) :pattern (
  (sort b
  (get (sort (map a b) (set (sort (map a b) m) (sort a a1) (sort b b1)))
  (sort a a2)))) ))))))

(declare-fun const1 (deco) uni)

(declare-fun const2 (Int) (Array Int Int))

;; Const
  (assert (forall ((b Int) (a Int)) (= (select (const2 b) a) b)))

;; Const
  (assert
  (forall ((a ty) (b ty))
  (forall ((b1 uni) (a1 uni))
  (= (sort b (get (sort (map a b) (const1 (sort b b1))) (sort a a1))) 
  (sort b b1)))))

(declare-sort array 1)

(declare-fun array1 (ty) ty)

(declare-fun mk_array (Int deco) uni)

(declare-fun mk_array1 (Int (Array Int Int)) (array Int))

(declare-fun length (deco) Int)

(declare-fun t2tb ((array Int)) uni)

(declare-fun tb2t (deco) (array Int))

;; BridgeL
  (assert
  (forall ((i (array Int)))
  (! (= (tb2t (sort (array1 int) (t2tb i))) i) :pattern ((sort (array1 int)
                                                         (t2tb i))) )))

;; BridgeR
  (assert
  (forall ((j uni))
  (! (= (sort (array1 int) (t2tb (tb2t (sort (array1 int) j)))) (sort
                                                                (array1 int)
                                                                j)) :pattern (
  (sort (array1 int) (t2tb (tb2t (sort (array1 int) j))))) )))

;; length_def
  (assert
  (forall ((u Int) (u1 (Array Int Int)))
  (= (length (sort (array1 int) (t2tb (mk_array1 u u1)))) u)))

;; length_def
  (assert
  (forall ((a ty))
  (forall ((u Int) (u1 uni))
  (= (length (sort (array1 a) (mk_array u (sort (map int a) u1)))) u))))

(declare-fun elts (deco) uni)

(declare-fun t2tb1 ((Array Int Int)) uni)

(declare-fun tb2t1 (deco) (Array Int Int))

;; BridgeL
  (assert
  (forall ((i (Array Int Int)))
  (! (= (tb2t1 (sort (map int int) (t2tb1 i))) i) :pattern ((sort
                                                            (map int int)
                                                            (t2tb1 i))) )))

;; BridgeR
  (assert
  (forall ((j uni))
  (! (= (sort (map int int) (t2tb1 (tb2t1 (sort (map int int) j)))) (sort
                                                                    (map 
                                                                    int 
                                                                    int) j)) :pattern (
  (sort (map int int) (t2tb1 (tb2t1 (sort (map int int) j))))) )))

;; elts_def
  (assert
  (forall ((u Int) (u1 (Array Int Int)))
  (= (tb2t1
     (sort (map int int) (elts (sort (array1 int) (t2tb (mk_array1 u u1)))))) u1)))

;; elts_def
  (assert
  (forall ((a ty))
  (forall ((u Int) (u1 uni))
  (= (sort (map int a)
     (elts (sort (array1 a) (mk_array u (sort (map int a) u1))))) (sort
                                                                  (map int a)
                                                                  u1)))))

;; array_inversion
  (assert
  (forall ((u (array Int)))
  (= u (mk_array1 (length (sort (array1 int) (t2tb u)))
       (tb2t1 (sort (map int int) (elts (sort (array1 int) (t2tb u)))))))))

;; array_inversion
  (assert
  (forall ((a ty))
  (forall ((u uni))
  (= (sort (array1 a) u) (sort (array1 a)
                         (mk_array (length (sort (array1 a) u))
                         (sort (map int a) (elts (sort (array1 a) u)))))))))

(declare-fun get1 (deco Int) uni)

(declare-fun t2tb2 (Int) uni)

(declare-fun tb2t2 (deco) Int)

;; BridgeL
  (assert
  (forall ((i Int))
  (! (= (tb2t2 (sort int (t2tb2 i))) i) :pattern ((sort int (t2tb2 i))) )))

;; BridgeR
  (assert
  (forall ((j uni))
  (! (= (sort int (t2tb2 (tb2t2 (sort int j)))) (sort int j)) :pattern (
  (sort int (t2tb2 (tb2t2 (sort int j))))) )))

;; get_def
  (assert
  (forall ((a (array Int)) (i Int))
  (= (tb2t2 (sort int (get1 (sort (array1 int) (t2tb a)) i))) (select 
  (tb2t1 (sort (map int int) (elts (sort (array1 int) (t2tb a))))) i))))

;; get_def
  (assert
  (forall ((a ty))
  (forall ((a1 uni) (i Int))
  (= (sort a (get1 (sort (array1 a) a1) i)) (sort a
                                            (get
                                            (sort (map int a)
                                            (elts (sort (array1 a) a1)))
                                            (sort int (t2tb2 i))))))))

(declare-fun set1 (deco Int deco) uni)

;; set_def
  (assert
  (forall ((a (array Int)) (i Int) (v Int))
  (= (tb2t
     (sort (array1 int)
     (set1 (sort (array1 int) (t2tb a)) i (sort int (t2tb2 v))))) (mk_array1
                                                                  (length
                                                                  (sort
                                                                  (array1
                                                                  int)
                                                                  (t2tb a)))
                                                                  (store 
                                                                  (tb2t1
                                                                  (sort
                                                                  (map 
                                                                  int 
                                                                  int)
                                                                  (elts
                                                                  (sort
                                                                  (array1
                                                                  int)
                                                                  (t2tb a))))) i v)))))

;; set_def
  (assert
  (forall ((a ty))
  (forall ((a1 uni) (i Int) (v uni))
  (= (sort (array1 a) (set1 (sort (array1 a) a1) i (sort a v))) (sort
                                                                (array1 a)
                                                                (mk_array
                                                                (length
                                                                (sort
                                                                (array1 a)
                                                                a1))
                                                                (sort
                                                                (map int a)
                                                                (set
                                                                (sort
                                                                (map int a)
                                                                (elts
                                                                (sort
                                                                (array1 a)
                                                                a1)))
                                                                (sort 
                                                                int
                                                                (t2tb2 i))
                                                                (sort a v)))))))))

(declare-fun make (Int deco) uni)

;; make_def
  (assert
  (forall ((n Int) (v Int))
  (= (tb2t (sort (array1 int) (make n (sort int (t2tb2 v))))) (mk_array1 n
                                                              (const2 v)))))

;; make_def
  (assert
  (forall ((a ty))
  (forall ((n Int) (v uni))
  (= (sort (array1 a) (make n (sort a v))) (sort (array1 a)
                                           (mk_array n
                                           (sort (map int a)
                                           (const1 (sort a v)))))))))

(declare-fun sum ((Array Int Int) Int Int) Int)

;; Sum_def_empty
  (assert
  (forall ((c (Array Int Int)) (i Int) (j Int))
  (=> (<= j i) (= (sum c i j) 0))))

;; Sum_def_non_empty
  (assert
  (forall ((c (Array Int Int)) (i Int) (j Int))
  (=> (< i j) (= (sum c i j) (+ (select c i) (sum c (+ i 1) j))))))

;; Sum_right_extension
  (assert
  (forall ((c (Array Int Int)) (i Int) (j Int))
  (=> (< i j) (= (sum c i j) (+ (sum c i (- j 1)) (select c (- j 1)))))))

;; Sum_transitivity
  (assert
  (forall ((c (Array Int Int)) (i Int) (k Int) (j Int))
  (=> (and (<= i k) (<= k j)) (= (sum c i j) (+ (sum c i k) (sum c k j))))))

;; Sum_eq
  (assert
  (forall ((c1 (Array Int Int)) (c2 (Array Int Int)) (i Int) (j Int))
  (=>
  (forall ((k Int))
  (=> (and (<= i k) (< k j)) (= (select c1 k) (select c2 k))))
  (= (sum c1 i j) (sum c2 i j)))))

(declare-fun sum1 ((array Int) Int Int) Int)

;; sum_def
  (assert
  (forall ((a (array Int)) (l Int) (h Int))
  (= (sum1 a l h) (sum
                  (tb2t1
                  (sort (map int int) (elts (sort (array1 int) (t2tb a))))) l
                  h))))

(declare-fun is_max ((array Int) Int Int Int) Bool)

;; is_max_def
  (assert
  (forall ((a (array Int)) (l Int) (h Int) (m Int))
  (and
  (=> (is_max a l h m)
  (and
  (forall ((k Int))
  (=> (and (<= l k) (< k h))
  (<= (tb2t2 (sort int (get1 (sort (array1 int) (t2tb a)) k))) m)))
  (or (and (<= h l) (= m 0))
  (and (< l h)
  (exists ((k Int))
  (and (and (<= l k) (< k h))
  (= m (tb2t2 (sort int (get1 (sort (array1 int) (t2tb a)) k))))))))))
  (=>
  (and
  (forall ((k Int))
  (=> (and (<= l k) (< k h))
  (<= (tb2t2 (sort int (get1 (sort (array1 int) (t2tb a)) k))) m)))
  (or (and (<= h l) (= m 0))
  (and (< l h)
  (exists ((k Int))
  (and (and (<= l k) (< k h))
  (= m (tb2t2 (sort int (get1 (sort (array1 int) (t2tb a)) k))))))))) (is_max
  a l h m)))))

(assert
;; WP_parameter_test_case
 ;; File "vstte10_max_sum/../vstte10_max_sum.mlw", line 63, characters 6-15
  (not
  (=> (<= 0 20)
  (=> (and (<= 0 0) (< 0 20))
  (forall ((a (Array Int Int)))
  (=> (= a (store (const2 0) 0 9))
  (=> (and (<= 0 1) (< 1 20))
  (forall ((a1 (Array Int Int)))
  (=> (= a1 (store a 1 5))
  (=> (and (<= 0 2) (< 2 20))
  (forall ((a2 (Array Int Int)))
  (=> (= a2 (store a1 2 0))
  (=> (and (<= 0 3) (< 3 20))
  (forall ((a3 (Array Int Int)))
  (=> (= a3 (store a2 3 2))
  (=> (and (<= 0 4) (< 4 20))
  (forall ((a4 (Array Int Int)))
  (=> (= a4 (store a3 4 7))
  (=> (and (<= 0 5) (< 5 20))
  (forall ((a5 (Array Int Int)))
  (=> (= a5 (store a4 5 3))
  (=> (and (<= 0 6) (< 6 20))
  (forall ((a6 (Array Int Int)))
  (=> (= a6 (store a5 6 2))
  (=> (and (<= 0 7) (< 7 20))
  (forall ((a7 (Array Int Int)))
  (=> (= a7 (store a6 7 1))
  (=> (and (<= 0 8) (< 8 20))
  (forall ((a8 (Array Int Int)))
  (=> (= a8 (store a7 8 10))
  (=> (and (<= 0 9) (< 9 20))
  (forall ((a9 (Array Int Int)))
  (=> (= a9 (store a8 9 6))
  (=> (and (<= 0 10) (< 10 20))
  (forall ((a10 (Array Int Int)))
  (=> (= a10 (store a9 10 9))
  (=> (and (<= 0 11) (< 11 20))
  (forall ((a11 (Array Int Int)))
  (=> (= a11 (store a10 11 5))
  (=> (and (<= 0 12) (< 12 20))
  (forall ((a12 (Array Int Int)))
  (=> (= a12 (store a11 12 0))
  (=> (and (<= 0 13) (< 13 20))
  (forall ((a13 (Array Int Int)))
  (=> (= a13 (store a12 13 2))
  (=> (and (<= 0 14) (< 14 20))
  (forall ((a14 (Array Int Int)))
  (=> (= a14 (store a13 14 7))
  (=> (and (<= 0 15) (< 15 20))
  (forall ((a15 (Array Int Int)))
  (=> (= a15 (store a14 15 3))
  (=> (and (<= 0 16) (< 16 20))
  (forall ((a16 (Array Int Int)))
  (=> (= a16 (store a15 16 2))
  (=> (and (<= 0 17) (< 17 20))
  (forall ((a17 (Array Int Int)))
  (=> (= a17 (store a16 17 1))
  (=> (and (<= 0 18) (< 18 20))
  (forall ((a18 (Array Int Int)))
  (=> (= a18 (store a17 18 10))
  (=> (and (<= 0 19) (< 19 20))
  (forall ((a19 (Array Int Int)))
  (=> (= a19 (store a18 19 6))
  (=>
  (and (<= 0 20)
  (forall ((i Int)) (=> (and (<= 0 i) (< i 20)) (<= 0 (select a19 i)))))
  (forall ((result Int) (result1 Int))
  (=>
  (and (= result (sum a19 0 20))
  (and (is_max (mk_array1 20 a19) 0 20 result1) (<= result (* 20 result1))))
  (= result 90)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
(check-sat)

