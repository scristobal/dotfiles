; extends

(directive name: (_) @variable.declaration
  (#set! priority 110))

(param name: (_) @variable.declaration
  (#set! priority 110))

; Metric names are references, rather than function definitions.
(metric_id name: (_) @variable
  (#set! priority 110))
