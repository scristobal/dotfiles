; extends

(variable_declaration (simple_identifier) @variable.declaration
  (#set! priority 110))

(parameter (simple_identifier) @variable.parameter.declaration
  (#set! priority 110))

(parameter_with_optional_type (simple_identifier) @variable.parameter.declaration
  (#set! priority 110))

(class_parameter (simple_identifier) @variable.parameter.declaration
  (#set! priority 110))

(class_declaration (type_identifier) @type.definition
  (#set! priority 110))
