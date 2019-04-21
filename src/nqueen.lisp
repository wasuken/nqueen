(in-package #:nqueen)

(defun create-map (map-x map-y)
  (mapcar #'(lambda (y) (mapcan #'(lambda (y) (list 0)) (mylib:range 1 map-y)))
		  (mylib:range 1 map-x)))

(defun get-map (x y map)
  (nth x (nth y map)))

(defun map-positionp (x y map)
  (cond ((and (mylib:rangep 0 (length (car map)) x)
			  (mylib:rangep 0 (length map) y))
		 (nth x (nth y map)))))

(defun set-map (x y value map)
  (cond ((map-positionp x y map)
		 (setf (nth y (nth x map)) value))))

(defun put-queen (x y map)
  ;; ここらへん、マクロでまとめられそう。
  (loop for i from x
  	 for j from y
	 until (< (- (length map) 1) j)
	 until (< (- (length (nth 0 map)) 1) i)
	 do (set-map i j 1 map))
  ;; 斜め下の処理
  (loop for i from (- 1 x)
  	 for j from y
	 until (< (- (length map) 1) j)
	 until (< (- (length (nth 0 map)) 1) i)
	 do (set-map i j 1 map))
  ;; (loop for i from x
  ;; 	 for j from y
  ;; 	 until (< (- (length map) 1) j)
  ;; 	 until (< (- (length (nth 0 map)) 1) i)
  ;; 	 do (set-map (- (length map) (+ i 1)) j 1 map)
  ;; 	 do (format t "~%x:~A,y:~A~%" (- (- (length map) (+ i 1)) ) j))

  (loop for i from y
  	 until (< (- (length (nth 0 map)) 1) i)
  	 do (set-map x i 1 map))
  (loop for i from x
  	 until (< (- (length map) 1) i)
  	 do (set-map i y 1 map))
  (set-map x y 2 map))

(defun find-pos (value list)
  (labels ((f (v l n)
			 (print l)
			 (cond ((null l)
					-1)
				   ((= value (car l))
					n)
				   (t (f v (cdr l) (1+ n))))))
	(f value list 0)))

(defun find-value-in-map (value map)
  (let ((result '()))
	(loop for x in map
	   for i from 0
	   when (find value x) do (when (null result) (setf result (list (find-pos value x) i))))
	result))

(defparameter *map* (create-map 9 9))

(defun main-loop ()
  (loop until (null (find-value-in-map 0 *map*))
	 do (put-queen (cadr (find-value-in-map 0 *map*))
				   (car (find-value-in-map 0 *map*))
				   *map*)
	 do (print "====================================")
	 do (loop for x in *map*
		   do (print x))
	 do (print "====================================")))
