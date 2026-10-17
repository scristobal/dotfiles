; extends

(init_declarator declarator: (identifier) @variable.declaration
  (#set! priority 110))

(declaration declarator: (identifier) @variable.declaration
  (#set! priority 110))

(declaration declarator: (pointer_declarator
  declarator: (identifier) @variable.declaration)
  (#set! priority 110))

(init_declarator declarator: (pointer_declarator
  declarator: (identifier) @variable.declaration)
  (#set! priority 110))

(parameter_declaration declarator: (identifier) @variable.parameter.declaration
  (#set! priority 110))

(parameter_declaration declarator: (pointer_declarator
  declarator: (identifier) @variable.parameter.declaration)
  (#set! priority 110))

(struct_specifier name: (type_identifier) @type.definition
  body: (field_declaration_list)
  (#set! priority 110))
