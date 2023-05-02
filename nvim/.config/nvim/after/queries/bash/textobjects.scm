; extends

; command
(command) @command.inner

(pipeline
  "|" @_start
  (command) @command.inner
(#make-range! "command.outer" @_start @command.inner))
