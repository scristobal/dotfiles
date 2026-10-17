; extends

(assignment left: (identifier) @variable.declaration
  (#set! priority 110))

(assignment left: (pattern_list (identifier) @variable.declaration)
  (#set! priority 110))

(parameters (identifier) @variable.parameter.declaration
  (#set! priority 110))

(default_parameter name: (identifier) @variable.parameter.declaration
  (#set! priority 110))

(typed_parameter (identifier) @variable.parameter.declaration
  (#set! priority 110))

(typed_default_parameter name: (identifier) @variable.parameter.declaration
  (#set! priority 110))

(for_statement left: (identifier) @variable.declaration
  (#set! priority 110))

(class_definition name: (identifier) @type.definition
  (#set! priority 110))

(assignment left: (identifier) @function.definition right: (lambda)
  (#set! priority 120))
