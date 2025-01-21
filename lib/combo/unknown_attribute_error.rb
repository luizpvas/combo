# frozen_string_literal: true

module Combo
  class UnknownAttributeError < RuntimeError
    def initialize(component_class, attribute_name)
      super <<~TEXT.squish
        Unknown attribute #{attribute_name} for component #{component_class}
      TEXT
    end
  end
end