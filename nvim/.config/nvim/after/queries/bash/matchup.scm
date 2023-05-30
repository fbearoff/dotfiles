; inherits: bash
(while_statement
  ("while")? @open.while
  ("until")? @open.while
  (do_group
    "done" @close.while)) @scope.while

(for_statement
  "for" @open.for
  (do_group
    "done" @close.for)) @scope.for

(elif_clause
  "elif" @mid.if.2)

(case_statement
  "case" @open.case
  (case_item) @mid.case.1
  "esac" @close.case) @scope.case
