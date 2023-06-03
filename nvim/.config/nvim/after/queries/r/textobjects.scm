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

;binary blocks
(binary) @block.outer
