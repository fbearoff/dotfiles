; extends
;native pipe
((binary_operator
    lhs: (_)
    "|>" @_start
    rhs: (_) @pipe.inner)
(#make-range! "pipe.outer" @_start @pipe.inner))
