; extends
; C declaration queries are inherited from c/highlights.scm.

(parameter_declaration declarator: (reference_declarator
  (identifier) @variable.parameter.declaration)
  (#set! priority 110))

(init_declarator declarator: (reference_declarator
  (identifier) @variable.declaration)
  (#set! priority 110))

(structured_binding_declarator (identifier) @variable.declaration
  (#set! priority 110))

(class_specifier name: (type_identifier) @type.definition
  body: (field_declaration_list)
  (#set! priority 110))

(init_declarator declarator: (identifier) @function.definition
  value: (lambda_expression)
  (#set! priority 120))
