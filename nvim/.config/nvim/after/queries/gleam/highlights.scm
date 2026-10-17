; extends

(let pattern: (identifier) @variable.declaration
  (#set! priority 110))

(function_parameter name: (identifier) @variable.parameter.declaration
  (#set! priority 110))

; The upstream query also uses @function for these references.
(binary_expression operator: "|>" right: (identifier) @function.call
  (#set! priority 120))

(unqualified_import name: (identifier) @variable.declaration
  (#set! priority 110))
