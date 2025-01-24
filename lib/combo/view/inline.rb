# frozen_string_literal: true

module Combo::View
  class Inline
    attr_reader :template

    def initialize(template)
      @template = template
      @pending_helpers_initialization = true
    end

    def render(component)
      if @pending_helpers_initialization
        component.class.helper_method(component.class.instance_methods(false))

        @pending_helpers_initialization = false
      end

      component.render_to_string(inline: @template)
    end
  end
end
