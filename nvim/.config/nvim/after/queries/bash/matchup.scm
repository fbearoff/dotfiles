; inherits: bash
(while_statement
  ("while")? @open.while
  ("until")? @open.while
  (do_group
    "done" @close.while)) @scope.while

(for_statement
  ("for")? @open.for
  ("select")? @open.for
  (do_group
    "done" @close.for)) @scope.for

(if_statement
  "if" @open.if
  "fi" @close.if) @scope.if

(else_clause
  "else" @mid.if.1)

(elif_clause
  "elif" @mid.if.2)

((word) @mid.if.3 (#eq? @mid.if.3 "break"))
((word) @mid.if.4 (#eq? @mid.if.4 "continue"))

(case_statement
  "case" @open.case
  (case_item) @mid.case.1
  "esac" @close.case) @scope.case
