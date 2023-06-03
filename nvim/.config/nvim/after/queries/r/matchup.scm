; inherits: quote

; if loops broken
((if
   "if" @open.if
   ("else" @mid.if.1)?
   . alternative: (if "if" @mid.if.2)?
   alternative: (if "else" @mid.if.3))?) @scope.if

(for
  ("for" @open.loop)) @scope.loop

(while
  ("while" @open.loop)) @scope.loop

(repeat
  ("repeat" @open.loop)) @scope.loop

(break) @mid.loop.2
(next) @mid.loop.3

(function_definition
  ("function" @open.function)
  (brace_list
    (call
      (identifier) @mid.function.1) (#eq? @mid.function.1 "return"))?) @scope.function
