; inherits: quote

(if
  "if" @open.if
  alternative: "else" @mid.if.1) @scope.if

(for
  ("for" @open.loop)) @scope.loop

(while
  ("while" @open.loop)) @scope.loop

(break) @mid.loop.2
(next) @mid.loop.3
