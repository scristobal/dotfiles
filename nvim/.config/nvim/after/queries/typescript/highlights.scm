; extends

(required_parameter pattern: (identifier) @variable.parameter.declaration
  (#set! priority 110))

(optional_parameter pattern: (identifier) @variable.parameter.declaration
  (#set! priority 110))

(interface_declaration name: (type_identifier) @type.definition
  (#set! priority 110))

(type_alias_declaration name: (type_identifier) @type.definition
  (#set! priority 110))
