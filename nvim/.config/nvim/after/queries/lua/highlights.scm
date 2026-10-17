; extends

(variable_declaration
  (assignment_statement
    (variable_list name: (identifier) @variable.declaration))
  (#set! priority 110))

(variable_declaration
  (variable_list name: (identifier) @variable.declaration)
  (#set! priority 110))

(parameters (identifier) @variable.parameter.declaration
  (#set! priority 110))

(for_numeric_clause name: (identifier) @variable.declaration
  (#set! priority 110))

(for_generic_clause (variable_list (identifier) @variable.declaration)
  (#set! priority 110))

; A function-valued binding is a function definition, not a blue variable.
(assignment_statement
  (variable_list . name: (identifier) @function.definition)
  (expression_list . value: (function_definition))
  (#set! priority 120))
