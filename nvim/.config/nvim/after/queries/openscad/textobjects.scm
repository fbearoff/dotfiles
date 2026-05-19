; comments
(line_comment) @comment.outer

; function
(function_item
  "function"
  _+ @function.inner
) @function.outer

; module
(module_item
  body: (_)+ @function.inner
) @function.outer

; parameter
((parameter
  .
  (_) @parameter.inner )
  .
  ","?)

(list
  "["?
  ((_) @parameter.inner
  .
  ","? ))

 (arguments
  ((_) @parameter.inner
  .
  ","?))

; assignment
(assignment
  name: (_) @assignment.lhs
  value: (_) @assignment.inner @assignment.rhs) @assignment.outer
