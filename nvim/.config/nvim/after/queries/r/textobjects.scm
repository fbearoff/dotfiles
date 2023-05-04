; extends
;native pipe
((pipe
    left: (_)
    "|>" @_start
    right: (_) @pipe.inner)
(#make-range! "pipe.outer" @_start @pipe.inner))

; magrittr pipe
((binary
  operator: (special) @_start
  right: (_) @pipe.inner)
 (#make-range! "pipe.outer" @_start @pipe.inner))

;assignments
(left_assignment
  name: (_) @assignment.lhs
  value: (_) @assignment.rhs)

(right_assignment
  value: (_) @assignment.rhs
  name: (_) @assignment.lhs)

(equals_assignment
  name: (_) @assignment.lhs
  value: (_) @assignment.rhs)
