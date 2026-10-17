; extends
; Shared by JavaScript, TypeScript, JSX and TSX.

(variable_declarator name: (identifier) @variable.declaration
  (#set! priority 110))

(variable_declarator name: (array_pattern (identifier) @variable.declaration)
  (#set! priority 110))

(variable_declarator name: (object_pattern
  (shorthand_property_identifier_pattern) @variable.declaration)
  (#set! priority 110))

(variable_declarator name: (object_pattern
  (pair_pattern value: (identifier) @variable.declaration))
  (#set! priority 110))

(arrow_function parameter: (identifier) @variable.parameter.declaration
  (#set! priority 110))

(catch_clause parameter: (identifier) @variable.declaration
  (#set! priority 110))

(class_declaration name: (_) @type.definition
  (#set! priority 110))

(variable_declarator name: (identifier) @function.definition
  value: [(arrow_function) (function_expression)]
  (#set! priority 120))
