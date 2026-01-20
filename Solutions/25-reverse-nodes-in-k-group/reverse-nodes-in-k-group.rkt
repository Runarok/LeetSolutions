(define/contract (reverse-k-group head k)
  (-> (or/c list-node? #f) exact-integer? (or/c list-node? #f))

  ;; ------------------------------------------------------------
  ;; Helper: return the k-th node starting from `node`
  ;; If fewer than k nodes remain, return #f
  ;; ------------------------------------------------------------
  (define (get-kth node k)
    (let loop ([curr node] [count k])
      (cond
        [(= count 0) curr]
        [(not curr) #f]
        [else (loop (list-node-next curr) (sub1 count))])))

  ;; ------------------------------------------------------------
  ;; Dummy node to simplify head handling
  ;; ------------------------------------------------------------
  (define dummy (make-list-node 0))
  (set-list-node-next! dummy head)

  ;; ------------------------------------------------------------
  ;; group-prev always points to node BEFORE the group
  ;; ------------------------------------------------------------
  (let loop ([group-prev dummy])

    ;; Find the k-th node after group-prev
    (define kth (get-kth group-prev k))

    ;; If fewer than k nodes remain, we are done
    (if (not kth)
        (list-node-next dummy)

        (let* ([group-next (list-node-next kth)]
               [prev group-next]
               [curr (list-node-next group-prev)])

          ;; --------------------------------------------
          ;; Reverse k nodes
          ;; --------------------------------------------
          (let rev-loop ()
            (when (not (eq? curr group-next))
              (define tmp (list-node-next curr))
              (set-list-node-next! curr prev)
              (set! prev curr)
              (set! curr tmp)
              (rev-loop)))

          ;; --------------------------------------------
          ;; Reconnect reversed group
          ;; --------------------------------------------
          (define old-start (list-node-next group-prev))
          (set-list-node-next! group-prev kth)

          ;; Move to next group
          (loop old-start)))))
