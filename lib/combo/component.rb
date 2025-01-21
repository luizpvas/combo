# frozen_string_literal: true

module Combo
  class Component
    class << self
      def attribute(name, type=nil)
        if attributes_types.key?(name)
          raise ArgumentError("attribute #{name} is already defined in this component")
        end

        attributes_types[name] = type

        class_eval <<-CODE, __FILE__, __LINE__ + 1
          def #{name}
            @attributes[:#{name}]
          end
        CODE
      end

      def attributes_types
        @attributes_types ||= {}
      end
    end

    def initialize(**attributes)
      attributes.each do |attribute_name, _value|
        if !self.class.attributes_types.key?(attribute_name)
          raise Combo::UnknownAttributeError.new(self.class.name, attribute_name)
        end
      end

      @attributes = attributes
    end
  end
end
