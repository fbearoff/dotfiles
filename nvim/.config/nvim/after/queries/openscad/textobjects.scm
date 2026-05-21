; comments
(line_comment) @comment.outer

(block_comment) @comment.outer

; functions
(function_item
  "function"
  _+ @function.inner) @function.outer

(module_item
  body: (_)+ @function.inner) @function.outer

; parameters
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

; assignments
(assignment) @assignment.outer

(assignment
  value: (_) @assignment.inner @assignment.rhs)

(assignment
  name: (_) @assignment.inner @assignment.lhs)

; loops
(for_block
  body: (
    (_)+ @loop.inner)) @loop.outer

(intersection_for_block
  body: (
    (_)+ @loop.inner)) @loop.outer

; conditionals
(if_block
 condition: (_) @conditional.inner) @conditional.outer

(if_block
  consequence: (_) @conditional.inner) @conditional.outer

(if_block
  alternative: (_)? @conditional.inner) @conditional.outer
