; extends

([
  (struct_item name: (type_identifier) @type.definition)
  (enum_item name: (type_identifier) @type.definition)
  (trait_item name: (type_identifier) @type.definition)
  (type_item name: (type_identifier) @type.definition)
] (#set! priority 110))

(let_declaration pattern: (identifier) @variable.declaration
  (#set! priority 110))

(let_declaration pattern: (tuple_pattern (identifier) @variable.declaration)
  (#set! priority 110))

; Bindings in `if let Ok(value)`, `match Some(value)` and similar patterns.
(tuple_struct_pattern type: (_) (identifier) @variable.declaration
  (#not-lua-match? @variable.declaration "^[A-Z][A-Z%d_]*$")
  (#set! priority 110))

(let_declaration pattern: (struct_pattern
  (field_pattern (shorthand_field_identifier) @variable.declaration))
  (#set! priority 110))

(parameter pattern: (identifier) @variable.parameter.declaration
  (#set! priority 110))

(parameter pattern: (ref_pattern (identifier) @variable.parameter.declaration)
  (#set! priority 110))

(closure_parameters (identifier) @variable.parameter.declaration
  (#set! priority 110))

(for_expression pattern: (identifier) @variable.declaration
  (#set! priority 110))

(let_condition pattern: (identifier) @variable.declaration
  (#set! priority 110))

(let_declaration pattern: (identifier) @function.definition
  value: (closure_expression)
  (#set! priority 120))
