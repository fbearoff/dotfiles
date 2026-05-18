; #offset! doesn't seem to work on current treesitter-textobjects

; comments
(line_comment) @comment.outer
((line_comment
   .
   ("//")) @comment.inner (#offset! @comment.inner 0 3 0 0)) @comment.inner

; function
(function_item
  "function"
  _+ @function.inner
) @function.outer
