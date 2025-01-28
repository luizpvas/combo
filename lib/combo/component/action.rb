# frozen_string_literal: true

class Combo::Component::Action
  attr_reader :component_class, :method_name, :attributes

  class << self
    def decode(encoded_value)
      serialized_value = message_verifier.verify(encoded_value)
      action_arguments = ActiveJob::Arguments.deserialize(serialized_value)

      new(**action_arguments.to_h)
    end

    def build(component:, method_name:)
      new(
        component_class: component.class,
        attributes: component.attributes,
        method_name:,
      )
    end

    def message_verifier
      Rails.application.message_verifier(:combo_component_action)
    end
  end

  def initialize(component_class:, attributes:, method_name:)
    @component_class = component_class
    @method_name = method_name
    @attributes = attributes
  end

  def encode
    serialized = ActiveJob::Arguments.serialize({ component_class:, method_name:, attributes: })

    self.class.message_verifier.generate(serialized)
  end


  def url
    Combo::Engine.routes.url_helpers.component_action_executions_path(encoded: encode)
  end

  def ==(other)
    inspect == other.inspect
  end

  def inspect
    "#<#{self.class.name} #{component_class}##{method_name} [#{attributes.keys.inspect}]>"
  end
end
