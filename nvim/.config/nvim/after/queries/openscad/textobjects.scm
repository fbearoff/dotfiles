; #offset! doesn't seem to work on current treesitter-textobjects

; quotes
((_
 value: (string) @string.inner @string.outer)
(#offset! @string.inner 0 1 0 -1))

; comments
(line_comment) @comment.outer
((line_comment
   .
   ("//")) @comment.inner (#offset! @comment.inner 0 3 0 0)) @comment.inner
