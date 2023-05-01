; extends
;native pipe
(pipe
  left: (_)
  right: (_) @pipe.inner)

; magrittr pipe
((binary
  operator: (special) @_start
  right: (_) @pipe.inner)
 (#make-range! "pipe.outer" @_start @pipe.inner))
