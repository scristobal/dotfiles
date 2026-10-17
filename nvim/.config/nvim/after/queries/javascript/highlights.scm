; extends

(formal_parameters (identifier) @variable.parameter.declaration
  (#set! priority 110))

(formal_parameters (assignment_pattern left: (identifier) @variable.parameter.declaration)
  (#set! priority 110))
