# frozen_string_literal: true

module Combo::Component::View
  class Inline
    attr_reader :template

    def initialize(template)
      @template = template
    end

    def render_to_string(component)
      component.render_to_string(inline: @template)
    end
  end
end
