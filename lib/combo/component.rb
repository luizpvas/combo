# frozen_string_literal: true

class Combo::Component < ActionController::Base
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

        def #{name}=(value)
          @attributes[:#{name}] = value
        end
      CODE
    end

    def attributes_types
      @attributes_types ||= {}
    end

    def view(template)
      @view = View::Inline.new(template)
    end
  end

  attr_reader :uuid, :attributes

  def initialize(**attributes)
    @uuid = SecureRandom.uuid

    attributes.each do |attribute_name, _value|
      if !self.class.attributes_types.key?(attribute_name)
        raise Combo::UnknownAttributeError.new(self.class.name, attribute_name)
      end
    end

    @attributes = attributes
  end

  def dom_id
    @uuid
  end

  def build_action(method_name)
    Action.build(component: self, method_name:)
  end

  def action(method_name)
    build_action(method_name).url
  end

  def render_view_to_string
    if first_render_call?
      add_component_instance_methods_as_view_helpers
    end

    self.class.instance_variable_get(:@view).render_to_string(self)
  end

  def browser
    @browser ||= Browser.new(self)
  end

  def action_missing(_action)
    render html: render_view_to_string
  end

  private
    def first_render_call?
      return false if defined?(@first_render_call)

      @first_render_call = true and return true
    end

    def add_component_instance_methods_as_view_helpers
      self.class.helper_method(self.class.instance_methods(false))
    end
end
